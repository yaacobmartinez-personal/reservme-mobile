import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

part 'calendar_day.freezed.dart';
part 'calendar_day.g.dart';

/// One thing sitting on a space's lane for a day (API-CONTRACT #16).
///
/// Three kinds share the lane because the desk reads them the same way —
/// "this time is spoken for" — but they come from different tables: a
/// `booking` is a reservation, a `block` is a closure (the web's `blockOff`
/// writes to `closure`, never to `reservation`), and a `session` is open play
/// holding the space for a shared group.
@freezed
abstract class CalendarItem with _$CalendarItem {
  const CalendarItem._();

  const factory CalendarItem({
    required String id,
    required CalendarItemKind kind,
    required DateTime startsAt,
    required DateTime endsAt,

    /// "18:00–19:00" in the venue's timezone.
    required String label,

    /// Customer name, block reason, or session title — whatever names the row.
    required String title,
    String? subtitle,
    String? customerId,
    String? reference,
    @Default(ReservationStatus.confirmed) ReservationStatus status,
    DateTime? checkedInAt,
    @Default(0) int amountCents,
    @Default(1) int partySize,
    @Default(0) int noShowCount,
    int? sessionCapacity,
    int? sessionBooked,
  }) = _CalendarItem;

  factory CalendarItem.fromJson(Map<String, dynamic> json) =>
      _$CalendarItemFromJson(json);

  bool get isBooking => kind == CalendarItemKind.booking;
  bool get isBlock => kind == CalendarItemKind.block;
  bool get isCheckedIn => checkedInAt != null;

  int get durationMinutes => endsAt.difference(startsAt).inMinutes;

  /// How many grid rows this item covers, so a two-hour block on a 60-minute
  /// grid draws as one tall cell rather than two stacked ones.
  int rowSpan(int rowMinutes) =>
      rowMinutes <= 0 ? 1 : (durationMinutes / rowMinutes).ceil().clamp(1, 24);
}

enum CalendarItemKind {
  @JsonValue('booking')
  booking,
  @JsonValue('block')
  block,
  @JsonValue('session')
  session,
}

/// One space's column for the day.
@freezed
abstract class CalendarLane with _$CalendarLane {
  const factory CalendarLane({
    required String spaceId,
    required String spaceName,
    @Default(60) int slotMinutes,
    @Default(true) bool isActive,
    @Default([]) List<CalendarItem> items,
  }) = _CalendarLane;

  factory CalendarLane.fromJson(Map<String, dynamic> json) =>
      _$CalendarLaneFromJson(json);
}

/// Everything the calendar screen draws for one venue-local day.
@freezed
abstract class CalendarDay with _$CalendarDay {
  const CalendarDay._();

  const factory CalendarDay({
    /// "2026-09-26", venue-local.
    required String date,

    /// The hour rows to draw, as local "HH:MM" — the union of every lane's
    /// opening hours, so an empty day is still a grid and not a blank screen.
    @Default([]) List<String> rows,
    @Default([]) List<CalendarLane> lanes,
  }) = _CalendarDay;

  factory CalendarDay.fromJson(Map<String, dynamic> json) =>
      _$CalendarDayFromJson(json);

  bool get isEmpty => lanes.every((l) => l.items.isEmpty);
}
