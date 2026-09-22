import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../domain/availability.dart';

/// Slot generation for fake mode, ported from the web
/// `src/lib/booking/availability.ts`.
///
/// ```
/// candidate slots
///   = opening_hours (in venue tz)
///   − closures
///   − existing live reservations (incl. buffers)
///   − sessions occupying the space
///   ∩ [now + min_notice_minutes, now + max_horizon_days]
/// ```
///
/// Generated in *local* time and converted per slot, not stepped in UTC, so a
/// DST boundary does not drift the grid.
class FakeAvailability {
  FakeAvailability(this._store, this._clock);

  final FakeStore _store;
  final Clock _clock;

  DayAvailability forDate({
    required FakeVenue venue,
    required FakeSpace space,
    required String date,
  }) {
    final zone = venue.timezone;
    final now = _clock();
    final weekday = AppTime.weekday(date, zone);
    final hours = _store.hoursOf(space.id).where((h) => h.weekday == weekday).toList();

    final notBefore = now.add(Duration(minutes: venue.minNoticeMinutes));
    final notAfter = now.add(Duration(days: venue.maxHorizonDays));

    final slots = <Slot>[];
    for (final h in hours) {
      var cursor = AppTime.fromLocal(date, h.opensAt, zone);
      final close = AppTime.fromLocal(date, h.closesAt, zone);
      if (cursor == null || close == null) continue;

      while (cursor!.add(Duration(minutes: space.slotMinutes)).compareTo(close) <= 0) {
        final start = cursor;
        final end = start.add(Duration(minutes: space.slotMinutes));

        final reason = _reasonFor(
          venue: venue,
          space: space,
          start: start,
          end: end,
          notBefore: notBefore,
          notAfter: notAfter,
        );
        final price = priceFor(space, date, AppTime.formatTime(start, zone), zone);
        slots.add(Slot(
          startsAt: start,
          endsAt: end,
          label: AppTime.formatTime(start, zone),
          available: reason == SlotReason.open,
          reason: reason,
          priceCents: price,
          peak: price > space.priceCents,
        ));
        cursor = end;
      }
    }

    final sessions = [
      for (final s in _store.sessionsOf(venue.id))
        if (s.spaceId == space.id && AppTime.localDate(s.startsAt, zone) == date)
          SessionSummary(
            id: s.id,
            title: s.title,
            startsAt: s.startsAt,
            endsAt: s.endsAt,
            label: AppTime.formatRange(s.startsAt, s.endsAt, zone),
            capacity: s.capacity,
            bookedSpots: s.bookedSpots,
            pricePerPersonCents: s.pricePerPersonCents,
          ),
    ];

    return DayAvailability(date: date, slots: slots, sessions: sessions);
  }

  SlotReason _reasonFor({
    required FakeVenue venue,
    required FakeSpace space,
    required DateTime start,
    required DateTime end,
    required DateTime notBefore,
    required DateTime notAfter,
  }) {
    // A closure covering the venue or this space closes the slot.
    for (final c in _store.closuresOf(venue.id)) {
      if (c.spaceId != null && c.spaceId != space.id) continue;
      if (start.isBefore(c.endsAt) && end.isAfter(c.startsAt)) return SlotReason.closed;
    }
    // Buffers widen an existing booking on the way in, exactly as the web
    // folds them into `during`.
    final buffer = Duration(minutes: space.bufferMinutes);
    final taken = _store
        .liveOverlapping(space.id, start.subtract(buffer), end.add(buffer))
        .isNotEmpty;
    if (taken) return SlotReason.taken;
    if (start.isBefore(notBefore)) return SlotReason.tooSoon;
    if (start.isAfter(notAfter)) return SlotReason.tooFarAhead;
    return SlotReason.open;
  }

  /// A pricing rule for this weekday covering this local time wins; otherwise
  /// the space's base price.
  int priceFor(FakeSpace space, String date, String time, String zone) {
    final weekday = AppTime.weekday(date, zone);
    for (final r in _store.rulesOf(space.id)) {
      if (!r.weekdays.contains(weekday)) continue;
      if (time.compareTo(r.startsAt) >= 0 && time.compareTo(r.endsAt) < 0) {
        return r.priceCents;
      }
    }
    return space.priceCents;
  }
}
