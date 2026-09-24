import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/api_mode.dart';
import '../../../core/config/app_config.dart';
import '../../../core/connectivity/connectivity_provider.dart';
import '../../../core/fake/fake_providers.dart';
import '../../../core/network/api_client.dart';
import '../../../core/storage/boot_data.dart';
import '../../../core/storage/prefs.dart';
import '../../../core/time/clock.dart';
import '../../auth/application/auth_controller.dart';
import '../../venue/venues/application/selected_venue_controller.dart';
import '../data/fake_onboarding_repository.dart';
import '../data/real_onboarding_repository.dart';
import '../domain/onboarding_input.dart';
import '../domain/onboarding_repository.dart';

part 'onboarding_controller.g.dart';

@Riverpod(keepAlive: true)
OnboardingRepository onboardingRepository(Ref ref) =>
    switch (ref.watch(apiModeProvider)) {
      ApiMode.real =>
        RealOnboardingRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeOnboardingRepository(
          ref.watch(fakeStoreProvider),
          ref.watch(fakeLatencyProvider),
          ref.watch(clockProvider),
          () => !ref.mounted || !ref.read(isOnlineProvider),
          () => ref.mounted ? ref.read(currentTokenProvider) : null,
        ),
    };

/// How far through the six steps someone is. Persisted, so closing the app
/// mid-flow does not mean starting again — and each step has already been
/// committed server-side by the time it is recorded here.
enum OnboardingStep {
  signup,
  verify,
  venue,
  space,
  hours,
  policy,
  live;

  /// The "Step N of 6" the boards show. `live` is the destination, not a step.
  int get number => switch (this) {
        OnboardingStep.signup => 1,
        OnboardingStep.verify => 2,
        OnboardingStep.venue => 3,
        OnboardingStep.space => 4,
        OnboardingStep.hours => 5,
        OnboardingStep.policy || OnboardingStep.live => 6,
      };

  static const total = 6;
}

/// What the flow has established so far. Only the durable facts live here —
/// the typed-but-unsent contents of a form stay in the screen.
class OnboardingDraft {
  const OnboardingDraft({
    this.step = OnboardingStep.signup,
    this.venueSlug,
    this.venueName,
    this.spaceId,
    this.spaceName,
    this.timezone = 'Asia/Manila',
    this.emailVerified = false,
  });

  final OnboardingStep step;
  final String? venueSlug;
  final String? venueName;
  final String? spaceId;
  final String? spaceName;
  final String timezone;
  final bool emailVerified;

  bool get hasVenue => (venueSlug ?? '').isNotEmpty;
  bool get hasSpace => (spaceId ?? '').isNotEmpty;

  OnboardingDraft copyWith({
    OnboardingStep? step,
    String? venueSlug,
    String? venueName,
    String? spaceId,
    String? spaceName,
    String? timezone,
    bool? emailVerified,
  }) =>
      OnboardingDraft(
        step: step ?? this.step,
        venueSlug: venueSlug ?? this.venueSlug,
        venueName: venueName ?? this.venueName,
        spaceId: spaceId ?? this.spaceId,
        spaceName: spaceName ?? this.spaceName,
        timezone: timezone ?? this.timezone,
        emailVerified: emailVerified ?? this.emailVerified,
      );

  Map<String, dynamic> toJson() => {
        'step': step.name,
        if (venueSlug != null) 'venueSlug': venueSlug,
        if (venueName != null) 'venueName': venueName,
        if (spaceId != null) 'spaceId': spaceId,
        if (spaceName != null) 'spaceName': spaceName,
        'timezone': timezone,
        'emailVerified': emailVerified,
      };

  factory OnboardingDraft.fromJson(Map<String, dynamic> json) => OnboardingDraft(
        step: OnboardingStep.values.firstWhere(
          (s) => s.name == json['step'],
          orElse: () => OnboardingStep.signup,
        ),
        venueSlug: json['venueSlug'] as String?,
        venueName: json['venueName'] as String?,
        spaceId: json['spaceId'] as String?,
        spaceName: json['spaceName'] as String?,
        timezone: json['timezone'] as String? ?? 'Asia/Manila',
        emailVerified: json['emailVerified'] as bool? ?? false,
      );
}

/// Drives venue onboarding: each method performs the step's write, then
/// records that it happened.
@Riverpod(keepAlive: true)
class Onboarding extends _$Onboarding {
  static const prefsKey = 'onboardingDraft';

  @override
  OnboardingDraft build() {
    // Restored in `resume()` from prefs; the first frame starts clean so the
    // Welcome screen never waits on disk.
    return const OnboardingDraft();
  }

  OnboardingRepository get _repo => ref.read(onboardingRepositoryProvider);
  Prefs get _prefs => ref.read(prefsProvider);

  /// Reads back a flow that was interrupted. Returns the step to resume at,
  /// or null when there is nothing to resume.
  Future<OnboardingStep?> resume() async {
    final raw = await _prefs.getString(prefsKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final draft = OnboardingDraft.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
      // A draft is only worth resuming while the account it belongs to is
      // still signed in; otherwise the steps after signup would 401.
      if (!ref.read(authControllerProvider).isSignedIn) {
        await clear();
        return null;
      }
      state = draft;
      return draft.step;
    } catch (_) {
      await clear();
      return null;
    }
  }

  Future<void> _save(OnboardingDraft draft) async {
    state = draft;
    await _prefs.setString(prefsKey, jsonEncode(draft.toJson()));
  }

  Future<void> clear() async {
    state = const OnboardingDraft();
    await _prefs.setString(prefsKey, null);
  }

  Future<void> signUp(SignupInput input) async {
    final result = await _repo.signUp(input);
    // The account exists and is signed in from here on, so every later step
    // has a session and the flow survives a restart.
    await ref.read(authControllerProvider.notifier).adopt(result);
    await _save(const OnboardingDraft(step: OnboardingStep.verify));
  }

  Future<void> verify(String code) async {
    await _repo.verifyEmail(code);
    await _save(state.copyWith(
      step: OnboardingStep.venue,
      emailVerified: true,
    ));
  }

  Future<void> resendCode() => _repo.resendVerification();

  /// Verification is skippable: booking emails start once it is done, and
  /// making someone leave the app to find a code is a good way to lose them.
  Future<void> skipVerification() =>
      _save(state.copyWith(step: OnboardingStep.venue));

  Future<SlugCheck> checkSlug(String slug) => _repo.checkSlug(slug);

  Future<void> createVenue(VenueInput input) async {
    final membership = await _repo.createVenue(input);
    await ref.read(authControllerProvider.notifier).refreshVenues();
    ref.read(selectedVenueSlugProvider.notifier).set(membership.slug);
    await _save(state.copyWith(
      step: OnboardingStep.space,
      venueSlug: membership.slug,
      venueName: membership.name,
      timezone: membership.timezone,
    ));
  }

  Future<void> createSpace(FirstSpaceInput input) async {
    final slug = state.venueSlug;
    if (slug == null) throw StateError('No venue yet');
    final id = await _repo.createFirstSpace(slug, input);
    await _save(state.copyWith(
      step: OnboardingStep.hours,
      spaceId: id,
      spaceName: input.name.trim(),
    ));
  }

  Future<void> setHours(HoursInput hours) async {
    final slug = state.venueSlug;
    final spaceId = state.spaceId;
    if (slug == null || spaceId == null) throw StateError('No space yet');
    await _repo.setHours(slug, spaceId, hours);
    await _save(state.copyWith(step: OnboardingStep.policy));
  }

  Future<LiveVenue> goLive(PolicyInput policy) async {
    final slug = state.venueSlug;
    if (slug == null) throw StateError('No venue yet');
    final live = await _repo.goLive(slug, policy);
    await ref.read(authControllerProvider.notifier).refreshVenues();
    await _save(state.copyWith(step: OnboardingStep.live));
    return live;
  }

  /// Called once the owner leaves the "you're live" screen: the flow is done
  /// and there is nothing left to resume.
  Future<void> finish() => clear();
}

/// Whether the venue-owner welcome screen has been shown. It is a one-time
/// pitch, not a step.
@Riverpod(keepAlive: true)
class WelcomeSeen extends _$WelcomeSeen {
  @override
  bool build() => ref.watch(bootDataProvider).welcomeSeen;

  Future<void> markSeen() async {
    state = true;
    await ref.read(prefsProvider).setString(Prefs.keyWelcomeSeen, 'true');
  }
}
