// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The venue-staff session. Phase 0 restores a persisted session and signs
/// out; sign-in, `/me` refresh and expiry timers arrive with Phase 2 (the
/// login flow) — the shape is fixed here so the router and shells are final.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// The venue-staff session. Phase 0 restores a persisted session and signs
/// out; sign-in, `/me` refresh and expiry timers arrive with Phase 2 (the
/// login flow) — the shape is fixed here so the router and shells are final.
final class AuthControllerProvider
    extends $NotifierProvider<AuthController, AuthState> {
  /// The venue-staff session. Phase 0 restores a persisted session and signs
  /// out; sign-in, `/me` refresh and expiry timers arrive with Phase 2 (the
  /// login flow) — the shape is fixed here so the router and shells are final.
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthState>(value),
    );
  }
}

String _$authControllerHash() => r'8f9cfe095e9a64d4b5acd888e97dd79d67aedd94';

/// The venue-staff session. Phase 0 restores a persisted session and signs
/// out; sign-in, `/me` refresh and expiry timers arrive with Phase 2 (the
/// login flow) — the shape is fixed here so the router and shells are final.

abstract class _$AuthController extends $Notifier<AuthState> {
  AuthState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AuthState, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthState, AuthState>,
              AuthState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
