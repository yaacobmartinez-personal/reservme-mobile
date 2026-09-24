import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../domain/insights.dart';

/// In-memory [InsightsRepository], ported from `getDashboard` in
/// `src/lib/analytics.ts`.
///
/// Every bucket is a venue-local date, and the two windows are the last
/// `days` days and the `days` before that — the same `span = days * 2` the
/// SQL uses so deltas have something to compare against.
class FakeInsightsRepository implements InsightsRepository {
  FakeInsightsRepository(this._store, this._latency, this._clock, this._offline);

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;

  /// What customers book: counts and value.
  static const _booked = {ReservationKind.rental, ReservationKind.sessionSeat};

  /// What occupies the space: utilisation.
  static const _occupies = {
    ReservationKind.rental,
    ReservationKind.sessionBlock,
  };

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  @override
  Future<Insights> get(String venueSlug, InsightsRange range) async {
    await _tick();
    final venue = _store.venueBySlug(venueSlug);
    if (venue == null) throw ApiError(404, 'We could not find that venue.');

    final now = _clock();
    final zone = venue.timezone;
    final days = range.days;
    final today = AppTime.today(now, zone);

    // Oldest first, current window last, exactly like the generate_series.
    final span = days * 2;
    final dates = [
      for (var i = span - 1; i >= 0; i--) AppTime.addDays(today, -i, zone),
    ];
    final previousDates = dates.take(days).toList();
    final currentDates = dates.skip(days).toList();

    final reservations = _store.reservationsOf(venue.id).toList();
    final spaces = _store.spacesOf(venue.id).toList();

    String dayOf(DateTime instant) => AppTime.localDate(instant, zone);

    // ── per-day buckets ──────────────────────────────────────────────────
    final valueByDay = <String, int>{for (final d in dates) d: 0};
    final confirmedByDay = <String, int>{for (final d in dates) d: 0};
    final noShowByDay = <String, int>{for (final d in dates) d: 0};
    final cancelledByDay = <String, int>{for (final d in dates) d: 0};
    final bookedHoursByDay = <String, double>{for (final d in dates) d: 0};

    for (final r in reservations) {
      final day = dayOf(r.startsAt);
      if (!valueByDay.containsKey(day)) continue;

      if (_booked.contains(r.kind)) {
        switch (r.status) {
          case ReservationStatus.confirmed:
            valueByDay[day] = valueByDay[day]! + r.amountCents;
            confirmedByDay[day] = confirmedByDay[day]! + 1;
          case ReservationStatus.noShow:
            noShowByDay[day] = noShowByDay[day]! + 1;
          case ReservationStatus.cancelled:
            cancelledByDay[day] = cancelledByDay[day]! + 1;
          case ReservationStatus.held:
            break;
        }
      }
      if (_occupies.contains(r.kind) &&
          r.status == ReservationStatus.confirmed) {
        bookedHoursByDay[day] = bookedHoursByDay[day]! +
            r.endsAt.difference(r.startsAt).inMinutes / 60;
      }
    }

    // Bookable hours come from opening hours on *active* spaces, and — like
    // the web — deliberately ignore closures: a court shut for repairs still
    // counts as capacity you chose not to sell.
    final bookableByDay = <String, double>{
      for (final d in dates) d: _bookableHours(spaces, d, zone),
    };

    double sumHours(List<String> window, Map<String, double> from) =>
        window.fold(0, (t, d) => t + from[d]!);
    int sumInts(List<String> window, Map<String, int> from) =>
        window.fold(0, (t, d) => t + from[d]!);

    double utilisation(List<String> window) {
      final booked = sumHours(window, bookedHoursByDay);
      final bookable = sumHours(window, bookableByDay);
      if (bookable <= 0) return 0;
      return _round1((booked / bookable * 100).clamp(0, 100));
    }

    double noShowRate(List<String> window) {
      final noShows = sumInts(window, noShowByDay);
      final denominator = sumInts(window, confirmedByDay) + noShows;
      if (denominator == 0) return 0;
      return _round1(noShows / denominator * 100);
    }

    final currentValue = sumInts(currentDates, valueByDay);
    final previousValue = sumInts(previousDates, valueByDay);
    final currentBookings = sumInts(currentDates, confirmedByDay);
    final previousBookings = sumInts(previousDates, confirmedByDay);
    final currentUtil = utilisation(currentDates);
    final previousUtil = utilisation(previousDates);
    final currentNoShow = noShowRate(currentDates);
    final previousNoShow = noShowRate(previousDates);

    double dayUtilisation(String d) {
      final bookable = bookableByDay[d]!;
      if (bookable <= 0) return 0;
      return _round1((bookedHoursByDay[d]! / bookable * 100).clamp(0, 100));
    }

    // ── heatmap: when people actually book, current window only ──────────
    final heat = [for (var d = 0; d < 7; d++) List.filled(24, 0)];
    for (final r in reservations) {
      if (!_booked.contains(r.kind)) continue;
      if (r.status != ReservationStatus.confirmed &&
          r.status != ReservationStatus.noShow) {
        continue;
      }
      final day = dayOf(r.startsAt);
      if (!currentDates.contains(day)) continue;
      final local = AppTime.inZone(r.startsAt, zone);
      heat[local.weekday % 7][local.hour] += 1;
    }

    // ── value by space, biggest first, zeroes included ───────────────────
    final bySpace = [
      for (final s in spaces)
        SpaceValue(
          spaceId: s.id,
          name: s.name,
          cents: reservations
              .where((r) =>
                  r.spaceId == s.id &&
                  r.status == ReservationStatus.confirmed &&
                  _booked.contains(r.kind) &&
                  currentDates.contains(dayOf(r.startsAt)))
              .fold(0, (t, r) => t + r.amountCents),
        ),
    ]..sort((a, b) => b.cents.compareTo(a.cents));

    return Insights(
      range: range,
      bookedValueCents: Kpi(
        value: currentValue,
        previous: previousValue,
        deltaPct: Kpi.delta(currentValue, previousValue),
        series: [for (final d in currentDates) valueByDay[d]!],
      ),
      bookings: Kpi(
        value: currentBookings,
        previous: previousBookings,
        deltaPct: Kpi.delta(currentBookings, previousBookings),
        series: [for (final d in currentDates) confirmedByDay[d]!],
      ),
      utilisationPct: Kpi(
        value: currentUtil,
        previous: previousUtil,
        deltaPct: Kpi.delta(currentUtil, previousUtil),
        series: [for (final d in currentDates) dayUtilisation(d)],
      ),
      noShowRatePct: Kpi(
        value: currentNoShow,
        previous: previousNoShow,
        deltaPct: Kpi.delta(currentNoShow, previousNoShow),
        series: [
          for (final d in currentDates)
            () {
              final denominator = confirmedByDay[d]! + noShowByDay[d]!;
              return denominator == 0
                  ? 0.0
                  : _round1(noShowByDay[d]! / denominator * 100);
            }(),
        ],
      ),
      bookedByDay: [
        for (final d in currentDates)
          DayPoint(day: d, cents: valueByDay[d]!, utilisationPct: dayUtilisation(d)),
      ],
      peakHours: heat,
      mix: BookingMix(
        confirmed: currentBookings,
        cancelled: sumInts(currentDates, cancelledByDay),
        noShow: sumInts(currentDates, noShowByDay),
      ),
      bySpace: bySpace,
      customers: _customers(venue, reservations, currentDates, zone, now),
      needsYou: _needsYou(venue, reservations, today, zone, now),
    );
  }

  /// Opening hours on active spaces for one weekday, in hours.
  double _bookableHours(List<FakeSpace> spaces, String date, String zone) {
    final weekday = AppTime.weekday(date, zone);
    var total = 0.0;
    for (final space in spaces) {
      if (!space.isActive) continue;
      for (final h in _store.hoursOf(space.id)) {
        if (h.weekday != weekday) continue;
        final opens = AppTime.minutesOfDay(h.opensAt);
        final closes = AppTime.minutesOfDay(h.closesAt);
        if (opens == null || closes == null || closes <= opens) continue;
        total += (closes - opens) / 60;
      }
    }
    return total;
  }

  CustomerMix _customers(
    FakeVenue venue,
    List<FakeReservation> reservations,
    List<String> window,
    String zone,
    DateTime now,
  ) {
    final bookedInWindow = <String, int>{};
    for (final r in reservations) {
      if (r.customerId == null) continue;
      if (r.status != ReservationStatus.confirmed) continue;
      if (!_booked.contains(r.kind)) continue;
      if (!window.contains(AppTime.localDate(r.startsAt, zone))) continue;
      bookedInWindow.update(r.customerId!, (n) => n + 1, ifAbsent: () => 1);
    }

    // "Returning" means they had a confirmed booking *before* this window,
    // not merely more than one inside it.
    final earlier = <String>{
      for (final r in reservations)
        if (r.customerId != null &&
            r.status == ReservationStatus.confirmed &&
            !window.contains(AppTime.localDate(r.startsAt, zone)) &&
            r.startsAt.isBefore(_startOf(window, zone)))
          r.customerId!,
    };

    final returning =
        bookedInWindow.keys.where(earlier.contains).length;
    final total = bookedInWindow.length;

    final top = bookedInWindow.entries
        .map((e) => TopCustomer(
              customerId: e.key,
              name: _store.customerById(e.key)?.name ?? 'Someone',
              bookings: e.value,
            ))
        .toList()
      ..sort((a, b) {
        final byCount = b.bookings.compareTo(a.bookings);
        return byCount != 0 ? byCount : a.name.compareTo(b.name);
      });

    return CustomerMix(
      newCount: _store
          .customersOf(venue.id)
          .where((c) => window.contains(AppTime.localDate(c.createdAt, zone)))
          .length,
      returningCount: returning,
      repeatRatePct: total == 0 ? 0 : (returning / total * 100).round(),
      top: top.take(5).toList(),
    );
  }

  DateTime _startOf(List<String> window, String zone) =>
      AppTime.startOfLocalDay(window.first, zone) ?? DateTime.utc(1970);

  NeedsYou _needsYou(
    FakeVenue venue,
    List<FakeReservation> reservations,
    String today,
    String zone,
    DateTime now,
  ) =>
      NeedsYou(
        toCheckIn: reservations
            .where((r) =>
                r.status == ReservationStatus.confirmed &&
                _booked.contains(r.kind) &&
                r.checkedInAt == null &&
                AppTime.localDate(r.startsAt, zone) == today)
            .length,
        // Less than half sold, and still ahead of us — the ones worth
        // pushing today.
        halfEmptySessions: [
          for (final s in _store.sessionsOf(venue.id))
            if (!s.cancelled &&
                s.startsAt.isAfter(now) &&
                s.bookedSpots * 2 < s.capacity)
              HalfEmptySession(
                id: s.id,
                title: s.title,
                startsAt: s.startsAt,
                spotsLeft: s.spotsLeft,
                capacity: s.capacity,
              ),
        ]..sort((a, b) => a.startsAt.compareTo(b.startsAt)),
      );

  static double _round1(num v) => (v * 10).round() / 10;
}
