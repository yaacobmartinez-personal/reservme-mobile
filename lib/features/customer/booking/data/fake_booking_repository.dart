import 'dart:math';

import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/money/money.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../domain/availability.dart';
import '../domain/booking.dart';
import '../domain/booking_repository.dart';
import 'booking_mapper.dart';
import 'fake_availability.dart';

/// In-memory [BookingRepository]. Enforces every rule the server enforces, so
/// a flow that works in fake mode works against Postgres: the no-overlap
/// constraint, notice and horizon, suspended venues, session capacity, and
/// the public rate limit.
class FakeBookingRepository implements BookingRepository {
  FakeBookingRepository(this._store, this._latency, this._clock, this._offline);

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;
  final _rnd = Random();

  /// The web limits public booking to 8 per IP / 40 per venue per 5 minutes.
  /// The device stands in for the IP here.
  static const _deviceLimit = 8;
  static const _window = Duration(minutes: 5);
  final _attempts = <DateTime>[];

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  @override
  Future<DayAvailability> availability({
    required String venueSlug,
    required String spaceId,
    required String date,
  }) async {
    await _tick();
    final venue = _store.venueBySlug(venueSlug);
    if (venue == null) throw ApiError(404, 'We could not find that venue.');
    final space = _store.spaceById(spaceId);
    if (space == null || space.venueId != venue.id) {
      throw ApiError(404, 'We could not find that space.');
    }
    return FakeAvailability(_store, _clock)
        .forDate(venue: venue, space: space, date: date);
  }

  @override
  Future<BookOutcome> book({
    required String venueSlug,
    required BookingInput input,
    String? idempotencyKey,
  }) async {
    await _tick();
    final venue = _store.venueBySlug(venueSlug);
    if (venue == null) throw ApiError(404, 'We could not find that venue.');
    if (venue.suspended) {
      return const VenueClosed('This venue is no longer taking bookings.');
    }

    final fieldErrors = input.validate();
    if (fieldErrors.isNotEmpty) {
      return BookingInvalid(fieldErrors, fieldErrors.values.first);
    }

    if (_rateLimited()) {
      return const RateLimited(
        'Too many booking attempts just now. Please wait a minute and try again.',
      );
    }

    // `validatePromo`, before anything is written, in its words.
    final promoCode = input.promo?.trim() ?? '';
    FakePromo? promo;
    if (promoCode.isNotEmpty) {
      promo = _store.promos
          .where((p) => p.venueId == venue.id && p.code.toLowerCase() == promoCode.toLowerCase())
          .firstOrNull;
      final reason = switch (promo) {
        null => "That promo code isn't recognised.",
        FakePromo(active: false) => 'That promo code is no longer active.',
        FakePromo(:final expiresAt?) when !expiresAt.isAfter(_clock()) =>
          'That promo code has expired.',
        FakePromo(:final maxUses?, :final uses) when uses >= maxUses =>
          'That promo code has been fully used.',
        _ => null,
      };
      if (reason != null) return BookingInvalid({'promo': reason}, reason);
    }

    final space = _store.spaceById(input.spaceId);
    if (space == null || space.venueId != venue.id || !space.isActive) {
      return const VenueClosed('That space is not taking bookings.');
    }

    final zone = venue.timezone;
    final now = _clock();
    final date = AppTime.localDate(input.startsAt, zone);
    final time = AppTime.formatTime(input.startsAt, zone);

    // Re-derive the placement rules the way `reserveSpace` does, rather than
    // trusting what the grid showed.
    if (input.startsAt.isBefore(now.add(Duration(minutes: venue.minNoticeMinutes)))) {
      return const VenueClosed('That time is too soon to book online.');
    }
    if (input.startsAt.isAfter(now.add(Duration(days: venue.maxHorizonDays)))) {
      return const VenueClosed('That date is further ahead than this venue takes bookings.');
    }
    for (final c in _store.closuresOf(venue.id)) {
      if (c.spaceId != null && c.spaceId != space.id) continue;
      if (input.startsAt.isBefore(c.endsAt) && input.endsAt.isAfter(c.startsAt)) {
        return const VenueClosed('The venue is closed at that time.');
      }
    }

    // The exclusion constraint: one live row per space per overlap.
    final buffer = Duration(minutes: space.bufferMinutes);
    final clash = _store
        .liveOverlapping(space.id, input.startsAt.subtract(buffer), input.endsAt.add(buffer))
        .isNotEmpty;
    if (clash) return const SlotTaken();

    final customer = _upsertCustomer(venue.id, input.name, input.email, input.phone);
    final minutes = input.endsAt.difference(input.startsAt).inMinutes;
    final price = FakeAvailability(_store, _clock).priceFor(space, date, time, zone);
    var amount = Money.forDuration(price, space.slotMinutes, minutes);

    // `applyBookingDiscounts`: the promo first, then a pass credit or a
    // membership discount on whatever is left.
    if (promo != null) {
      promo.uses += 1;
      final off = promo.kind == 'percent' ? (amount * promo.value) ~/ 100 : promo.value;
      amount = (amount - off.clamp(0, amount)).toInt();
    }
    amount = _redeem(venue.id, customer.id, amount, now);

    final reservation = FakeReservation(
      id: _store.nextId('r'),
      venueId: venue.id,
      spaceId: space.id,
      customerId: customer.id,
      startsAt: input.startsAt,
      endsAt: input.endsAt,
      partySize: input.partySize,
      amountCents: amount,
      reference: newReference(_rnd),
      manageToken: newToken(_rnd),
      createdAt: now,
    );
    _store.reservations.add(reservation);
    _store.outbox.add(FakeEmail(
      to: customer.email,
      kind: FakeEmailKind.confirmation,
      body: 'Your booking at ${venue.name} is confirmed. '
          'Manage it: reservme.pro/${venue.slug}/manage/${reservation.manageToken}',
      sentAt: now,
    ));

    return Booked(bookingFrom(_store, reservation, includeToken: true, now: now));
  }

  /// `redeemForBooking`: spend one credit from the soonest-expiring holding
  /// that has one, or else take the best active percentage off. A free slot
  /// never spends a credit.
  int _redeem(String venueId, String customerId, int amount, DateTime now) {
    if (amount <= 0) return amount;
    bool live(FakeHolding h) =>
        h.venueId == venueId &&
        h.customerId == customerId &&
        h.status == 'active' &&
        (h.expiresAt == null || h.expiresAt!.isAfter(now));

    final withCredit = _store.holdings.where((h) => live(h) && h.creditsRemaining > 0).toList()
      ..sort((a, b) {
        if (a.expiresAt == null) return 1;
        if (b.expiresAt == null) return -1;
        return a.expiresAt!.compareTo(b.expiresAt!);
      });
    if (withCredit.isNotEmpty) {
      withCredit.first.creditsRemaining -= 1;
      return 0;
    }

    final best = _store.holdings
        .where(live)
        .map((h) => _store.plans.where((p) => p.id == h.planId).firstOrNull?.discountPct ?? 0)
        .fold(0, (a, b) => a > b ? a : b);
    if (best <= 0) return amount;
    return amount - (amount * best) ~/ 100;
  }

  @override
  Future<BookOutcome> bookSession({
    required String venueSlug,
    required String sessionId,
    required int spots,
    required String name,
    required String email,
    String? phone,
    String? idempotencyKey,
  }) async {
    await _tick();
    final venue = _store.venueBySlug(venueSlug);
    if (venue == null) throw ApiError(404, 'We could not find that venue.');
    if (venue.suspended) {
      return const VenueClosed('This venue is no longer taking bookings.');
    }
    if (_rateLimited()) {
      return const RateLimited(
        'Too many booking attempts just now. Please wait a minute and try again.',
      );
    }
    final session = _store.sessionById(sessionId);
    if (session == null || session.venueId != venue.id || session.cancelled) {
      throw ApiError(404, 'We could not find that session.');
    }

    // The atomic conditional update: claim N spots or affect zero rows.
    if (session.bookedSpots + spots > session.capacity) return const SessionFull();
    session.bookedSpots += spots;

    final now = _clock();
    final customer = _upsertCustomer(venue.id, name, email, phone);
    final reservation = FakeReservation(
      id: _store.nextId('r'),
      venueId: venue.id,
      spaceId: session.spaceId,
      sessionId: session.id,
      customerId: customer.id,
      kind: ReservationKind.sessionSeat,
      startsAt: session.startsAt,
      endsAt: session.endsAt,
      partySize: spots,
      amountCents: session.pricePerPersonCents * spots,
      reference: newReference(_rnd),
      manageToken: newToken(_rnd),
      createdAt: now,
    );
    _store.reservations.add(reservation);
    return Booked(bookingFrom(_store, reservation, includeToken: true, now: now));
  }

  @override
  Future<void> joinWaitlist({
    required String venueSlug,
    required String spaceId,
    required DateTime startsAt,
    required DateTime endsAt,
    required String name,
    required String email,
    String? phone,
    String? idempotencyKey,
  }) async {
    await _tick();
    final venue = _store.venueBySlug(venueSlug);
    if (venue == null) throw ApiError(404, 'We could not find that venue.');
    final customer = _upsertCustomer(venue.id, name, email, phone);
    final already = _store.waitlistOf(venue.id).any((w) =>
        w.customerId == customer.id &&
        w.spaceId == spaceId &&
        w.startsAt == startsAt &&
        w.status == WaitlistStatus.waiting);
    if (already) return;
    _store.waitlist.add(FakeWaitlistEntry(
      id: _store.nextId('wl'),
      venueId: venue.id,
      spaceId: spaceId,
      customerId: customer.id,
      startsAt: startsAt,
      endsAt: endsAt,
      createdAt: _clock(),
    ));
  }

  bool _rateLimited() {
    final now = _clock();
    _attempts.removeWhere((a) => now.difference(a) > _window);
    if (_attempts.length >= _deviceLimit) return true;
    _attempts.add(now);
    return false;
  }

  /// Customers are per-venue and keyed by email, like the web upsert.
  FakeCustomer _upsertCustomer(String venueId, String name, String email, String? phone) {
    final existing = _store.customerByEmail(venueId, email);
    if (existing != null) {
      if (name.trim().isNotEmpty) existing.name = name.trim();
      if (phone != null && phone.trim().isNotEmpty) existing.phone = phone.trim();
      return existing;
    }
    final c = FakeCustomer(
      id: _store.nextId('c'),
      venueId: venueId,
      name: name.trim(),
      email: email.trim().toLowerCase(),
      phone: phone?.trim(),
      createdAt: _clock(),
    );
    _store.customers.add(c);
    return c;
  }
}
