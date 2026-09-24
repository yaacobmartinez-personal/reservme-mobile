import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/core/storage/boot_data.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/venue/spaces/application/spaces_controller.dart';
import 'package:reservme/features/venue/waitlist/application/venue_waitlist_controller.dart';

import '../helpers/fakes.dart';

void main() {
  const slug = FakeVenues.katipunan;

  Future<void> signIn(ProviderContainer container, String email) => container
      .read(authControllerProvider.notifier)
      .signIn(email: email, password: FakeAccounts.password);

  group('spaces', () {
    test('the list carries pricing, peak and the paused space', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final spaces = await container.read(spacesProvider(slug).future);

      expect(spaces, isNotEmpty);
      expect(spaces.where((s) => !s.isActive), isNotEmpty);
      // Court 1 has a weekend peak rule above its base price.
      final withPeak = spaces.where((s) => s.hasPeak);
      expect(withPeak, isNotEmpty);
      expect(withPeak.first.peakPriceCents, greaterThan(withPeak.first.priceCents));
    });

    test('an owner can pause and unpause a space', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final sub = container.listen(spacesProvider(slug), (_, _) {});
      addTearDown(sub.close);
      final before = await container.read(spacesProvider(slug).future);
      final live = before.firstWhere((s) => s.isActive);

      await container.read(spacesProvider(slug).notifier).setActive(live.id, false);
      var now = await container.read(spacesProvider(slug).future);
      expect(now.firstWhere((s) => s.id == live.id).isActive, isFalse);

      await container.read(spacesProvider(slug).notifier).setActive(live.id, true);
      now = await container.read(spacesProvider(slug).future);
      expect(now.firstWhere((s) => s.id == live.id).isActive, isTrue);
    });

    test('front desk may look but not take a space off sale', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.staffEmail);
      final sub = container.listen(spacesProvider(slug), (_, _) {});
      addTearDown(sub.close);
      final spaces = await container.read(spacesProvider(slug).future);
      final live = spaces.firstWhere((s) => s.isActive);

      await expectLater(
        container.read(spacesProvider(slug).notifier).setActive(live.id, false),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 403)),
      );
      // And nothing changed.
      final after = await container.read(spacesProvider(slug).future);
      expect(after.firstWhere((s) => s.id == live.id).isActive, isTrue);
    });

    test('pausing a space takes it out of the customer-facing list', () async {
      final world = TestWorld(boot: const BootData(welcomeSeen: true));
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final sub = container.listen(spacesProvider(slug), (_, _) {});
      addTearDown(sub.close);
      final spaces = await container.read(spacesProvider(slug).future);
      final live = spaces.firstWhere((s) => s.isActive);

      await container.read(spacesProvider(slug).notifier).setActive(live.id, false);

      final venue = world.store.venueBySlug(slug)!;
      expect(
        world.store.spacesOf(venue.id, activeOnly: true).map((s) => s.id),
        isNot(contains(live.id)),
      );
    });
  });

  group('waitlist', () {
    test('entries come back oldest first, with their status', () async {
      final world = TestWorld();
      final container = world.container();

      final entries = await container.read(venueWaitlistProvider(slug).future);

      expect(entries, isNotEmpty);
      for (var i = 1; i < entries.length; i++) {
        expect(
          entries[i].createdAt.isBefore(entries[i - 1].createdAt),
          isFalse,
          reason: 'oldest first',
        );
      }
    });

    test('a notified entry counts down its claim window', () async {
      final world = TestWorld();
      final container = world.container();
      final entries = await container.read(venueWaitlistProvider(slug).future);
      final notified = entries.where((e) => e.isNotified);

      for (final entry in notified) {
        final left = entry.minutesLeft(testNow);
        expect(left, isNotNull);
        expect(left, greaterThanOrEqualTo(0));
      }
    });

    test('a passed claim window reads as zero, never negative', () async {
      final world = TestWorld();
      final container = world.container();
      final entries = await container.read(venueWaitlistProvider(slug).future);
      final anyEntry = entries.first;

      expect(
        anyEntry.minutesLeft(testNow.add(const Duration(days: 30))),
        anyOf(isNull, 0),
      );
    });
  });
}
