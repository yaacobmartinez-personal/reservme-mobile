import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/api_mode.dart';
import '../../core/config/app_config.dart';
import '../../core/connectivity/connectivity_provider.dart';
import '../../core/fake/fake_providers.dart';
import '../../core/model/enums.dart';
import '../../core/network/api_client.dart';
import '../../core/time/clock.dart';
import '../auth/application/auth_controller.dart';
import 'billing/data/fake_billing_repository.dart';
import 'billing/data/real_billing_repository.dart';
import 'billing/domain/billing.dart';
import 'calendar/data/fake_calendar_repository.dart';
import 'calendar/data/real_calendar_repository.dart';
import 'calendar/domain/calendar_repository.dart';
import 'customers/data/fake_customers_repository.dart';
import 'customers/data/real_customers_repository.dart';
import 'customers/domain/customers_repository.dart';
import 'growth/data/fake_growth_repository.dart';
import 'growth/data/real_growth_repository.dart';
import 'growth/domain/growth.dart';
import 'insights/data/fake_insights_repository.dart';
import 'insights/data/real_insights_repository.dart';
import 'insights/domain/insights.dart';
import 'settings/data/fake_settings_repository.dart';
import 'settings/data/real_settings_repository.dart';
import 'settings/domain/venue_settings.dart';
import 'spaces/data/fake_spaces_repository.dart';
import 'spaces/data/real_spaces_repository.dart';
import 'spaces/domain/space_summary.dart';
import 'team/data/fake_team_repository.dart';
import 'team/data/real_team_repository.dart';
import 'team/domain/team.dart';
import 'today/data/fake_today_repository.dart';
import 'today/data/real_today_repository.dart';
import 'today/domain/today_repository.dart';
import 'waitlist/data/fake_waitlist_repository.dart';
import 'waitlist/data/real_waitlist_repository.dart';
import 'waitlist/domain/waitlist_entry.dart';

part 'venue_providers.g.dart';

/// Repository wiring for the venue side.

@Riverpod(keepAlive: true)
TodayRepository todayRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
  ApiMode.real => RealTodayRepository(ref.watch(apiClientProvider), ApiMode.real),
  ApiMode.fake => FakeTodayRepository(
    ref.watch(fakeStoreProvider),
    ref.watch(fakeLatencyProvider),
    ref.watch(clockProvider),
    () => !ref.mounted || !ref.read(isOnlineProvider),
  ),
};

@Riverpod(keepAlive: true)
CalendarRepository calendarRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
  ApiMode.real => RealCalendarRepository(ref.watch(apiClientProvider), ApiMode.real),
  ApiMode.fake => FakeCalendarRepository(
    ref.watch(fakeStoreProvider),
    ref.watch(fakeLatencyProvider),
    ref.watch(clockProvider),
    () => !ref.mounted || !ref.read(isOnlineProvider),
  ),
};

@Riverpod(keepAlive: true)
CustomersRepository customersRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
  ApiMode.real => RealCustomersRepository(ref.watch(apiClientProvider), ApiMode.real),
  ApiMode.fake => FakeCustomersRepository(
    ref.watch(fakeStoreProvider),
    ref.watch(fakeLatencyProvider),
    ref.watch(clockProvider),
    () => !ref.mounted || !ref.read(isOnlineProvider),
  ),
};

@Riverpod(keepAlive: true)
VenueWaitlistRepository venueWaitlistRepository(Ref ref) =>
    switch (ref.watch(apiModeProvider)) {
      ApiMode.real => RealWaitlistRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeWaitlistRepository(
        ref.watch(fakeStoreProvider),
        ref.watch(fakeLatencyProvider),
        () => !ref.mounted || !ref.read(isOnlineProvider),
      ),
    };

@Riverpod(keepAlive: true)
SpacesRepository spacesRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
  ApiMode.real => RealSpacesRepository(ref.watch(apiClientProvider), ApiMode.real),
  ApiMode.fake => FakeSpacesRepository(
    ref.watch(fakeStoreProvider),
    ref.watch(fakeLatencyProvider),
    ref.watch(clockProvider),
    () => !ref.mounted || !ref.read(isOnlineProvider),
    // The fake enforces the same owner/admin rule the server does, so
    // it needs to know who is asking.
    _roleLookup(ref),
  ),
};

/// The role lookup both the spaces and settings fakes need: the server checks
/// `requireRole` on every structural write, so the fakes do too.
VenueRole? Function(String) _roleLookup(Ref ref) => (slug) => !ref.mounted
    ? null
    : ref
        .read(authControllerProvider)
        .venuesOrEmpty
        .where((v) => v.slug == slug)
        .map((v) => v.role)
        .firstOrNull;

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    switch (ref.watch(apiModeProvider)) {
      ApiMode.real =>
        RealSettingsRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeSettingsRepository(
        ref.watch(fakeStoreProvider),
        ref.watch(fakeLatencyProvider),
        ref.watch(clockProvider),
        () => !ref.mounted || !ref.read(isOnlineProvider),
        _roleLookup(ref),
      ),
    };

@Riverpod(keepAlive: true)
TeamRepository teamRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
  ApiMode.real => RealTeamRepository(ref.watch(apiClientProvider), ApiMode.real),
  ApiMode.fake => FakeTeamRepository(
    ref.watch(fakeStoreProvider),
    ref.watch(fakeLatencyProvider),
    ref.watch(clockProvider),
    () => !ref.mounted || !ref.read(isOnlineProvider),
    _roleLookup(ref),
    // "You cannot change your own role" needs to know which member is you.
    () => !ref.mounted ? null : ref.read(authControllerProvider).userOrNull?.id,
  ),
};

@Riverpod(keepAlive: true)
BillingRepository billingRepository(Ref ref) =>
    switch (ref.watch(apiModeProvider)) {
      ApiMode.real =>
        RealBillingRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeBillingRepository(
        ref.watch(fakeStoreProvider),
        ref.watch(fakeLatencyProvider),
        ref.watch(clockProvider),
        () => !ref.mounted || !ref.read(isOnlineProvider),
        _roleLookup(ref),
      ),
    };

@Riverpod(keepAlive: true)
InsightsRepository insightsRepository(Ref ref) =>
    switch (ref.watch(apiModeProvider)) {
      ApiMode.real =>
        RealInsightsRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeInsightsRepository(
        ref.watch(fakeStoreProvider),
        ref.watch(fakeLatencyProvider),
        ref.watch(clockProvider),
        () => !ref.mounted || !ref.read(isOnlineProvider),
      ),
    };

@Riverpod(keepAlive: true)
GrowthRepository growthRepository(Ref ref) => switch (ref.watch(apiModeProvider)) {
      ApiMode.real => RealGrowthRepository(ref.watch(apiClientProvider), ApiMode.real),
      ApiMode.fake => FakeGrowthRepository(
          ref.watch(fakeStoreProvider),
          ref.watch(fakeLatencyProvider),
          ref.watch(clockProvider),
          () => !ref.mounted || !ref.read(isOnlineProvider),
          _roleLookup(ref),
        ),
    };
