import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

import '../../growth/domain/growth.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

/// A row in V10 · Customers (`CustomerListRow` in `src/lib/customers.ts`).
///
/// Lifetime value counts **confirmed** bookings only — a cancelled or
/// no-show booking is not revenue.
@freezed
abstract class CustomerSummary with _$CustomerSummary {
  const CustomerSummary._();

  const factory CustomerSummary({
    required String id,
    required String name,
    required String email,
    String? phone,
    @Default([]) List<String> tags,
    @Default(0) int bookings,
    @Default(0) int lifetimeValueCents,
    @Default(0) int noShowCount,

    /// Whole days since the last confirmed past booking; null if never.
    int? lastVisitDays,
    required DateTime createdAt,

    /// One point per ₱100 of a confirmed booking, accrued by a background
    /// job (#43). Read, never edited.
    @Default(0) int loyaltyPoints,

    /// Whether they agreed to marketing email — win-backs go only to them.
    @Default(false) bool marketingOptIn,
  }) = _CustomerSummary;

  factory CustomerSummary.fromJson(Map<String, dynamic> json) =>
      _$CustomerSummaryFromJson(json);

  /// Initials for the avatar, from the first and last word of the name.
  String get initials {
    String head(String word, int n) =>
        word.toUpperCase().substring(0, n.clamp(0, word.length));
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return head(parts.first, 2);
    return '${head(parts.first, 1)}${head(parts.last, 1)}';
  }
}

/// One booking on a customer's history (`CustomerBooking`).
@freezed
abstract class CustomerBooking with _$CustomerBooking {
  const factory CustomerBooking({
    required String id,
    required String spaceName,

    /// "Sat 26 Sep 2026, 17:00", already in the venue's timezone.
    required String whenLabel,
    required DateTime startsAt,
    @Default(ReservationStatus.confirmed) ReservationStatus status,
    @Default(ReservationKind.rental) ReservationKind kind,
    @Default(0) int amountCents,
    required String reference,
    DateTime? checkedInAt,
  }) = _CustomerBooking;

  factory CustomerBooking.fromJson(Map<String, dynamic> json) =>
      _$CustomerBookingFromJson(json);
}

@freezed
abstract class CustomerNote with _$CustomerNote {
  const factory CustomerNote({
    required String id,
    required String body,
    String? authorName,
    required DateTime createdAt,
  }) = _CustomerNote;

  factory CustomerNote.fromJson(Map<String, dynamic> json) =>
      _$CustomerNoteFromJson(json);
}

/// V11 · Customer detail (`CustomerProfile`).
@freezed
abstract class CustomerProfile with _$CustomerProfile {
  const factory CustomerProfile({
    required CustomerSummary customer,
    @Default([]) List<CustomerBooking> upcoming,
    @Default([]) List<CustomerBooking> past,
    @Default([]) List<CustomerNote> notes,
    DateTime? lastVisit,

    /// Passes and memberships they hold (#43), active first.
    @Default(<Holding>[]) List<Holding> holdings,
  }) = _CustomerProfile;

  factory CustomerProfile.fromJson(Map<String, dynamic> json) =>
      _$CustomerProfileFromJson(json);
}

/// The filter chips on V10. `all` is not a filter, it is the absence of one.
enum CustomerSegment {
  all,
  regulars,
  noShows,
  newThisMonth;

  String get label => switch (this) {
        CustomerSegment.all => 'All',
        CustomerSegment.regulars => 'Regulars',
        CustomerSegment.noShows => 'No-shows',
        CustomerSegment.newThisMonth => 'New this month',
      };
}

/// A page of customers plus the total, so the header can say "218 customers"
/// without a second request.
@freezed
abstract class CustomerPage with _$CustomerPage {
  const factory CustomerPage({
    @Default([]) List<CustomerSummary> rows,
    @Default(0) int total,
  }) = _CustomerPage;

  factory CustomerPage.fromJson(Map<String, dynamic> json) =>
      _$CustomerPageFromJson(json);
}
