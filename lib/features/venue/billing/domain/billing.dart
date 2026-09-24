import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

part 'billing.freezed.dart';
part 'billing.g.dart';

/// G4 · Billing — what the venue owes ReservMe (API-CONTRACT #32).
///
/// The band is **never stored**. It is derived from the venue's *active*
/// space count at read time, so pausing a court for the off-season drops a
/// band with no write anywhere. That is the single most surprising thing
/// about this screen, and why it says so out loud.
///
/// Ported from `src/lib/billing.ts` and `packages/marketing-content`.
@freezed
abstract class Billing with _$Billing {
  const Billing._();

  const factory Billing({
    @Default(BillingStatus.trialing) BillingStatus status,
    required PlanBand band,
    @Default(0) int activeSpaces,
    required DateTime trialEndsAt,
    DateTime? paidUntil,

    /// Whole days until the trial ends, never negative; null once not
    /// trialing.
    int? daysLeftInTrial,
    @Default(false) bool dueNow,

    /// True once billing has switched the public booking page off.
    @Default(false) bool suspended,
    BillingPayment? pendingPayment,
    @Default(<BillingPayment>[]) List<BillingPayment> history,
    InstapayDetails? instapay,
  }) = _Billing;

  factory Billing.fromJson(Map<String, dynamic> json) => _$BillingFromJson(json);

  /// The band's price in centavos, or null for the quoted multi-site band.
  int? get amountDueCents => band.pricePesos == null ? null : band.pricePesos! * 100;

  bool get isQuoted => band.pricePesos == null;

  /// Re-exported so the screen and the fakes read one name. The values live
  /// in core because the seeded world needs them too.
  static const graceDays = BillingPolicy.graceDays;
  static const suspendReason = BillingPolicy.suspendReason;
}

/// One of the four flat bands. Per-space pricing is the US/EU norm and is
/// uncompetitive here; ReservMe charges per venue, banded by how many spaces
/// it runs.
@freezed
abstract class PlanBand with _$PlanBand {
  const PlanBand._();

  const factory PlanBand({
    required String id,
    required String name,
    required int minSpaces,

    /// Null means the band has no ceiling and is quoted, not listed.
    int? maxSpaces,
    int? pricePesos,
    required String blurb,
  }) = _PlanBand;

  factory PlanBand.fromJson(Map<String, dynamic> json) =>
      _$PlanBandFromJson(json);

  static const all = [
    PlanBand(
      id: 'solo',
      name: 'Solo',
      minSpaces: 1,
      maxSpaces: 1,
      pricePesos: 499,
      blurb: 'One court, one studio, one boat.',
    ),
    PlanBand(
      id: 'club',
      name: 'Club',
      minSpaces: 2,
      maxSpaces: 6,
      pricePesos: 999,
      blurb: 'The size most clubs actually are.',
    ),
    PlanBand(
      id: 'complex',
      name: 'Complex',
      minSpaces: 7,
      maxSpaces: 15,
      pricePesos: 1999,
      blurb: 'Multi-court centres and function venues.',
    ),
    PlanBand(
      id: 'multi',
      name: 'Multi-site',
      minSpaces: 16,
      maxSpaces: null,
      pricePesos: null,
      blurb: 'Several branches, or more than fifteen spaces.',
    ),
  ];

  /// `planForSpaces`, including its quirk: a venue with **no** active spaces
  /// sits in the entry band rather than falling off the table.
  static PlanBand forSpaces(int activeSpaces) {
    if (activeSpaces <= 0) return all.first;
    return all.firstWhere(
      (p) =>
          activeSpaces >= p.minSpaces &&
          (p.maxSpaces == null || activeSpaces <= p.maxSpaces!),
      orElse: () => all.last,
    );
  }

  /// "1 space", "2–6 spaces", "16 or more spaces".
  String get spread {
    if (maxSpaces == null) return '$minSpaces or more spaces';
    if (maxSpaces == minSpaces) return '$minSpaces space';
    return '$minSpaces–$maxSpaces spaces';
  }
}

@freezed
abstract class BillingPayment with _$BillingPayment {
  const BillingPayment._();

  const factory BillingPayment({
    required String id,
    @Default(0) int amountCents,
    required String reference,

    /// Venue-local date, "YYYY-MM-DD" — what the owner says they transferred.
    required String paidAt,
    @Default(PaymentStatus.submitted) PaymentStatus status,
    String? note,
    required DateTime createdAt,
  }) = _BillingPayment;

  factory BillingPayment.fromJson(Map<String, dynamic> json) =>
      _$BillingPaymentFromJson(json);
}

enum PaymentStatus {
  @JsonValue('submitted')
  submitted('submitted'),
  @JsonValue('approved')
  approved('approved'),
  @JsonValue('rejected')
  rejected('rejected');

  const PaymentStatus(this.wire);
  final String wire;

  String get label => switch (this) {
        PaymentStatus.submitted => 'Under review',
        PaymentStatus.approved => 'Approved',
        PaymentStatus.rejected => 'Not accepted',
      };
}

/// Where to send the transfer. Platform-wide, set by ReservMe, not the venue.
@freezed
abstract class InstapayDetails with _$InstapayDetails {
  const InstapayDetails._();

  const factory InstapayDetails({
    String? qrUrl,
    String? payee,
    String? account,
  }) = _InstapayDetails;

  factory InstapayDetails.fromJson(Map<String, dynamic> json) =>
      _$InstapayDetailsFromJson(json);

  /// Enough set to actually show a payable panel.
  bool get configured => (qrUrl?.isNotEmpty ?? false) && (payee?.isNotEmpty ?? false);
}

/// What the owner submits after transferring. The amount is **not** in here:
/// it is derived server-side from the band, so the form cannot declare what
/// it owes.
class PaymentProofInput {
  const PaymentProofInput({required this.reference, required this.paidAt});

  final String reference;

  /// "YYYY-MM-DD", venue-local.
  final String paidAt;

  static final _date = RegExp(r'^\d{4}-\d{2}-\d{2}$');

  String? validate() {
    final trimmed = reference.trim();
    if (trimmed.length < 4) return 'Enter the InstaPay reference number.';
    if (trimmed.length > 64) return 'That reference is too long.';
    if (!_date.hasMatch(paidAt)) return 'Pick the date you paid.';
    return null;
  }

  bool get isValid => validate() == null;

  PaymentProofInput copyWith({String? reference, String? paidAt}) =>
      PaymentProofInput(
        reference: reference ?? this.reference,
        paidAt: paidAt ?? this.paidAt,
      );

  Map<String, dynamic> toJson() => {
        'reference': reference.trim(),
        'paidAt': paidAt,
      };
}

abstract class BillingRepository {
  Future<Billing> get(String venueSlug);

  /// [receipt] is an optional screenshot of the transfer.
  Future<Billing> submitProof(
    String venueSlug,
    PaymentProofInput input, {
    List<int>? receipt,
  });
}
