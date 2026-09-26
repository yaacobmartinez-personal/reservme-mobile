import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/model/enums.dart';

part 'admin.freezed.dart';
part 'admin.g.dart';

/// The platform-admin console (API-CONTRACT #35–#41), ported from the web's
/// `/admin` pages. Everything here is about *all* venues, so none of it is
/// scoped by the selected venue — and none of it is shown to anyone without a
/// current `platform_admin` grant.

/// A venue as the console lists it.
@freezed
abstract class TenantSummary with _$TenantSummary {
  const TenantSummary._();

  const factory TenantSummary({
    required String orgId,
    required String name,
    required String slug,
    @Default('Asia/Manila') String timezone,
    @Default('PHP') String currency,
    required DateTime createdAt,
    DateTime? suspendedAt,
    String? suspendedReason,

    /// Suspended by billing for non-payment — a payment or a comp lifts it. A
    /// manual suspension (abuse, a dispute) does not lift that way.
    @Default(false) bool billingSuspended,
    @Default(0) int activeSpaces,
    @Default(0) int memberCount,
    @Default(0) int upcomingBookings,
    @Default(0) int bookingsLast30,
    @Default(0) int revenueLast30Cents,
    required TenantSubscription subscription,
    required TenantBand band,
  }) = _TenantSummary;

  factory TenantSummary.fromJson(Map<String, dynamic> json) =>
      _$TenantSummaryFromJson(json);

  bool get suspended => suspendedAt != null;
}

@freezed
abstract class TenantSubscription with _$TenantSubscription {
  const factory TenantSubscription({
    @Default(BillingStatus.trialing) BillingStatus status,
    @Default(0) int trialDaysLeft,
    @Default(false) bool dueNow,
  }) = _TenantSubscription;

  factory TenantSubscription.fromJson(Map<String, dynamic> json) =>
      _$TenantSubscriptionFromJson(json);
}

@freezed
abstract class TenantBand with _$TenantBand {
  const factory TenantBand({
    required String name,

    /// Null for the quoted multi-site band.
    int? priceCents,
  }) = _TenantBand;

  factory TenantBand.fromJson(Map<String, dynamic> json) => _$TenantBandFromJson(json);
}

/// #35 — the console's front page.
@freezed
abstract class AdminOverview with _$AdminOverview {
  const factory AdminOverview({
    required AdminTotals totals,
    required AdminRadar radar,
    @Default(0) int pendingPayments,
    @Default(<GrowthPoint>[]) List<GrowthPoint> growth,
  }) = _AdminOverview;

  factory AdminOverview.fromJson(Map<String, dynamic> json) =>
      _$AdminOverviewFromJson(json);
}

@freezed
abstract class AdminTotals with _$AdminTotals {
  const factory AdminTotals({
    @Default(0) int tenants,
    @Default(0) int suspended,
    @Default(0) int activeSpaces,
    @Default(0) int bookingsLast30,
    @Default(0) int customers,

    /// What the platform would bill this month if every unsuspended venue
    /// paid its band today.
    @Default(0) int runRateCents,
  }) = _AdminTotals;

  factory AdminTotals.fromJson(Map<String, dynamic> json) => _$AdminTotalsFromJson(json);
}

/// Venues that need an operator's eye.
@freezed
abstract class AdminRadar with _$AdminRadar {
  const AdminRadar._();

  const factory AdminRadar({
    /// Trials ending within five days.
    @Default(<TenantSummary>[]) List<TenantSummary> endingSoon,

    /// Overdue, not yet switched off.
    @Default(<TenantSummary>[]) List<TenantSummary> inGrace,

    /// Switched off by billing.
    @Default(<TenantSummary>[]) List<TenantSummary> suspended,
  }) = _AdminRadar;

  factory AdminRadar.fromJson(Map<String, dynamic> json) => _$AdminRadarFromJson(json);

  bool get isQuiet => endingSoon.isEmpty && inGrace.isEmpty && suspended.isEmpty;
}

@freezed
abstract class GrowthPoint with _$GrowthPoint {
  const factory GrowthPoint({
    /// `YYYY-MM`.
    required String month,
    @Default(0) int signups,
    @Default(0) int cancellations,
    @Default(0) int cumulative,
  }) = _GrowthPoint;

  factory GrowthPoint.fromJson(Map<String, dynamic> json) => _$GrowthPointFromJson(json);
}

/// #36 — one venue, as the console's tenant page shows it.
@freezed
abstract class TenantDetail with _$TenantDetail {
  const factory TenantDetail({
    required TenantDetailSummary tenant,
    @Default(<TenantSpace>[]) List<TenantSpace> spaces,
    @Default(<TenantMember>[]) List<TenantMember> members,
    @Default(<TenantBooking>[]) List<TenantBooking> recentBookings,
    @Default(<AdminPayment>[]) List<AdminPayment> payments,
  }) = _TenantDetail;

  factory TenantDetail.fromJson(Map<String, dynamic> json) => _$TenantDetailFromJson(json);
}

/// [TenantSummary] plus the two dates the billing actions act on.
@freezed
abstract class TenantDetailSummary with _$TenantDetailSummary {
  const TenantDetailSummary._();

  const factory TenantDetailSummary({
    required String orgId,
    required String name,
    required String slug,
    @Default('Asia/Manila') String timezone,
    @Default('PHP') String currency,
    required DateTime createdAt,
    DateTime? suspendedAt,
    String? suspendedReason,
    @Default(false) bool billingSuspended,
    @Default(0) int activeSpaces,
    @Default(0) int memberCount,
    @Default(0) int upcomingBookings,
    @Default(0) int bookingsLast30,
    @Default(0) int revenueLast30Cents,
    required TenantSubscription subscription,
    required TenantBand band,
    DateTime? paidUntil,
    DateTime? trialEndsAt,
  }) = _TenantDetailSummary;

  factory TenantDetailSummary.fromJson(Map<String, dynamic> json) =>
      _$TenantDetailSummaryFromJson(json);

  bool get suspended => suspendedAt != null;
}

@freezed
abstract class TenantSpace with _$TenantSpace {
  const factory TenantSpace({
    required String id,
    required String name,
    @Default('other') String kind,
    @Default(0) int priceCents,
    @Default(true) bool active,
  }) = _TenantSpace;

  factory TenantSpace.fromJson(Map<String, dynamic> json) => _$TenantSpaceFromJson(json);
}

@freezed
abstract class TenantMember with _$TenantMember {
  const factory TenantMember({
    String? name,
    required String email,
    required String role,
    required DateTime joinedAt,
  }) = _TenantMember;

  factory TenantMember.fromJson(Map<String, dynamic> json) => _$TenantMemberFromJson(json);
}

@freezed
abstract class TenantBooking with _$TenantBooking {
  const factory TenantBooking({
    required String reference,
    required String status,
    required String spaceName,
    String? customerName,

    /// Venue-local "DD Mon HH:MM", formatted by the server.
    required String label,
    @Default(0) int amountCents,
  }) = _TenantBooking;

  factory TenantBooking.fromJson(Map<String, dynamic> json) => _$TenantBookingFromJson(json);
}

/// A venue's transfer, as submitted for review. The queue (#39) carries the
/// venue; a tenant's own history (#36) does not need to.
@freezed
abstract class AdminPayment with _$AdminPayment {
  const factory AdminPayment({
    required String id,
    String? orgId,
    String? venueName,
    @Default(0) int amountCents,
    required String reference,

    /// The date the owner says they transferred.
    required DateTime paidAt,
    @Default('submitted') String status,
    String? note,
    String? receiptUrl,
    required DateTime createdAt,
  }) = _AdminPayment;

  factory AdminPayment.fromJson(Map<String, dynamic> json) => _$AdminPaymentFromJson(json);
}

/// #40 — where venues send their transfers.
@freezed
abstract class InstapaySettings with _$InstapaySettings {
  const factory InstapaySettings({
    String? qrUrl,
    String? payee,
    String? account,
    @Default(false) bool configured,
  }) = _InstapaySettings;

  factory InstapaySettings.fromJson(Map<String, dynamic> json) =>
      _$InstapaySettingsFromJson(json);
}

/// #41 — one privileged action. The IP stays on the server.
@freezed
abstract class AuditEntry with _$AuditEntry {
  const AuditEntry._();

  const factory AuditEntry({
    required String id,
    required String actorName,
    required String actorEmail,
    required String action,
    String? organizationName,
    String? target,
    @Default(false) bool impersonating,
    Map<String, dynamic>? detail,
    required DateTime createdAt,
  }) = _AuditEntry;

  factory AuditEntry.fromJson(Map<String, dynamic> json) => _$AuditEntryFromJson(json);

  /// What happened, in the console's words (the web audit page's labels).
  String get label => switch (action) {
        'admin.viewed_tenant' => 'Opened tenant',
        'admin.suspended_venue' => 'Suspended venue',
        'admin.reactivated_venue' => 'Reactivated venue',
        'admin.impersonation_started' => 'Started impersonating',
        'admin.impersonation_ended' => 'Stopped impersonating',
        'admin.granted_admin' => 'Granted platform admin',
        'admin.revoked_admin' => 'Revoked platform admin',
        'admin.approved_payment' => 'Approved payment',
        'admin.rejected_payment' => 'Rejected payment',
        'admin.marked_paid' => 'Marked paid',
        'admin.comped' => 'Comped',
        'admin.cancelled_subscription' => 'Cancelled subscription',
        'admin.updated_billing_config' => 'Updated InstaPay details',
        'admin.emailed_tenant' => 'Emailed owner',
        _ => action,
      };

  /// The one line of detail worth showing. Words somebody typed (a reason, a
  /// note, a subject) are quoted; facts (a reference, a date) are labelled —
  /// quoting a date made it read as if an admin had written it.
  String? get summary {
    final d = detail;
    if (d == null) return null;
    String? text(String key) {
      final value = d[key];
      return value is String && value.trim().isNotEmpty ? value.trim() : null;
    }

    if (text('reason') case final reason?) return '"$reason"';
    if (text('note') case final note?) return '"$note"';
    if (text('subject') case final subject?) return '"$subject"';
    if (text('reference') case final reference?) return 'Ref $reference';
    if (text('paidUntil') case final day?) return 'through $day';
    return null;
  }
}

/// #41 — a current platform admin.
@freezed
abstract class PlatformAdminEntry with _$PlatformAdminEntry {
  const factory PlatformAdminEntry({
    required String userId,
    String? name,
    required String email,
    required DateTime grantedAt,
    @Default(false) bool isSelf,
  }) = _PlatformAdminEntry;

  factory PlatformAdminEntry.fromJson(Map<String, dynamic> json) =>
      _$PlatformAdminEntryFromJson(json);
}

/// A billing override on one venue (#38).
sealed class BillingOverride {
  const BillingOverride();

  Map<String, Object?> toJson();
}

/// Paid through the end of [through], inclusive.
class MarkPaid extends BillingOverride {
  const MarkPaid(this.through);

  /// Venue-local calendar date, `YYYY-MM-DD`.
  final String through;

  @override
  Map<String, Object?> toJson() => {'action': 'mark_paid', 'paidUntil': through};
}

class Comp extends BillingOverride {
  const Comp();

  @override
  Map<String, Object?> toJson() => {'action': 'comp'};
}

class CancelSubscription extends BillingOverride {
  const CancelSubscription();

  @override
  Map<String, Object?> toJson() => {'action': 'cancel'};
}

/// Everything the console reads and writes.
abstract class AdminRepository {
  Future<AdminOverview> overview();
  Future<List<TenantSummary>> tenants({String? query});
  Future<TenantDetail> tenant(String orgId);

  Future<void> suspend(String orgId, {String? reason});
  Future<void> reactivate(String orgId);
  Future<void> emailOwner(String orgId, {required String subject, required String body});
  Future<void> overrideBilling(String orgId, BillingOverride change);

  /// Submitted transfers, oldest first.
  Future<List<AdminPayment>> paymentQueue();
  Future<void> approvePayment(String paymentId);
  Future<void> rejectPayment(String paymentId, {String? note});

  Future<InstapaySettings> instapay();

  /// [qrImage] is a freshly picked QR; when null the current one is kept
  /// unless [clearQr] is set.
  Future<InstapaySettings> saveInstapay({
    required String payee,
    required String account,
    List<int>? qrImage,
    bool clearQr = false,
  });

  Future<List<AuditEntry>> audit({int limit = 100});
  Future<List<PlatformAdminEntry>> admins();
  Future<void> revokeAdmin(String userId);
}
