import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/api_mode.dart';
import '../../core/config/app_config.dart';
import '../../core/connectivity/connectivity_provider.dart';
import '../../core/fake/fake_providers.dart';
import '../../core/network/api_client.dart';
import '../../core/time/clock.dart';
import '../auth/application/auth_controller.dart';
import 'data/fake_admin_repository.dart';
import 'data/real_admin_repository.dart';
import 'domain/admin.dart';

part 'admin_providers.g.dart';

@Riverpod(keepAlive: true)
AdminRepository adminRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
      ApiMode.real => RealAdminRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeAdminRepository(
          ref.watch(fakeStoreProvider),
          ref.watch(fakeLatencyProvider),
          ref.watch(clockProvider),
          () => !ref.mounted || !ref.read(isOnlineProvider),
          () => ref.mounted ? ref.read(authControllerProvider).userOrNull?.id : null,
        ),
    };
