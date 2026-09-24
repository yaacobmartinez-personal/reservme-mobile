import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../domain/run_sheet.dart';
import '../domain/today_repository.dart';

/// In-memory [TodayRepository], ported from the web `getRunSheet` /
/// `getVenueStats` and `booking-actions.ts`.
///
/// "Today" is the venue's own calendar day, not the phone's — a venue in
/// Madrid and a phone in Manila must agree on which bookings are today's.
class FakeTodayRepository implements TodayRepository {
  FakeTodayRepository(this._store, this._latency, this._clock, this._offline);

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  FakeVenue _venue(String slug) {
    final v = _store.venueBySlug(slug);
    if (v == null) throw ApiError(404, 'We could not find that venue.');
    return v;
  }

  @override
  Future<TodayView> today(String venueSlug) async {
    await _tick();
    final venue = _venue(venueSlug);
    final zone = venue.timezone;
    final now = _clock();
    final date = AppTime.today(now, zone);

    final rows = _store
        .reservationsOf(venue.id)
        .where((r) =>
            r.status.isLive &&
            r.kind != ReservationKind.sessionSeat &&
            AppTime.localDate(r.startsAt, zone) == date)
        .toList()
      ..sort((a, b) {
        final byTime = a.startsAt.compareTo(b.startsAt);
        if (byTime != 0) return byTime;
        final sa = _store.spaceById(a.spaceId)?.sortOrder ?? 0;
        final sb = _store.spaceById(b.spaceId)?.sortOrder ?? 0;
        return sa.compareTo(sb);
      });

    final entries = [for (final r in rows) _entry(r, zone)];

    // The stats count what was *sold* — rentals and session seats — exactly as
    // the web's getVenueStats does (`kind IN ('rental','session_seat')`). The
    // run sheet above is the other way round: it rolls the seats up into their
    // session's one line, because that is what the desk reads.
    final allLive = _store.reservationsOf(venue.id).where((r) =>
        r.status.isLive && r.kind != ReservationKind.sessionBlock);
    final todays = allLive.where((r) => AppTime.localDate(r.startsAt, zone) == date);

    return TodayView(
      date: date,
      stats: VenueStats(
        todayCount: todays.length,
        checkedIn: todays.where((r) => r.checkedInAt != null).length,
        upcomingCount: allLive.where((r) => r.startsAt.isAfter(now)).length,
        activeSpaces: _store.spacesOf(venue.id, activeOnly: true).length,
        totalSpaces: _store.spacesOf(venue.id).length,
        todayRevenueCents: todays
            .where((r) => r.status == ReservationStatus.confirmed)
            .fold(0, (sum, r) => sum + r.amountCents),
      ),
      runSheet: entries,
    );
  }

  @override
  Future<RunSheetEntry> checkIn(String venueSlug, String bookingId, {DateTime? at}) =>
      _mutate(venueSlug, bookingId, (r, venue) {
        if (r.status != ReservationStatus.confirmed) {
          throw ApiError(409, 'That booking is no longer confirmed.');
        }
        // The server clamps a supplied time into the booking's own window.
        final now = _clock();
        final when = at ?? now;
        r.checkedInAt = when.isAfter(now) ? now : when;
      });

  @override
  Future<RunSheetEntry> undoCheckIn(String venueSlug, String bookingId) =>
      _mutate(venueSlug, bookingId, (r, venue) => r.checkedInAt = null);

  @override
  Future<RunSheetEntry> noShow(String venueSlug, String bookingId) =>
      _mutate(venueSlug, bookingId, (r, venue) {
        if (r.status == ReservationStatus.noShow) return;
        r.status = ReservationStatus.noShow;
        r.checkedInAt = null;
        // A no-show counts against the customer, as on the web.
        final customer = r.customerId == null ? null : _store.customerById(r.customerId!);
        if (customer != null) customer.noShowCount += 1;
      });

  @override
  Future<RunSheetEntry> cancel(String venueSlug, String bookingId) =>
      _mutate(venueSlug, bookingId, (r, venue) {
        if (r.status == ReservationStatus.cancelled) return;
        r.status = ReservationStatus.cancelled;
        r.cancelledAt = _clock();
        // A session seat returns its spot.
        if (r.sessionId != null) {
          final session = _store.sessionById(r.sessionId!);
          if (session != null) {
            session.bookedSpots =
                (session.bookedSpots - r.partySize).clamp(0, session.capacity);
          }
        }
      });

  Future<RunSheetEntry> _mutate(
    String venueSlug,
    String bookingId,
    void Function(FakeReservation r, FakeVenue venue) apply,
  ) async {
    await _tick();
    final venue = _venue(venueSlug);
    final r = _store.reservationById(bookingId);
    if (r == null || r.venueId != venue.id) {
      throw ApiError(404, 'We could not find that booking.');
    }
    apply(r, venue);
    return _entry(r, venue.timezone);
  }

  RunSheetEntry _entry(FakeReservation r, String zone) {
    final space = _store.spaceById(r.spaceId);
    final customer = r.customerId == null ? null : _store.customerById(r.customerId!);
    final session = r.sessionId == null ? null : _store.sessionById(r.sessionId!);

    // How many bookings this customer has had here before today.
    final visits = customer == null
        ? 0
        : _store
            .reservationsOf(r.venueId)
            .where((o) =>
                o.customerId == customer.id &&
                o.id != r.id &&
                o.status != ReservationStatus.cancelled)
            .length;

    return RunSheetEntry(
      id: r.id,
      reference: r.reference,
      spaceName: space?.name ?? 'Space',
      customerId: customer?.id,
      customerName: customer?.name ?? session?.title,
      customerPhone: customer?.phone,
      label: AppTime.formatRange(r.startsAt, r.endsAt, zone),
      startsAt: r.startsAt,
      endsAt: r.endsAt,
      status: r.status,
      kind: r.kind,
      partySize: r.partySize,
      amountCents: r.amountCents,
      checkedInAt: r.checkedInAt,
      noShowCount: customer?.noShowCount ?? 0,
      firstVisit: customer != null && visits == 0,
      sessionCapacity: session?.capacity,
      sessionBooked: session?.bookedSpots,
    );
  }
}
