import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/api_mode.dart';
import '../../core/config/app_config.dart';
import '../../core/connectivity/connectivity_provider.dart';
import '../../core/fake/fake_providers.dart';
import '../../core/network/api_client.dart';
import '../../core/time/clock.dart';
import 'data/fake_auth_repository.dart';
import 'data/real_auth_repository.dart';
import 'domain/auth_repository.dart';

part 'auth_providers.g.dart';

/// Reading through a captured [Ref] after its provider is gone throws, and
/// these closures outlive a request: an in-flight `/me` can land after the
/// container is torn down. A disposed ref reads as "no token" and "offline",
/// which the repositories already handle, rather than crashing.
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
      ApiMode.real => RealAuthRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeAuthRepository(
          ref.watch(fakeStoreProvider),
          ref.watch(fakeLatencyProvider),
          ref.watch(clockProvider),
          () => !ref.mounted || !ref.read(isOnlineProvider),
          () => ref.mounted ? ref.read(currentTokenProvider) : null,
        ),
    };
