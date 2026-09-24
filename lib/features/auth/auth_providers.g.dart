// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Reading through a captured [Ref] after its provider is gone throws, and
/// these closures outlive a request: an in-flight `/me` can land after the
/// container is torn down. A disposed ref reads as "no token" and "offline",
/// which the repositories already handle, rather than crashing.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// Reading through a captured [Ref] after its provider is gone throws, and
/// these closures outlive a request: an in-flight `/me` can land after the
/// container is torn down. A disposed ref reads as "no token" and "offline",
/// which the repositories already handle, rather than crashing.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Reading through a captured [Ref] after its provider is gone throws, and
  /// these closures outlive a request: an in-flight `/me` can land after the
  /// container is torn down. A disposed ref reads as "no token" and "offline",
  /// which the repositories already handle, rather than crashing.
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'b6f6533bea364ce4fe2feffb6b5f805682539a2c';
