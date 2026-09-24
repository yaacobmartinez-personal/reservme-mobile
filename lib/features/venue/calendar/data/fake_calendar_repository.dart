import 'dart:math';

import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../../../customer/booking/data/fake_availability.dart';
import '../../today/domain/run_sheet.dart';
import '../domain/calendar_day.dart';
import '../domain/calendar_repository.dart';
import '../domain/manual_booking_input.dart';

/// In-memory [CalendarRepository], ported from the web's
/// `src/app/app/calendar-actions.ts` and the staff path of
/// `src/lib/booking/{placement,reserve}.ts`.
///
/// The staff path relaxes **policy only** — the notice window, the booking
/// horizon, and the one-slot length limit. Every *physical* guarantee still
/// holds: the space must be active, inside opening hours, not closed, not on
/// top of a session, and not overlapping a live booking. Those are the rules
/// the database enforces, and no one gets to override them.
class FakeCalendarRepository implements CalendarRepository {
  FakeCalendarRepository(this._store, this._latency, this._clock, this._offline)
      : _availability = FakeAvailability(_store, _clock);

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;
  final FakeAvailability _availability;
  final _rnd = Random(7);

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  FakeVenue _venue(String slug) {
    final v = _store.venueBySlug(slug);
    if (v == null) throw ApiError(404, 'We could not find that venue.');
    return v;
  }

  // ---- read ---------------------------------------------------------------

  @override
  Future<CalendarDay> day(String venueSlug, String date) async {
    await _tick();
    final venue = _venue(venueSlug);
    final zone = venue.timezone;
    final spaces = _store.spacesOf(venue.id).toList();
    final weekday = AppTime.weekday(date, zone);

    final lanes = <CalendarLane>[];
    final opens = <String>{};

    for (final space in spaces) {
      for (final h in _store.hoursOf(space.id).where((h) => h.weekday == weekday)) {
        var cursor = h.opensAt;
        while (cursor.compareTo(h.closesAt) < 0) {
          opens.add(cursor);
          cursor = AppTime.addMinutesToTime(cursor, space.slotMinutes);
        }
      }

      final items = <CalendarItem>[];

      for (final r in _store.reservationsOf(venue.id)) {
        if (r.spaceId != space.id) continue;
        if (!r.status.isLive) continue;
        if (r.kind == ReservationKind.sessionSeat) continue;
        if (AppTime.localDate(r.startsAt, zone) != date) continue;

        final session = r.sessionId == null ? null : _store.sessionById(r.sessionId!);
        final customer = r.customerId == null ? null : _store.customerById(r.customerId!);
        items.add(CalendarItem(
          id: r.id,
          kind: session != null ? CalendarItemKind.session : CalendarItemKind.booking,
          startsAt: r.startsAt,
          endsAt: r.endsAt,
          label: AppTime.formatRange(r.startsAt, r.endsAt, zone),
          title: session?.title ?? customer?.name ?? 'Walk-in',
          subtitle: session != null
              ? '${session.bookedSpots} of ${session.capacity}'
              : null,
          customerId: customer?.id,
          reference: r.reference,
          status: r.status,
          checkedInAt: r.checkedInAt,
          amountCents: r.amountCents,
          partySize: r.partySize,
          noShowCount: customer?.noShowCount ?? 0,
          sessionCapacity: session?.capacity,
          sessionBooked: session?.bookedSpots,
        ));
      }

      // A closure is a block: it belongs to one space, or to the whole venue.
      for (final c in _store.closuresOf(venue.id)) {
        if (c.spaceId != null && c.spaceId != space.id) continue;
        if (AppTime.localDate(c.startsAt, zone) != date) continue;
        items.add(CalendarItem(
          id: c.id,
          kind: CalendarItemKind.block,
          startsAt: c.startsAt,
          endsAt: c.endsAt,
          label: AppTime.formatRange(c.startsAt, c.endsAt, zone),
          title: 'Blocked',
          subtitle: c.reason,
        ));
      }

      items.sort((a, b) => a.startsAt.compareTo(b.startsAt));
      lanes.add(CalendarLane(
        spaceId: space.id,
        spaceName: space.name,
        slotMinutes: space.slotMinutes,
        isActive: space.isActive,
        items: items,
      ));
    }

    // Anything booked outside opening hours (a staff booking may be) still
    // needs a row to sit on, or it would vanish from the grid.
    for (final lane in lanes) {
      for (final item in lane.items) {
        opens.add(AppTime.formatTime(item.startsAt, zone));
      }
    }

    final rows = opens.toList()..sort();
    return CalendarDay(date: date, rows: rows, lanes: lanes);
  }

  // ---- write --------------------------------------------------------------

  @override
  Future<RunSheetEntry> createBooking(
    String venueSlug,
    ManualBookingInput input,
  ) async {
    await _tick();
    final venue = _venue(venueSlug);

    final message = input.validate();
    if (message != null) throw ApiError(400, message);

    final space = _store.spaceById(input.spaceId);
    if (space == null || space.venueId != venue.id) {
      throw ApiError(404, 'That space no longer exists.');
    }

    final start = AppTime.fromLocal(input.date, input.time, venue.timezone);
    if (start == null) throw ApiError(400, "That start time isn't valid.");
    final minutes = space.slotMinutes * input.slotCount;
    final end = start.add(Duration(minutes: minutes));

    _validatePlacement(venue, space, start, end, minutes);

    final customer = _resolveCustomer(venue, input);

    // Priced per slot from the rules, like the engine's
    // `price_cents * minutes / slot_minutes`.
    var amount = 0;
    var cursor = start;
    while (cursor.isBefore(end)) {
      amount += _availability.priceFor(
        space,
        AppTime.localDate(cursor, venue.timezone),
        AppTime.formatTime(cursor, venue.timezone),
        venue.timezone,
      );
      cursor = cursor.add(Duration(minutes: space.slotMinutes));
    }

    final reservation = FakeReservation(
      id: _store.nextId('r'),
      venueId: venue.id,
      spaceId: space.id,
      customerId: customer.id,
      startsAt: start,
      endsAt: end,
      partySize: input.partySize,
      amountCents: amount,
      notes: input.notes?.trim(),
      reference: _reference(),
      manageToken: _token(),
      createdAt: _clock(),
    );
    _store.reservations.add(reservation);
    return _entry(reservation, venue.timezone);
  }

  @override
  Future<RunSheetEntry> move(
    String venueSlug,
    String bookingId, {
    required String spaceId,
    required String date,
    required String time,
  }) async {
    await _tick();
    final venue = _venue(venueSlug);
    final r = _store.reservationById(bookingId);
    if (r == null || r.venueId != venue.id || r.kind != ReservationKind.rental) {
      throw ApiError(404, 'We could not find what you were trying to book.');
    }
    if (!r.status.isLive) {
      throw ApiError(409, 'That booking is no longer confirmed.');
    }
    final space = _store.spaceById(spaceId);
    if (space == null || space.venueId != venue.id) {
      throw ApiError(404, 'That space no longer exists.');
    }

    final start = AppTime.fromLocal(date, time, venue.timezone);
    if (start == null) throw ApiError(400, "That start time isn't valid.");
    // A move keeps the booking's own length, repriced at the destination.
    final minutes = r.endsAt.difference(r.startsAt).inMinutes;
    final end = start.add(Duration(minutes: minutes));

    _validatePlacement(venue, space, start, end, minutes, ignoreId: r.id);

    var amount = 0;
    var cursor = start;
    while (cursor.isBefore(end)) {
      amount += _availability.priceFor(
        space,
        AppTime.localDate(cursor, venue.timezone),
        AppTime.formatTime(cursor, venue.timezone),
        venue.timezone,
      );
      cursor = cursor.add(Duration(minutes: space.slotMinutes));
    }

    r.spaceId = space.id;
    r.startsAt = start;
    r.endsAt = end;
    r.amountCents = amount;
    return _entry(r, venue.timezone);
  }

  @override
  Future<CalendarItem> block(String venueSlug, BlockInput input) async {
    await _tick();
    final venue = _venue(venueSlug);
    final message = input.validate();
    if (message != null) throw ApiError(400, message);

    if (input.spaceId != null) {
      final space = _store.spaceById(input.spaceId!);
      if (space == null || space.venueId != venue.id) {
        throw ApiError(404, 'That space no longer exists.');
      }
    }

    final start = AppTime.fromLocal(input.date, input.from, venue.timezone);
    final end = AppTime.fromLocal(input.date, input.to, venue.timezone);
    if (start == null || end == null) {
      throw ApiError(400, 'Please give a valid start and end.');
    }

    // Like the web, a block goes in even when something is already booked in
    // the window: it stops *new* bookings, it does not cancel existing ones.
    // The sheet warns about the overlap; the desk decides.
    final closure = FakeClosure(
      id: _store.nextId('cl'),
      venueId: venue.id,
      spaceId: input.spaceId,
      startsAt: start,
      endsAt: end,
      reason: input.reason?.trim().isEmpty ?? true ? null : input.reason!.trim(),
    );
    _store.closures.add(closure);

    return CalendarItem(
      id: closure.id,
      kind: CalendarItemKind.block,
      startsAt: start,
      endsAt: end,
      label: AppTime.formatRange(start, end, venue.timezone),
      title: 'Blocked',
      subtitle: closure.reason,
    );
  }

  @override
  Future<void> removeBlock(String venueSlug, String blockId) async {
    await _tick();
    final venue = _venue(venueSlug);
    final before = _store.closures.length;
    _store.closures.removeWhere((c) => c.id == blockId && c.venueId == venue.id);
    if (_store.closures.length == before) throw ApiError(404, 'Unknown block.');
  }

  @override
  Future<List<CustomerHit>> searchCustomers(String venueSlug, String query) async {
    await _tick();
    final venue = _venue(venueSlug);
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];

    final hits = _store
        .customersOf(venue.id)
        .where((c) =>
            c.name.toLowerCase().contains(q) ||
            c.email.toLowerCase().contains(q) ||
            (c.phone ?? '').toLowerCase().contains(q))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return [
      for (final c in hits.take(6))
        CustomerHit(
          id: c.id,
          name: c.name,
          email: c.email,
          phone: c.phone,
          visits: _store
              .reservationsOf(venue.id)
              .where((r) =>
                  r.customerId == c.id && r.status == ReservationStatus.confirmed)
              .length,
        ),
    ];
  }

  // ---- rules --------------------------------------------------------------

  /// `validatePlacement(placement, minutes, staff: true)` from the web, in the
  /// same order, so the desk sees the same refusal the server would give.
  void _validatePlacement(
    FakeVenue venue,
    FakeSpace space,
    DateTime start,
    DateTime end,
    int minutes, {
    String? ignoreId,
  }) {
    if (!space.isActive) {
      throw ApiError(409, "That space isn't taking bookings right now.");
    }
    // Staff may book any whole number of slots; the public path is one.
    if (minutes <= 0 || minutes % space.slotMinutes != 0) {
      throw ApiError(
        400,
        'That isn\'t a bookable slot for this space — it may have changed. '
        'Please pick again.',
      );
    }
    for (final c in _store.closuresOf(venue.id)) {
      if (c.spaceId != null && c.spaceId != space.id) continue;
      if (start.isBefore(c.endsAt) && end.isAfter(c.startsAt)) {
        throw ApiError(409, 'The venue is closed then.');
      }
    }
    for (final s in _store.sessionsOf(venue.id)) {
      if (s.spaceId != space.id) continue;
      if (start.isBefore(s.endsAt) && end.isAfter(s.startsAt)) {
        throw ApiError(
          409,
          "That slot has just been taken. Pick another and we'll hold it for you.",
          reason: 'slot_taken',
        );
      }
    }
    if (!_withinHours(space, start, end, venue.timezone)) {
      throw ApiError(409, "The venue isn't open then.");
    }
    // Notice and horizon are policy: staff are past them.

    final buffer = Duration(minutes: space.bufferMinutes);
    final clash = _store
        .liveOverlapping(space.id, start.subtract(buffer), end.add(buffer))
        .where((r) => r.id != ignoreId);
    if (clash.isNotEmpty) {
      throw ApiError(
        409,
        "That slot has just been taken. Pick another and we'll hold it for you.",
        reason: 'slot_taken',
      );
    }
  }

  bool _withinHours(FakeSpace space, DateTime start, DateTime end, String zone) {
    final date = AppTime.localDate(start, zone);
    final weekday = AppTime.weekday(date, zone);
    for (final h in _store.hoursOf(space.id).where((h) => h.weekday == weekday)) {
      final opens = AppTime.fromLocal(date, h.opensAt, zone);
      final closes = AppTime.fromLocal(date, h.closesAt, zone);
      if (opens == null || closes == null) continue;
      if (!start.isBefore(opens) && !end.isAfter(closes)) return true;
    }
    return false;
  }

  FakeCustomer _resolveCustomer(FakeVenue venue, ManualBookingInput input) {
    if ((input.customerId ?? '').isNotEmpty) {
      final c = _store.customerById(input.customerId!);
      if (c == null || c.venueId != venue.id) {
        throw ApiError(404, 'That customer no longer exists.');
      }
      return c;
    }
    // Returning customers match on (venue, email) exactly as the engine's
    // upsert does, so a repeat booking does not create a second row.
    final email = input.email!.trim().toLowerCase();
    final existing = _store.customerByEmail(venue.id, email);
    if (existing != null) {
      if ((input.phone ?? '').trim().isNotEmpty) existing.phone = input.phone!.trim();
      return existing;
    }
    final created = FakeCustomer(
      id: _store.nextId('c'),
      venueId: venue.id,
      name: input.name!.trim(),
      email: email,
      phone: (input.phone ?? '').trim().isEmpty ? null : input.phone!.trim(),
      createdAt: _clock(),
    );
    _store.customers.add(created);
    return created;
  }

  // ---- mapping ------------------------------------------------------------

  RunSheetEntry _entry(FakeReservation r, String zone) {
    final space = _store.spaceById(r.spaceId);
    final customer = r.customerId == null ? null : _store.customerById(r.customerId!);
    return RunSheetEntry(
      id: r.id,
      reference: r.reference,
      spaceName: space?.name ?? 'Space',
      customerId: customer?.id,
      customerName: customer?.name,
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
    );
  }

  static const _alphabet = '23456789ABCDEFGHJKLMNPQRSTUVWXYZ';

  String _reference() {
    String block(int n) =>
        List.generate(n, (_) => _alphabet[_rnd.nextInt(_alphabet.length)]).join();
    return '${block(3)}-${block(4)}';
  }

  String _token() => List.generate(
        32,
        (_) => _alphabet[_rnd.nextInt(_alphabet.length)],
      ).join().toLowerCase();
}
