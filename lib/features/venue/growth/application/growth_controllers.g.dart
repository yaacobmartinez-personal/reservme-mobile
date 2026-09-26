// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Reads for the owner features that were web-only (#42–#46). Each screen
/// refetches rather than caching for offline: these are settings screens,
/// visited rarely, and a stale copy of a webhook secret helps nobody.

@ProviderFor(membershipPlans)
final membershipPlansProvider = MembershipPlansFamily._();

/// Reads for the owner features that were web-only (#42–#46). Each screen
/// refetches rather than caching for offline: these are settings screens,
/// visited rarely, and a stale copy of a webhook secret helps nobody.

final class MembershipPlansProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MembershipPlan>>,
          List<MembershipPlan>,
          FutureOr<List<MembershipPlan>>
        >
    with
        $FutureModifier<List<MembershipPlan>>,
        $FutureProvider<List<MembershipPlan>> {
  /// Reads for the owner features that were web-only (#42–#46). Each screen
  /// refetches rather than caching for offline: these are settings screens,
  /// visited rarely, and a stale copy of a webhook secret helps nobody.
  MembershipPlansProvider._({
    required MembershipPlansFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'membershipPlansProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$membershipPlansHash();

  @override
  String toString() {
    return r'membershipPlansProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MembershipPlan>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MembershipPlan>> create(Ref ref) {
    final argument = this.argument as String;
    return membershipPlans(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MembershipPlansProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$membershipPlansHash() => r'ef5a3a1a90cd95e21ebde92b645684918d9f0a8f';

/// Reads for the owner features that were web-only (#42–#46). Each screen
/// refetches rather than caching for offline: these are settings screens,
/// visited rarely, and a stale copy of a webhook secret helps nobody.

final class MembershipPlansFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MembershipPlan>>, String> {
  MembershipPlansFamily._()
    : super(
        retry: null,
        name: r'membershipPlansProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Reads for the owner features that were web-only (#42–#46). Each screen
  /// refetches rather than caching for offline: these are settings screens,
  /// visited rarely, and a stale copy of a webhook secret helps nobody.

  MembershipPlansProvider call(String venueSlug) =>
      MembershipPlansProvider._(argument: venueSlug, from: this);

  @override
  String toString() => r'membershipPlansProvider';
}

@ProviderFor(promoCodes)
final promoCodesProvider = PromoCodesFamily._();

final class PromoCodesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PromoCode>>,
          List<PromoCode>,
          FutureOr<List<PromoCode>>
        >
    with $FutureModifier<List<PromoCode>>, $FutureProvider<List<PromoCode>> {
  PromoCodesProvider._({
    required PromoCodesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'promoCodesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$promoCodesHash();

  @override
  String toString() {
    return r'promoCodesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<PromoCode>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PromoCode>> create(Ref ref) {
    final argument = this.argument as String;
    return promoCodes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PromoCodesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$promoCodesHash() => r'7f46b26df562b2d7924c8843f184d5c6ecef4447';

final class PromoCodesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<PromoCode>>, String> {
  PromoCodesFamily._()
    : super(
        retry: null,
        name: r'promoCodesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PromoCodesProvider call(String venueSlug) =>
      PromoCodesProvider._(argument: venueSlug, from: this);

  @override
  String toString() => r'promoCodesProvider';
}

@ProviderFor(marketingSettings)
final marketingSettingsProvider = MarketingSettingsFamily._();

final class MarketingSettingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MarketingSettings>,
          MarketingSettings,
          FutureOr<MarketingSettings>
        >
    with
        $FutureModifier<MarketingSettings>,
        $FutureProvider<MarketingSettings> {
  MarketingSettingsProvider._({
    required MarketingSettingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'marketingSettingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$marketingSettingsHash();

  @override
  String toString() {
    return r'marketingSettingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MarketingSettings> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MarketingSettings> create(Ref ref) {
    final argument = this.argument as String;
    return marketingSettings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MarketingSettingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$marketingSettingsHash() => r'807f2fba1ec7a899031e396a36076f862b109732';

final class MarketingSettingsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MarketingSettings>, String> {
  MarketingSettingsFamily._()
    : super(
        retry: null,
        name: r'marketingSettingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MarketingSettingsProvider call(String venueSlug) =>
      MarketingSettingsProvider._(argument: venueSlug, from: this);

  @override
  String toString() => r'marketingSettingsProvider';
}

@ProviderFor(integrations)
final integrationsProvider = IntegrationsFamily._();

final class IntegrationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Integrations>,
          Integrations,
          FutureOr<Integrations>
        >
    with $FutureModifier<Integrations>, $FutureProvider<Integrations> {
  IntegrationsProvider._({
    required IntegrationsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'integrationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$integrationsHash();

  @override
  String toString() {
    return r'integrationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Integrations> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Integrations> create(Ref ref) {
    final argument = this.argument as String;
    return integrations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is IntegrationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$integrationsHash() => r'6937b39a66ae1d1e7a2236b79b98bed0d80b9822';

final class IntegrationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Integrations>, String> {
  IntegrationsFamily._()
    : super(
        retry: null,
        name: r'integrationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IntegrationsProvider call(String venueSlug) =>
      IntegrationsProvider._(argument: venueSlug, from: this);

  @override
  String toString() => r'integrationsProvider';
}

/// The writes. `keepAlive` because they are invoked with `ref.read` from a
/// button: an auto-dispose notifier is gone before the future completes.

@ProviderFor(GrowthCommands)
final growthCommandsProvider = GrowthCommandsProvider._();

/// The writes. `keepAlive` because they are invoked with `ref.read` from a
/// button: an auto-dispose notifier is gone before the future completes.
final class GrowthCommandsProvider
    extends $NotifierProvider<GrowthCommands, void> {
  /// The writes. `keepAlive` because they are invoked with `ref.read` from a
  /// button: an auto-dispose notifier is gone before the future completes.
  GrowthCommandsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'growthCommandsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$growthCommandsHash();

  @$internal
  @override
  GrowthCommands create() => GrowthCommands();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$growthCommandsHash() => r'473b822f692aa74541dad38a4cc85f6ac6f39cde';

/// The writes. `keepAlive` because they are invoked with `ref.read` from a
/// button: an auto-dispose notifier is gone before the future completes.

abstract class _$GrowthCommands extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
