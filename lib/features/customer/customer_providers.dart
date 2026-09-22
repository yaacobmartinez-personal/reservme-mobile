import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/api_mode.dart';
import '../../core/config/app_config.dart';
import '../../core/connectivity/connectivity_provider.dart';
import '../../core/fake/fake_providers.dart';
import '../../core/network/api_client.dart';
import '../../core/time/clock.dart';
import 'booking/data/fake_booking_repository.dart';
import 'booking/data/real_booking_repository.dart';
import 'booking/domain/booking_repository.dart';
import 'venues/data/fake_venues_repository.dart';
import 'venues/data/real_venues_repository.dart';
import 'venues/domain/venues_repository.dart';
import 'wallet/data/fake_manage_repository.dart';
import 'wallet/data/real_manage_repository.dart';
import 'wallet/domain/manage_repository.dart';

part 'customer_providers.g.dart';

/// Repository wiring for the customer side. Each one is a `switch` over the
/// build's [ApiMode]; tests override the provider itself.

@Riverpod(keepAlive: true)
VenuesRepository venuesRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
      ApiMode.real => RealVenuesRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeVenuesRepository(
          ref.watch(fakeStoreProvider),
          ref.watch(fakeLatencyProvider),
          ref.watch(clockProvider),
        ),
    };

@Riverpod(keepAlive: true)
BookingRepository bookingRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
      ApiMode.real => RealBookingRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeBookingRepository(
          ref.watch(fakeStoreProvider),
          ref.watch(fakeLatencyProvider),
          ref.watch(clockProvider),
          () => !ref.read(isOnlineProvider),
        ),
    };

@Riverpod(keepAlive: true)
ManageRepository manageRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
      ApiMode.real => RealManageRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeManageRepository(
          ref.watch(fakeStoreProvider),
          ref.watch(fakeLatencyProvider),
          ref.watch(clockProvider),
          () => !ref.read(isOnlineProvider),
        ),
    };
