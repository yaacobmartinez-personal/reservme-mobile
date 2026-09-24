// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The venue-staff session.
///
/// Boot restores a persisted session optimistically — the cached user and
/// venue list are enough to draw the shell — then confirms it with `/me`. An
/// expired token, a 401 from anywhere, or a deliberate sign-out ends it.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// The venue-staff session.
///
/// Boot restores a persisted session optimistically — the cached user and
/// venue list are enough to draw the shell — then confirms it with `/me`. An
/// expired token, a 401 from anywhere, or a deliberate sign-out ends it.
final class AuthControllerProvider
    extends $NotifierProvider<AuthController, AuthState> {
  /// The venue-staff session.
  ///
  /// Boot restores a persisted session optimistically — the cached user and
  /// venue list are enough to draw the shell — then confirms it with `/me`. An
  /// expired token, a 401 from anywhere, or a deliberate sign-out ends it.
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

String _$authControllerHash() => r'62e15b817d2478ca7dd049b59463cdb789c3de5e';

/// The venue-staff session.
///
/// Boot restores a persisted session optimistically — the cached user and
/// venue list are enough to draw the shell — then confirms it with `/me`. An
/// expired token, a 401 from anywhere, or a deliberate sign-out ends it.

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
