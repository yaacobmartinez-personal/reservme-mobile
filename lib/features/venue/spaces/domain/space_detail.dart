import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';
import '../../../../core/model/opening_hours.dart';

part 'space_detail.freezed.dart';
part 'space_detail.g.dart';

/// G1 · the space editor's whole payload (API-CONTRACT #28/#29): the basics,
/// the week, the peak-price rules, the closures that touch this space, and the
/// sessions it runs.
///
/// Sessions are read-only in v1 (D17) — the screen explains them rather than
/// offering create/cancel.
@freezed
abstract class SpaceDetail with _$SpaceDetail {
  const SpaceDetail._();

  const factory SpaceDetail({
    required String id,
    required String name,
    required String slug,
    @Default(SpaceKind.court) SpaceKind kind,
    @Default(1) int capacity,
    @Default(60) int slotMinutes,
    @Default(0) int bufferMinutes,
    @Default(0) int priceCents,
    @Default(true) bool isActive,
    String? imageUrl,
    @Default(<DayHoursView>[]) List<DayHoursView> hours,
    @Default(<PricingRuleView>[]) List<PricingRuleView> pricingRules,
    @Default(<ClosureView>[]) List<ClosureView> closures,
    @Default(<SpaceSessionView>[]) List<SpaceSessionView> sessions,

    /// Live bookings still ahead of now — what a delete would strand.
    @Default(0) int upcomingBookings,
  }) = _SpaceDetail;

  factory SpaceDetail.fromJson(Map<String, dynamic> json) =>
      _$SpaceDetailFromJson(json);

  /// The week as the editor's grid wants it: seven days, closed where the
  /// server has no row.
  HoursInput get week => HoursInput([
        for (var weekday = 0; weekday < 7; weekday++)
          _dayOf(weekday) ?? DayHours(weekday: weekday, open: false),
      ]);

  DayHours? _dayOf(int weekday) {
    final row = hours.where((h) => h.weekday == weekday).firstOrNull;
    if (row == null) return null;
    return DayHours(
      weekday: weekday,
      open: true,
      opensAt: row.opensAt,
      closesAt: row.closesAt,
    );
  }

  /// A space nobody can book is worth saying out loud, because it looks
  /// active everywhere else.
  bool get isUnbookable => isActive && hours.isEmpty;
}

@freezed
abstract class DayHoursView with _$DayHoursView {
  const factory DayHoursView({
    required int weekday,
    required String opensAt,
    required String closesAt,
  }) = _DayHoursView;

  factory DayHoursView.fromJson(Map<String, dynamic> json) =>
      _$DayHoursViewFromJson(json);
}

@freezed
abstract class PricingRuleView with _$PricingRuleView {
  const PricingRuleView._();

  const factory PricingRuleView({
    required String id,
    String? label,
    @Default(<int>[]) List<int> weekdays,
    required String startsAt,
    required String endsAt,
    @Default(0) int priceCents,
  }) = _PricingRuleView;

  factory PricingRuleView.fromJson(Map<String, dynamic> json) =>
      _$PricingRuleViewFromJson(json);

  /// "Mon, Wed, Fri" — or "Every day" / "Weekends" where that reads better.
  String get daysLabel {
    final sorted = [...weekdays]..sort();
    if (sorted.length == 7) return 'Every day';
    if (sorted.length == 2 && sorted[0] == 0 && sorted[1] == 6) {
      return 'Weekends';
    }
    if (sorted.length == 5 && !sorted.contains(0) && !sorted.contains(6)) {
      return 'Weekdays';
    }
    return [for (var i = 1; i <= 7; i++) i % 7]
        .where(sorted.contains)
        .map((d) => DayHours.names[d])
        .join(', ');
  }

  String get window => '$startsAt–$endsAt';
}

@freezed
abstract class ClosureView with _$ClosureView {
  const ClosureView._();

  const factory ClosureView({
    required String id,
    String? spaceId,
    String? spaceName,
    required DateTime startsAt,
    required DateTime endsAt,
    String? reason,
  }) = _ClosureView;

  factory ClosureView.fromJson(Map<String, dynamic> json) =>
      _$ClosureViewFromJson(json);

  bool get isWholeVenue => spaceId == null;
}

@freezed
abstract class SpaceSessionView with _$SpaceSessionView {
  const SpaceSessionView._();

  const factory SpaceSessionView({
    required String id,
    required String title,
    required DateTime startsAt,
    required DateTime endsAt,
    @Default(0) int capacity,
    @Default(0) int bookedSpots,
    @Default(false) bool cancelled,
  }) = _SpaceSessionView;

  factory SpaceSessionView.fromJson(Map<String, dynamic> json) =>
      _$SpaceSessionViewFromJson(json);

  int get spotsLeft => (capacity - bookedSpots).clamp(0, capacity);
}
