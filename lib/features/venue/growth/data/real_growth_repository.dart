import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/growth.dart';

/// [GrowthRepository] over the HTTP API (API-CONTRACT #42–#47).
class RealGrowthRepository implements GrowthRepository {
  RealGrowthRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard() {
    if (!isAvailable(Feature.growth, _mode)) throw ApiError.notAvailable();
  }

  static List<Map<String, dynamic>> _list(Object? raw) =>
      (raw as List<dynamic>? ?? const []).whereType<Map<String, dynamic>>().toList();

  String _v(String slug) => '/mobile/venues/$slug';

  @override
  Future<List<MembershipPlan>> plans(String venueSlug) async {
    _guard();
    final json = await _api.get('${_v(venueSlug)}/membership-plans');
    return [for (final p in _list(json['plans'])) MembershipPlan.fromJson(p)];
  }

  @override
  Future<MembershipPlan> createPlan(String venueSlug, PlanInput input) async {
    _guard();
    final json = await _api.post('${_v(venueSlug)}/membership-plans', body: input.toJson());
    return MembershipPlan.fromJson(json['plan'] as Map<String, dynamic>);
  }

  @override
  Future<MembershipPlan> setPlanActive(String venueSlug, String planId, bool active) async {
    _guard();
    final json = await _api.patch(
      '${_v(venueSlug)}/membership-plans/$planId',
      body: {'active': active},
    );
    return MembershipPlan.fromJson(json['plan'] as Map<String, dynamic>);
  }

  @override
  Future<List<Holding>> grantPlan(String venueSlug, String customerId, String planId) async {
    _guard();
    final json = await _api.post(
      '${_v(venueSlug)}/customers/$customerId/memberships',
      body: {'planId': planId},
    );
    return [for (final h in _list(json['holdings'])) Holding.fromJson(h)];
  }

  @override
  Future<List<PromoCode>> promoCodes(String venueSlug) async {
    _guard();
    final json = await _api.get('${_v(venueSlug)}/promo-codes');
    return [for (final c in _list(json['codes'])) PromoCode.fromJson(c)];
  }

  @override
  Future<PromoCode> createPromo(String venueSlug, PromoInput input) async {
    _guard();
    final json = await _api.post('${_v(venueSlug)}/promo-codes', body: input.toJson());
    return PromoCode.fromJson(json['code'] as Map<String, dynamic>);
  }

  @override
  Future<PromoCode> setPromoActive(String venueSlug, String promoId, bool active) async {
    _guard();
    final json = await _api.patch(
      '${_v(venueSlug)}/promo-codes/$promoId',
      body: {'active': active},
    );
    return PromoCode.fromJson(json['code'] as Map<String, dynamic>);
  }

  @override
  Future<MarketingSettings> marketing(String venueSlug) async {
    _guard();
    return MarketingSettings.fromJson(await _api.get('${_v(venueSlug)}/marketing'));
  }

  @override
  Future<MarketingSettings> setReviewUrl(String venueSlug, String? url) async {
    _guard();
    final trimmed = url?.trim();
    return MarketingSettings.fromJson(await _api.put(
      '${_v(venueSlug)}/marketing',
      body: {'reviewUrl': trimmed == null || trimmed.isEmpty ? null : trimmed},
    ));
  }

  @override
  Future<Integrations> integrations(String venueSlug) async {
    _guard();
    return Integrations.fromJson(await _api.get('${_v(venueSlug)}/integrations'));
  }

  @override
  Future<Integrations> rotateCalendarFeed(String venueSlug) async {
    _guard();
    return Integrations.fromJson(await _api.post('${_v(venueSlug)}/integrations/ical'));
  }

  @override
  Future<Integrations> addWebhook(
    String venueSlug, {
    required String url,
    required List<String> events,
  }) async {
    _guard();
    return Integrations.fromJson(await _api.post(
      '${_v(venueSlug)}/integrations/webhooks',
      body: {'url': url.trim(), 'events': events},
    ));
  }

  @override
  Future<Integrations> deleteWebhook(String venueSlug, String webhookId) async {
    _guard();
    return Integrations.fromJson(
      await _api.delete('${_v(venueSlug)}/integrations/webhooks/$webhookId'),
    );
  }

  @override
  Future<CreatedApiKey> createApiKey(String venueSlug, String name) async {
    _guard();
    final json = await _api.post(
      '${_v(venueSlug)}/integrations/api-keys',
      body: {'name': name.trim()},
    );
    return CreatedApiKey(key: json['key'] as String, integrations: Integrations.fromJson(json));
  }

  @override
  Future<Integrations> revokeApiKey(String venueSlug, String keyId) async {
    _guard();
    return Integrations.fromJson(
      await _api.delete('${_v(venueSlug)}/integrations/api-keys/$keyId'),
    );
  }

  @override
  Future<String> export(String venueSlug, ExportKind kind) async {
    _guard();
    return _api.getText('${_v(venueSlug)}/export/${kind.name}');
  }
}
