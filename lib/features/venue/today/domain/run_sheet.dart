import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

part 'run_sheet.freezed.dart';
part 'run_sheet.g.dart';

/// One line on today's run sheet (API-CONTRACT #14). Mirrors the row the web
/// `getRunSheet` returns, plus the two things the desk needs at a glance:
/// whether this customer has form (no-shows) and whether it is their first
/// visit.
@freezed
abstract class RunSheetEntry with _$RunSheetEntry {
  const RunSheetEntry._();

  const factory RunSheetEntry({
    required String id,
    required String reference,
    required String spaceName,
    String? customerId,
    String? customerName,
    String? customerPhone,

    /// "18:00–19:00", already in the venue's timezone.
    required String label,
    required DateTime startsAt,
    required DateTime endsAt,
    @Default(ReservationStatus.confirmed) ReservationStatus status,
    @Default(ReservationKind.rental) ReservationKind kind,
    @Default(1) int partySize,
    @Default(0) int amountCents,
    DateTime? checkedInAt,
    @Default(0) int noShowCount,
    @Default(false) bool firstVisit,

    /// Session seats roll up into one line: "7 of 12".
    int? sessionCapacity,
    int? sessionBooked,
  }) = _RunSheetEntry;

  factory RunSheetEntry.fromJson(Map<String, dynamic> json) =>
      _$RunSheetEntryFromJson(json);

  bool get isCheckedIn => checkedInAt != null;
  bool get isSession => kind == ReservationKind.sessionBlock;

  /// Whether this is the booking the desk is dealing with right now.
  bool isDue(DateTime now) =>
      !isCheckedIn &&
      status == ReservationStatus.confirmed &&
      startsAt.isBefore(now.add(const Duration(minutes: 30))) &&
      endsAt.isAfter(now);
}

/// The strip above the run sheet (API-CONTRACT #14).
@freezed
abstract class VenueStats with _$VenueStats {
  const factory VenueStats({
    @Default(0) int todayCount,
    @Default(0) int checkedIn,
    @Default(0) int upcomingCount,
    @Default(0) int activeSpaces,
    @Default(0) int totalSpaces,
    @Default(0) int todayRevenueCents,
  }) = _VenueStats;

  factory VenueStats.fromJson(Map<String, dynamic> json) => _$VenueStatsFromJson(json);
}

/// Everything the Today screen renders.
@freezed
abstract class TodayView with _$TodayView {
  const factory TodayView({
    /// "2026-09-23", venue-local.
    required String date,
    @Default(VenueStats()) VenueStats stats,
    @Default([]) List<RunSheetEntry> runSheet,
  }) = _TodayView;

  factory TodayView.fromJson(Map<String, dynamic> json) => _$TodayViewFromJson(json);
}
