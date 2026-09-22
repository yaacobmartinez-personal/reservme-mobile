import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

part 'availability.freezed.dart';
part 'availability.g.dart';

/// One candidate slot on a space for a venue-local date
/// (`GET …/availability`, API-CONTRACT #2). Ported from the web `Slot`.
///
/// Availability is a *prediction*: the database's exclusion constraint is the
/// authority, so a slot that reads `open` here can still come back
/// `slot_taken` on booking. Every screen is built around that.
@freezed
abstract class Slot with _$Slot {
  const Slot._();

  const factory Slot({
    required DateTime startsAt,
    required DateTime endsAt,

    /// "18:00", already in the venue's timezone.
    required String label,
    required bool available,
    required SlotReason reason,
    required int priceCents,

    /// True when a pricing rule raised the price above the space's base.
    @Default(false) bool peak,
  }) = _Slot;

  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);

  /// A taken slot can be joined on the waitlist; a closed one cannot.
  bool get canWaitlist => reason == SlotReason.taken;

  int get minutes => endsAt.difference(startsAt).inMinutes;
}

/// A shared-capacity session (open play, a class) on a space.
@freezed
abstract class SessionSummary with _$SessionSummary {
  const SessionSummary._();

  const factory SessionSummary({
    required String id,
    required String title,
    required DateTime startsAt,
    required DateTime endsAt,
    required String label,
    required int capacity,
    required int bookedSpots,
    required int pricePerPersonCents,
  }) = _SessionSummary;

  factory SessionSummary.fromJson(Map<String, dynamic> json) =>
      _$SessionSummaryFromJson(json);

  int get spotsLeft => capacity - bookedSpots;
  bool get isFull => spotsLeft <= 0;
}

/// Everything bookable on one space for one venue-local date.
@freezed
abstract class DayAvailability with _$DayAvailability {
  const DayAvailability._();

  const factory DayAvailability({
    /// "2026-09-26", venue-local.
    required String date,
    @Default([]) List<Slot> slots,
    @Default([]) List<SessionSummary> sessions,
  }) = _DayAvailability;

  factory DayAvailability.fromJson(Map<String, dynamic> json) =>
      _$DayAvailabilityFromJson(json);

  Iterable<Slot> get openSlots => slots.where((s) => s.available);
  bool get hasAnything => openSlots.isNotEmpty || sessions.any((s) => !s.isFull);
}
