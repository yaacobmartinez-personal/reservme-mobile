import 'package:freezed_annotation/freezed_annotation.dart';

part 'insights.freezed.dart';
part 'insights.g.dart';

/// G5 · Insights (API-CONTRACT #33), ported from `src/lib/analytics.ts`.
///
/// Two rules run through all of it, and they are easy to get subtly wrong:
///
/// * Every bucket, hour and "today" is computed in the **venue's** timezone,
///   never UTC — the same rule the run sheet follows.
/// * Kinds do different jobs. `rental` and `session_seat` are what customers
///   book, so they drive counts and value; `rental` and `session_block` are
///   what occupy the space, so they drive utilisation. Counting seats as
///   occupancy would show a full court as over-booked.
///
/// In the pay-at-venue model `amountCents` on a confirmed booking is **booked
/// value**, not collected cash, and the screen says so rather than implying
/// the money has arrived.
enum InsightsRange {
  @JsonValue('today')
  today('today', 'Today', 1),
  @JsonValue('7d')
  week('7d', '7 days', 7),
  @JsonValue('30d')
  month('30d', '30 days', 30),
  @JsonValue('90d')
  quarter('90d', '90 days', 90);

  const InsightsRange(this.wire, this.label, this.days);

  final String wire;
  final String label;
  final int days;

  /// `rangeDays`: an unknown period falls back to 30 days rather than
  /// throwing, because it arrives from a query string.
  static InsightsRange fromWire(String? wire) => values.firstWhere(
        (r) => r.wire == wire,
        orElse: () => InsightsRange.month,
      );
}

@freezed
abstract class Insights with _$Insights {
  const Insights._();

  const factory Insights({
    @Default(InsightsRange.month) InsightsRange range,
    @Default(Kpi()) Kpi bookedValueCents,
    @Default(Kpi()) Kpi bookings,

    /// Percent, one decimal.
    @Default(Kpi()) Kpi utilisationPct,
    @Default(Kpi()) Kpi noShowRatePct,
    @Default(<DayPoint>[]) List<DayPoint> bookedByDay,

    /// `[weekday 0..6][hour 0..23]` counts, Sunday first like the column.
    @Default(<List<int>>[]) List<List<int>> peakHours,
    @Default(BookingMix()) BookingMix mix,
    @Default(<SpaceValue>[]) List<SpaceValue> bySpace,
    @Default(CustomerMix()) CustomerMix customers,
    @Default(NeedsYou()) NeedsYou needsYou,
  }) = _Insights;

  factory Insights.fromJson(Map<String, dynamic> json) =>
      _$InsightsFromJson(json);

  /// True when the window has nothing in it at all — worth saying plainly
  /// rather than drawing four empty charts.
  bool get isEmpty => bookings.value == 0 && bookedValueCents.value == 0;

  /// The busiest count in the heatmap, so the grid can scale to it.
  int get peakMax => peakHours.fold(
        0,
        (best, row) => row.fold(best, (b, n) => n > b ? n : b),
      );
}

/// A number now, the same number over the window before it, and the daily
/// series behind it.
@freezed
abstract class Kpi with _$Kpi {
  const Kpi._();

  const factory Kpi({
    @Default(0) num value,
    @Default(0) num previous,

    /// Null when there is no baseline — a jump from zero is not "+∞%", it is
    /// simply the first of something.
    double? deltaPct,
    @Default(<num>[]) List<num> series,
  }) = _Kpi;

  factory Kpi.fromJson(Map<String, dynamic> json) => _$KpiFromJson(json);

  /// `delta()`: one decimal place, or null against a zero baseline.
  static double? delta(num value, num previous) {
    if (previous == 0) return null;
    return ((value - previous) / previous * 1000).round() / 10;
  }

  bool get isUp => (deltaPct ?? 0) > 0;
  bool get isDown => (deltaPct ?? 0) < 0;

  /// Whether the change is good news, bad news, or neither.
  ///
  /// Null covers both cases where a verdict would be wrong: no baseline to
  /// compare against, and **no change at all**. A flat month is not a fall,
  /// and colouring it as one tells an owner their takings dropped when they
  /// did not move.
  bool? isGood({bool lowerIsBetter = false}) {
    final delta = deltaPct;
    if (delta == null || delta == 0) return null;
    return lowerIsBetter ? delta < 0 : delta > 0;
  }
}

@freezed
abstract class DayPoint with _$DayPoint {
  const factory DayPoint({
    /// Venue-local "YYYY-MM-DD".
    required String day,
    @Default(0) int cents,
    @Default(0) double utilisationPct,
  }) = _DayPoint;

  factory DayPoint.fromJson(Map<String, dynamic> json) =>
      _$DayPointFromJson(json);
}

@freezed
abstract class BookingMix with _$BookingMix {
  const BookingMix._();

  const factory BookingMix({
    @Default(0) int confirmed,
    @Default(0) int cancelled,
    @Default(0) int noShow,
  }) = _BookingMix;

  factory BookingMix.fromJson(Map<String, dynamic> json) =>
      _$BookingMixFromJson(json);

  int get total => confirmed + cancelled + noShow;
}

@freezed
abstract class SpaceValue with _$SpaceValue {
  const factory SpaceValue({
    required String spaceId,
    required String name,
    @Default(0) int cents,
  }) = _SpaceValue;

  factory SpaceValue.fromJson(Map<String, dynamic> json) =>
      _$SpaceValueFromJson(json);
}

@freezed
abstract class CustomerMix with _$CustomerMix {
  const factory CustomerMix({
    @Default(0) int newCount,
    @Default(0) int returningCount,
    @Default(0) int repeatRatePct,
    @Default(<TopCustomer>[]) List<TopCustomer> top,
  }) = _CustomerMix;

  factory CustomerMix.fromJson(Map<String, dynamic> json) =>
      _$CustomerMixFromJson(json);
}

@freezed
abstract class TopCustomer with _$TopCustomer {
  const factory TopCustomer({
    required String customerId,
    required String name,
    @Default(0) int bookings,
  }) = _TopCustomer;

  factory TopCustomer.fromJson(Map<String, dynamic> json) =>
      _$TopCustomerFromJson(json);
}

/// The one part of the screen that is a to-do list rather than a number.
///
/// The web also counts payments awaiting settlement; the app has no payment
/// records to count, because v1 is pay-at-venue, so that tile is left out
/// rather than shown as a permanent zero.
@freezed
abstract class NeedsYou with _$NeedsYou {
  const NeedsYou._();

  const factory NeedsYou({
    @Default(0) int toCheckIn,
    @Default(<HalfEmptySession>[]) List<HalfEmptySession> halfEmptySessions,
  }) = _NeedsYou;

  factory NeedsYou.fromJson(Map<String, dynamic> json) =>
      _$NeedsYouFromJson(json);

  bool get isEmpty => toCheckIn == 0 && halfEmptySessions.isEmpty;
}

@freezed
abstract class HalfEmptySession with _$HalfEmptySession {
  const factory HalfEmptySession({
    required String id,
    required String title,
    required DateTime startsAt,
    @Default(0) int spotsLeft,
    @Default(0) int capacity,
  }) = _HalfEmptySession;

  factory HalfEmptySession.fromJson(Map<String, dynamic> json) =>
      _$HalfEmptySessionFromJson(json);
}

abstract class InsightsRepository {
  Future<Insights> get(String venueSlug, InsightsRange range);
}
