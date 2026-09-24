// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(onboardingRepository)
final onboardingRepositoryProvider = OnboardingRepositoryProvider._();

final class OnboardingRepositoryProvider
    extends
        $FunctionalProvider<
          OnboardingRepository,
          OnboardingRepository,
          OnboardingRepository
        >
    with $Provider<OnboardingRepository> {
  OnboardingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingRepositoryHash();

  @$internal
  @override
  $ProviderElement<OnboardingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingRepository create(Ref ref) {
    return onboardingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingRepository>(value),
    );
  }
}

String _$onboardingRepositoryHash() =>
    r'15d8ea753f94cb6451e86eaa0c505a5445c94e60';

/// Drives venue onboarding: each method performs the step's write, then
/// records that it happened.

@ProviderFor(Onboarding)
final onboardingProvider = OnboardingProvider._();

/// Drives venue onboarding: each method performs the step's write, then
/// records that it happened.
final class OnboardingProvider
    extends $NotifierProvider<Onboarding, OnboardingDraft> {
  /// Drives venue onboarding: each method performs the step's write, then
  /// records that it happened.
  OnboardingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingHash();

  @$internal
  @override
  Onboarding create() => Onboarding();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingDraft>(value),
    );
  }
}

String _$onboardingHash() => r'029165f6761fb8d0f5319a8956eb78760ba2a4b7';

/// Drives venue onboarding: each method performs the step's write, then
/// records that it happened.

abstract class _$Onboarding extends $Notifier<OnboardingDraft> {
  OnboardingDraft build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OnboardingDraft, OnboardingDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OnboardingDraft, OnboardingDraft>,
              OnboardingDraft,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Whether the venue-owner welcome screen has been shown. It is a one-time
/// pitch, not a step.

@ProviderFor(WelcomeSeen)
final welcomeSeenProvider = WelcomeSeenProvider._();

/// Whether the venue-owner welcome screen has been shown. It is a one-time
/// pitch, not a step.
final class WelcomeSeenProvider extends $NotifierProvider<WelcomeSeen, bool> {
  /// Whether the venue-owner welcome screen has been shown. It is a one-time
  /// pitch, not a step.
  WelcomeSeenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'welcomeSeenProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$welcomeSeenHash();

  @$internal
  @override
  WelcomeSeen create() => WelcomeSeen();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$welcomeSeenHash() => r'3af9ce95501d6679fa312bcc60b490b8dfeb308f';

/// Whether the venue-owner welcome screen has been shown. It is a one-time
/// pitch, not a step.

abstract class _$WelcomeSeen extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
