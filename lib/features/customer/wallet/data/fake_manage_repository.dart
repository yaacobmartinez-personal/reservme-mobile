import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/money/money.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../../booking/data/booking_mapper.dart';
import '../../booking/data/fake_availability.dart';
import '../../booking/domain/booking.dart';
import '../domain/manage_repository.dart';

/// In-memory [ManageRepository]. The cancellation policy is re-derived here
/// exactly as the server re-derives it — the app's own copy in
/// `cancelEligibility` is only for rendering.
class FakeManageRepository implements ManageRepository {
  FakeManageRepository(this._store, this._latency, this._clock, this._offline);

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  (FakeVenue, FakeReservation) _resolve(String venueSlug, String token) {
    final venue = _store.venueBySlug(venueSlug);
    if (venue == null) throw ApiError(404, 'This link is no longer valid.');
    final r = _store.reservationByToken(venue.id, token);
    if (r == null) throw ApiError(404, 'This link is no longer valid.');
    return (venue, r);
  }

  @override
  Future<Booking> byToken({required String venueSlug, required String token}) async {
    await _tick();
    final (_, r) = _resolve(venueSlug, token);
    return bookingFrom(_store, r, now: _clock(), includeToken: true);
  }

  @override
  Future<CancelOutcome> cancel({required String venueSlug, required String token}) async {
    await _tick();
    final (venue, r) = _resolve(venueSlug, token);
    final now = _clock();
    final eligibility = cancelEligibility(
      status: r.status,
      startsAt: r.startsAt,
      mode: venue.cancellationMode,
      graceHours: venue.cancellationGraceHours,
      now: now,
    );
    if (!eligibility.canCancel) {
      return CancelRefused(eligibility.reason ?? 'This booking cannot be cancelled online.');
    }

    r.status = ReservationStatus.cancelled;
    r.cancelledAt = now;
    // A session seat returns its spot, like `cancelReservation`.
    if (r.sessionId != null) {
      final session = _store.sessionById(r.sessionId!);
      if (session != null) {
        session.bookedSpots = (session.bookedSpots - r.partySize).clamp(0, session.capacity);
      }
    }
    return Cancelled(bookingFrom(_store, r, now: now, includeToken: true));
  }

  @override
  Future<List<RescheduleDay>> rescheduleOptions({
    required String venueSlug,
    required String token,
    int days = 7,
  }) async {
    await _tick();
    final (venue, r) = _resolve(venueSlug, token);
    final space = _store.spaceById(r.spaceId)!;
    final zone = venue.timezone;
    final availability = FakeAvailability(_store, _clock);
    final start = AppTime.today(_clock(), zone);

    final out = <RescheduleDay>[];
    for (var i = 0; i < days; i++) {
      final date = AppTime.addDays(start, i, zone);
      final day = availability.forDate(venue: venue, space: space, date: date);
      final open = day.slots
          .where((s) => s.available && s.startsAt != r.startsAt)
          .toList(growable: false);
      if (open.isNotEmpty) out.add(RescheduleDay(date: date, slots: open));
    }
    return out;
  }

  @override
  Future<RescheduleOutcome> reschedule({
    required String venueSlug,
    required String token,
    required DateTime startsAt,
    required DateTime endsAt,
  }) async {
    await _tick();
    final (venue, r) = _resolve(venueSlug, token);
    final now = _clock();

    // Moving is a cancellation plus a booking, so the same policy applies.
    final eligibility = cancelEligibility(
      status: r.status,
      startsAt: r.startsAt,
      mode: venue.cancellationMode,
      graceHours: venue.cancellationGraceHours,
      now: now,
    );
    if (!eligibility.canCancel) {
      return RescheduleRefused(
        eligibility.reason ?? 'This booking cannot be changed online.',
      );
    }

    final space = _store.spaceById(r.spaceId)!;
    if (startsAt.isBefore(now.add(Duration(minutes: venue.minNoticeMinutes)))) {
      return const RescheduleRefused('That time is too soon to book online.');
    }
    if (startsAt.isAfter(now.add(Duration(days: venue.maxHorizonDays)))) {
      return const RescheduleRefused(
        'That date is further ahead than this venue takes bookings.',
      );
    }

    final buffer = Duration(minutes: space.bufferMinutes);
    final clash = _store
        .liveOverlapping(space.id, startsAt.subtract(buffer), endsAt.add(buffer))
        .where((other) => other.id != r.id)
        .isNotEmpty;
    if (clash) return const RescheduleSlotTaken();

    final zone = venue.timezone;
    final price = FakeAvailability(_store, _clock).priceFor(
      space,
      AppTime.localDate(startsAt, zone),
      AppTime.formatTime(startsAt, zone),
      zone,
    );
    r.startsAt = startsAt;
    r.endsAt = endsAt;
    r.amountCents = Money.forDuration(
      price,
      space.slotMinutes,
      endsAt.difference(startsAt).inMinutes,
    );
    return Rescheduled(bookingFrom(_store, r, now: now, includeToken: true));
  }
}
