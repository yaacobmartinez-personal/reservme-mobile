import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../customers/application/customers_controller.dart';
import '../../venue_providers.dart';
import '../domain/growth.dart';

part 'growth_controllers.g.dart';

/// Reads for the owner features that were web-only (#42–#46). Each screen
/// refetches rather than caching for offline: these are settings screens,
/// visited rarely, and a stale copy of a webhook secret helps nobody.

@riverpod
Future<List<MembershipPlan>> membershipPlans(Ref ref, String venueSlug) =>
    ref.watch(growthRepositoryProvider).plans(venueSlug);

@riverpod
Future<List<PromoCode>> promoCodes(Ref ref, String venueSlug) =>
    ref.watch(growthRepositoryProvider).promoCodes(venueSlug);

@riverpod
Future<MarketingSettings> marketingSettings(Ref ref, String venueSlug) =>
    ref.watch(growthRepositoryProvider).marketing(venueSlug);

@riverpod
Future<Integrations> integrations(Ref ref, String venueSlug) =>
    ref.watch(growthRepositoryProvider).integrations(venueSlug);

/// The writes. `keepAlive` because they are invoked with `ref.read` from a
/// button: an auto-dispose notifier is gone before the future completes.
@Riverpod(keepAlive: true)
class GrowthCommands extends _$GrowthCommands {
  @override
  void build() {}

  GrowthRepository get _repo => ref.read(growthRepositoryProvider);

  Future<MembershipPlan> createPlan(String slug, PlanInput input) async {
    final plan = await _repo.createPlan(slug, input);
    ref.invalidate(membershipPlansProvider(slug));
    return plan;
  }

  Future<void> setPlanActive(String slug, String planId, bool active) async {
    await _repo.setPlanActive(slug, planId, active);
    ref.invalidate(membershipPlansProvider(slug));
  }

  /// Records a plan sold at the desk, and refreshes the customer's profile.
  Future<List<Holding>> grantPlan(String slug, String customerId, String planId) async {
    final holdings = await _repo.grantPlan(slug, customerId, planId);
    ref
      ..invalidate(customerDetailProvider(slug, customerId))
      ..invalidate(membershipPlansProvider(slug));
    return holdings;
  }

  Future<PromoCode> createPromo(String slug, PromoInput input) async {
    final code = await _repo.createPromo(slug, input);
    ref.invalidate(promoCodesProvider(slug));
    return code;
  }

  Future<void> setPromoActive(String slug, String promoId, bool active) async {
    await _repo.setPromoActive(slug, promoId, active);
    ref.invalidate(promoCodesProvider(slug));
  }

  Future<void> setReviewUrl(String slug, String? url) async {
    await _repo.setReviewUrl(slug, url);
    ref.invalidate(marketingSettingsProvider(slug));
  }

  Future<void> rotateCalendarFeed(String slug) async {
    await _repo.rotateCalendarFeed(slug);
    ref.invalidate(integrationsProvider(slug));
  }

  Future<void> addWebhook(String slug, {required String url, required List<String> events}) async {
    await _repo.addWebhook(slug, url: url, events: events);
    ref.invalidate(integrationsProvider(slug));
  }

  Future<void> deleteWebhook(String slug, String webhookId) async {
    await _repo.deleteWebhook(slug, webhookId);
    ref.invalidate(integrationsProvider(slug));
  }

  /// Returns the whole key — the only time it is ever available.
  Future<String> createApiKey(String slug, String name) async {
    final created = await _repo.createApiKey(slug, name);
    ref.invalidate(integrationsProvider(slug));
    return created.key;
  }

  Future<void> revokeApiKey(String slug, String keyId) async {
    await _repo.revokeApiKey(slug, keyId);
    ref.invalidate(integrationsProvider(slug));
  }

  Future<String> export(String slug, ExportKind kind) => _repo.export(slug, kind);
}
