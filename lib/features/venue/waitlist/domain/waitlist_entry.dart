import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

part 'waitlist_entry.freezed.dart';
part 'waitlist_entry.g.dart';

/// One person waiting for a slot that is currently taken (API-CONTRACT #23).
///
/// Read-only in v1: the venue watches the queue, but the auto-fill that sends
/// the claim link runs on the server when a booking is cancelled.
@freezed
abstract class WaitlistEntry with _$WaitlistEntry {
  const WaitlistEntry._();

  const factory WaitlistEntry({
    required String id,
    required String customerName,
    String? customerEmail,
    String? customerPhone,
    required String spaceName,
    required DateTime startsAt,
    required DateTime endsAt,

    /// "Sat 26 Sep · 12:00", in the venue's timezone.
    required String whenLabel,
    @Default(WaitlistStatus.waiting) WaitlistStatus status,
    required DateTime createdAt,
    DateTime? notifiedAt,
    DateTime? claimExpiresAt,
  }) = _WaitlistEntry;

  factory WaitlistEntry.fromJson(Map<String, dynamic> json) =>
      _$WaitlistEntryFromJson(json);

  bool get isNotified => status == WaitlistStatus.notified;

  /// Minutes left on the claim link, or null when this entry has none.
  int? minutesLeft(DateTime now) {
    if (claimExpiresAt == null) return null;
    final left = claimExpiresAt!.difference(now).inMinutes;
    return left < 0 ? 0 : left;
  }
}

abstract class VenueWaitlistRepository {
  /// Oldest first — the order the auto-fill will offer the slot in.
  Future<List<WaitlistEntry>> entries(String venueSlug);
}
