import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/api_mode.dart';
import '../../core/config/app_config.dart';
import '../../core/connectivity/connectivity_provider.dart';
import '../../core/fake/fake_providers.dart';
import '../../core/network/api_client.dart';
import '../../core/time/clock.dart';
import 'today/data/fake_today_repository.dart';
import 'today/data/real_today_repository.dart';
import 'today/domain/today_repository.dart';

part 'venue_providers.g.dart';

/// Repository wiring for the venue side.

@Riverpod(keepAlive: true)
TodayRepository todayRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
      ApiMode.real => RealTodayRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeTodayRepository(
          ref.watch(fakeStoreProvider),
          ref.watch(fakeLatencyProvider),
          ref.watch(clockProvider),
          () => !ref.read(isOnlineProvider),
        ),
    };
