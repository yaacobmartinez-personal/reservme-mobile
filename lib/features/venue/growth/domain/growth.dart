import 'package:freezed_annotation/freezed_annotation.dart';

part 'growth.freezed.dart';
part 'growth.g.dart';

/// The owner features that used to be web-only (API-CONTRACT #42–#47):
/// membership plans, promo codes, the review link and loyalty rules,
/// integrations, and CSV export. Ported from `src/lib/{memberships,promo,
/// engagement,ical,webhooks,api-keys,export}.ts`.

// ---- memberships (#42, #43) ------------------------------------------------

/// A pass is a one-time pack of credits; a membership renews monthly and may
/// carry credits, a discount, or both. Payment is at the venue, like the
/// subscription: the app records the sale, it does not take money.
enum PlanKind {
  @JsonValue('pass')
  pass,
  @JsonValue('membership')
  membership;

  String get label => switch (this) {
        PlanKind.pass => 'Pass',
        PlanKind.membership => 'Membership',
      };
}

@freezed
abstract class MembershipPlan with _$MembershipPlan {
  const MembershipPlan._();

  const factory MembershipPlan({
    required String id,
    required String name,
    @Default(PlanKind.pass) PlanKind kind,
    @Default(0) int priceCents,
    int? credits,

    /// `one_time` | `monthly` — decided by [kind], never chosen separately.
    @Default('one_time') String period,
    int? discountPct,
    int? validDays,
    @Default(true) bool active,
    @Default(0) int holders,
  }) = _MembershipPlan;

  factory MembershipPlan.fromJson(Map<String, dynamic> json) => _$MembershipPlanFromJson(json);

  /// "10 credits · 20% off · 90 days" — what the plan gives, in one line.
  String get benefits => [
        if (credits != null) credits == 1 ? '1 credit' : '$credits credits',
        if (discountPct != null) '$discountPct% off',
        if (validDays != null) validDays == 1 ? '1 day' : '$validDays days',
        if (period == 'monthly') 'monthly',
      ].join(' · ');
}

/// What a plan needs, validated as the server's `planInputSchema` does.
@freezed
abstract class PlanInput with _$PlanInput {
  const PlanInput._();

  const factory PlanInput({
    required String name,
    @Default(PlanKind.pass) PlanKind kind,

    /// Whole pesos, as typed.
    required String price,
    @Default('') String credits,
    @Default('') String discountPct,
    @Default('') String validDays,
  }) = _PlanInput;

  static int? _int(String s) => s.trim().isEmpty ? null : int.tryParse(s.trim());

  /// Field → message, in the server's words; empty when it would be accepted.
  Map<String, String> validate() {
    final errors = <String, String>{};
    final n = name.trim();
    if (n.length < 2) errors['name'] = 'Give the plan a name.';
    if (n.length > 60) errors['name'] = 'Keep the name under 60 characters.';
    final p = double.tryParse(price.trim());
    if (p == null) {
      errors['price'] = 'Enter a price.';
    } else if (p < 0) {
      errors['price'] = "Price can't be negative.";
    }
    final c = _int(credits);
    if (credits.trim().isNotEmpty && (c == null || c <= 0)) {
      errors['credits'] = 'Credits must be a whole number above zero.';
    }
    final d = _int(discountPct);
    if (discountPct.trim().isNotEmpty && (d == null || d < 1 || d > 100)) {
      errors['discountPct'] = 'A discount must be between 1 and 100.';
    }
    final v = _int(validDays);
    if (validDays.trim().isNotEmpty && (v == null || v <= 0)) {
      errors['validDays'] = 'Days must be a whole number above zero.';
    }
    if (credits.trim().isEmpty && discountPct.trim().isEmpty) {
      errors['credits'] = 'A plan needs either credits or a discount (or both).';
    }
    return errors;
  }

  Map<String, Object?> toJson() => {
        'name': name.trim(),
        'kind': kind.name,
        'price': double.tryParse(price.trim()) ?? 0,
        if (_int(credits) != null) 'credits': _int(credits),
        if (_int(discountPct) != null) 'discountPct': _int(discountPct),
        if (_int(validDays) != null) 'validDays': _int(validDays),
      };
}

/// A plan a customer holds (#43).
@freezed
abstract class Holding with _$Holding {
  const Holding._();

  const factory Holding({
    required String id,
    required String planId,
    required String planName,
    @Default(PlanKind.pass) PlanKind kind,
    @Default(0) int creditsRemaining,
    int? discountPct,

    /// active | expired | cancelled
    @Default('active') String status,
    DateTime? expiresAt,
  }) = _Holding;

  factory Holding.fromJson(Map<String, dynamic> json) => _$HoldingFromJson(json);

  bool get isActive => status == 'active';
}

// ---- promo codes (#44) -----------------------------------------------------

enum PromoKind {
  @JsonValue('percent')
  percent,
  @JsonValue('amount')
  amount,
}

@freezed
abstract class PromoCode with _$PromoCode {
  const PromoCode._();

  const factory PromoCode({
    required String id,
    required String code,
    @Default(PromoKind.percent) PromoKind kind,
    int? percent,
    int? amountCents,
    int? maxUses,
    @Default(0) int uses,
    DateTime? expiresAt,
    @Default(true) bool active,
  }) = _PromoCode;

  factory PromoCode.fromJson(Map<String, dynamic> json) => _$PromoCodeFromJson(json);

  bool isExpired(DateTime now) => expiresAt != null && !expiresAt!.isAfter(now);
  bool get isUsedUp => maxUses != null && uses >= maxUses!;
}

@freezed
abstract class PromoInput with _$PromoInput {
  const PromoInput._();

  const factory PromoInput({
    required String code,
    @Default(PromoKind.percent) PromoKind kind,

    /// A percentage, or whole pesos off.
    required String value,
    @Default('') String maxUses,

    /// Venue-local `YYYY-MM-DD`, inclusive; null for no expiry.
    String? expiresAt,
  }) = _PromoInput;

  static final _code = RegExp(r'^[A-Za-z0-9]+$');

  Map<String, String> validate() {
    final errors = <String, String>{};
    final c = code.trim();
    if (c.length < 2) {
      errors['code'] = 'A code needs at least 2 characters.';
    } else if (c.length > 40) {
      errors['code'] = 'Keep the code under 40 characters.';
    } else if (!_code.hasMatch(c)) {
      errors['code'] = 'Use letters and numbers only — no spaces.';
    }
    final v = int.tryParse(value.trim());
    if (v == null || v <= 0) {
      errors['value'] = 'Enter a discount greater than zero.';
    } else if (kind == PromoKind.percent && v > 100) {
      errors['value'] = 'A percentage discount must be between 1 and 100.';
    }
    final m = maxUses.trim();
    if (m.isNotEmpty && ((int.tryParse(m) ?? 0) <= 0)) {
      errors['maxUses'] = 'Uses must be a whole number above zero.';
    }
    return errors;
  }

  Map<String, Object?> toJson() => {
        'code': code.trim(),
        'kind': kind.name,
        'value': int.tryParse(value.trim()) ?? 0,
        if (maxUses.trim().isNotEmpty) 'maxUses': int.tryParse(maxUses.trim()),
        if (expiresAt != null) 'expiresAt': expiresAt,
      };
}

// ---- marketing (#45) -------------------------------------------------------

/// The review link, and loyalty as the background jobs apply it — the same
/// for every venue, so shown rather than edited.
@freezed
abstract class MarketingSettings with _$MarketingSettings {
  const factory MarketingSettings({
    String? reviewUrl,
    @Default(LoyaltyRules()) LoyaltyRules loyalty,
  }) = _MarketingSettings;

  factory MarketingSettings.fromJson(Map<String, dynamic> json) =>
      _$MarketingSettingsFromJson(json);
}

@freezed
abstract class LoyaltyRules with _$LoyaltyRules {
  const factory LoyaltyRules({
    /// One point for every this-many pesos of a confirmed booking.
    @Default(100) int pesosPerPoint,

    /// A customer with no visit in this many days gets one win-back email.
    @Default(60) int winbackAfterDays,
  }) = _LoyaltyRules;

  factory LoyaltyRules.fromJson(Map<String, dynamic> json) => _$LoyaltyRulesFromJson(json);
}

/// The server's `reviewUrlProblem`: a full http(s) link, or nothing.
String? reviewUrlProblem(String value) {
  final v = value.trim();
  if (v.isEmpty) return null;
  final uri = Uri.tryParse(v);
  if (uri == null || !(uri.scheme == 'https' || uri.scheme == 'http') || uri.host.isEmpty) {
    return 'Enter a full link, e.g. https://g.page/…';
  }
  return null;
}

// ---- integrations (#46) ----------------------------------------------------

@freezed
abstract class Integrations with _$Integrations {
  const factory Integrations({
    String? icalUrl,
    @Default(<String>['booking.created', 'booking.cancelled']) List<String> webhookEvents,
    @Default(<Webhook>[]) List<Webhook> webhooks,
    @Default(<ApiKeyInfo>[]) List<ApiKeyInfo> apiKeys,
  }) = _Integrations;

  factory Integrations.fromJson(Map<String, dynamic> json) => _$IntegrationsFromJson(json);
}

@freezed
abstract class Webhook with _$Webhook {
  const factory Webhook({
    required String id,
    required String url,

    /// Signs every delivery (HMAC-SHA256 of the body); the receiver needs it.
    required String secret,
    @Default(<String>[]) List<String> events,
    @Default(true) bool active,
    required DateTime createdAt,
  }) = _Webhook;

  factory Webhook.fromJson(Map<String, dynamic> json) => _$WebhookFromJson(json);
}

/// An API key as listed: its prefix, never the key.
@freezed
abstract class ApiKeyInfo with _$ApiKeyInfo {
  const ApiKeyInfo._();

  const factory ApiKeyInfo({
    required String id,
    required String name,
    required String prefix,
    DateTime? lastUsedAt,
    required DateTime createdAt,
    DateTime? revokedAt,
  }) = _ApiKeyInfo;

  factory ApiKeyInfo.fromJson(Map<String, dynamic> json) => _$ApiKeyInfoFromJson(json);

  bool get revoked => revokedAt != null;
}

/// A freshly made key: the only time the whole of it is ever seen.
class CreatedApiKey {
  const CreatedApiKey({required this.key, required this.integrations});

  final String key;
  final Integrations integrations;
}

// ---- export (#47) ----------------------------------------------------------

enum ExportKind {
  bookings,
  customers,
  transactions;

  String get label => switch (this) {
        ExportKind.bookings => 'Bookings',
        ExportKind.customers => 'Customers',
        ExportKind.transactions => 'Transactions',
      };

  String get blurb => switch (this) {
        ExportKind.bookings => 'Every booking: when, where, who, status, amount.',
        ExportKind.customers => 'Everyone who has booked, with visits and value.',
        ExportKind.transactions => 'Gross, discount and net per booking — for your books.',
      };
}

// ---- the repository --------------------------------------------------------

abstract class GrowthRepository {
  Future<List<MembershipPlan>> plans(String venueSlug);
  Future<MembershipPlan> createPlan(String venueSlug, PlanInput input);
  Future<MembershipPlan> setPlanActive(String venueSlug, String planId, bool active);

  /// Records a plan sold at the desk; answers with what the customer holds.
  Future<List<Holding>> grantPlan(String venueSlug, String customerId, String planId);

  Future<List<PromoCode>> promoCodes(String venueSlug);
  Future<PromoCode> createPromo(String venueSlug, PromoInput input);
  Future<PromoCode> setPromoActive(String venueSlug, String promoId, bool active);

  Future<MarketingSettings> marketing(String venueSlug);
  Future<MarketingSettings> setReviewUrl(String venueSlug, String? url);

  Future<Integrations> integrations(String venueSlug);
  Future<Integrations> rotateCalendarFeed(String venueSlug);
  Future<Integrations> addWebhook(String venueSlug, {required String url, required List<String> events});
  Future<Integrations> deleteWebhook(String venueSlug, String webhookId);
  Future<CreatedApiKey> createApiKey(String venueSlug, String name);
  Future<Integrations> revokeApiKey(String venueSlug, String keyId);

  /// The CSV, as text.
  Future<String> export(String venueSlug, ExportKind kind);
}
