import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/connectivity/connectivity_provider.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/features/venue/today/application/today_controller.dart';

import '../helpers/fakes.dart';

void main() {
  const slug = FakeVenues.katipunan;

  Future<TodayState> load(ProviderContainer container) =>
      container.read(todayProvider(slug).future);

  /// Drop the network and wait for the connectivity stream to be believed —
  /// the repositories read `isOnline`, which stays optimistic until then.
  Future<void> goOffline(ProviderContainer container, TestWorld world) async {
    final sub = container.listen(isOnlineProvider, (_, _) {});
    addTearDown(sub.close);
    world.setOnline(false);
    while (container.read(isOnlineProvider)) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  test('the run sheet is the venue-local day, with its stats', () async {
    final world = TestWorld();
    final container = world.container();

    final state = await load(container);

    expect(state.stale, isFalse);
    expect(state.view.date, '2026-09-26');
    expect(state.view.runSheet, isNotEmpty);
    expect(state.view.stats.todayCount, greaterThan(0));
    expect(state.view.stats.totalSpaces, greaterThanOrEqualTo(state.view.stats.activeSpaces));
    // Every row belongs to the same local day and is sorted by time.
    final starts = state.view.runSheet.map((r) => r.startsAt).toList();
    expect(starts, orderedEquals(List.of(starts)..sort()));
  });

  test('offline falls back to the saved copy and says so', () async {
    final world = TestWorld();
    final container = world.container();
    final fresh = await load(container);

    await goOffline(container, world);
    container.invalidate(todayProvider(slug));
    final cached = await load(container);

    expect(cached.stale, isTrue);
    expect(cached.fetchedAt, testNow);
    expect(cached.view.date, fresh.view.date);
    expect(cached.view.runSheet.length, fresh.view.runSheet.length);
  });

  test('offline with nothing saved is an error, not an empty day', () async {
    final world = TestWorld();
    final container = world.container();
    await goOffline(container, world);
    final sub = container.listen(todayProvider(slug), (_, _) {});
    addTearDown(sub.close);

    await expectLater(
      load(container),
      throwsA(isA<ApiError>().having((e) => e.isNetwork, 'isNetwork', isTrue)),
    );
  });

  test('an unknown venue is a real error even with a cache on disk', () async {
    final world = TestWorld();
    final container = world.container();
    await world.local.saveVenueCache('ghost', Today.cacheKey, {'date': '2026-09-26'},
        now: testNow);

    await expectLater(
      container.read(todayProvider('ghost').future),
      throwsA(isA<ApiError>().having((e) => e.status, 'status', 404)),
    );
  });

  test('checking in updates the row in place', () async {
    final world = TestWorld();
    final container = world.container();
    final sub = container.listen(todayProvider(slug), (_, _) {});
    addTearDown(sub.close);

    final before = await load(container);
    final target = before.view.runSheet.firstWhere(
      (r) => !r.isCheckedIn && !r.isSession && r.status == ReservationStatus.confirmed,
    );

    await container.read(todayProvider(slug).notifier).checkIn(target.id);

    final after = await load(container);
    final row = after.view.runSheet.firstWhere((r) => r.id == target.id);
    expect(row.isCheckedIn, isTrue);
    expect(after.view.stats.checkedIn, before.view.stats.checkedIn + 1);
  });

  test('a no-show counts against the customer and leaves the sheet', () async {
    final world = TestWorld();
    final container = world.container();
    final sub = container.listen(todayProvider(slug), (_, _) {});
    addTearDown(sub.close);

    final before = await load(container);
    final target = before.view.runSheet
        .firstWhere((r) => r.customerId != null && r.status == ReservationStatus.confirmed);

    await container.read(todayProvider(slug).notifier).noShow(target.id);

    // The web's run sheet is held|confirmed only, so the row drops off on the
    // next fetch — but the mark itself sticks to the customer.
    final after = await load(container);
    expect(after.view.runSheet.where((r) => r.id == target.id), isEmpty);
    expect(world.store.customerById(target.customerId!)!.noShowCount,
        target.noShowCount + 1);
  });

  test('cancelling frees the slot: the row leaves the sheet', () async {
    final world = TestWorld();
    final container = world.container();
    final sub = container.listen(todayProvider(slug), (_, _) {});
    addTearDown(sub.close);

    final before = await load(container);
    final target = before.view.runSheet
        .firstWhere((r) => !r.isSession && r.status == ReservationStatus.confirmed);

    await container.read(todayProvider(slug).notifier).cancel(target.id);

    final after = await load(container);
    expect(after.view.runSheet.where((r) => r.id == target.id), isEmpty);
  });

  test('a write while offline fails rather than queueing', () async {
    final world = TestWorld();
    final container = world.container();
    final sub = container.listen(todayProvider(slug), (_, _) {});
    addTearDown(sub.close);
    final before = await load(container);
    final target = before.view.runSheet.firstWhere((r) => !r.isCheckedIn && !r.isSession);

    await goOffline(container, world);
    await expectLater(
      container.read(todayProvider(slug).notifier).checkIn(target.id),
      throwsA(isA<ApiError>().having((e) => e.isNetwork, 'isNetwork', isTrue)),
    );
  });
}
