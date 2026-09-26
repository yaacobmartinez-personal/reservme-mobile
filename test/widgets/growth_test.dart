import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/app.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/retry_policy.dart';
import 'package:reservme/core/router/app_router.dart';
import 'package:reservme/core/router/routes.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/venue/venues/application/selected_venue_controller.dart';

import '../helpers/fakes.dart';

void main() {
  /// The whole app, signed in with Katipunan selected, so every entry point is
  /// reached through the router rather than by pumping a screen directly.
  Future<ProviderContainer> boot(WidgetTester tester, TestWorld world, {String email = FakeAccounts.ownerEmail}) async {
    tester.view.physicalSize = const Size(1080, 4800);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final container = ProviderContainer(overrides: world.overrides, retry: appRetryPolicy);
    addTearDown(() async {
      container.dispose();
      await world.local.dispose();
    });
    await container
        .read(authControllerProvider.notifier)
        .signIn(email: email, password: FakeAccounts.password);
    container.read(selectedVenueSlugProvider.notifier).set(FakeVenues.katipunan);
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const ReservMeApp()),
    );
    await tester.pumpAndSettle();
    return container;
  }

  Future<void> finish(ProviderContainer container) =>
      container.read(authControllerProvider.notifier).signOut();

  Future<void> openFromMore(WidgetTester tester, ProviderContainer container, String label) async {
    container.read(appRouterProvider).go(Routes.venueMore);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text(label));
    await tester.pumpAndSettle();
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();
  }

  testWidgets('More reaches all four, and a plan is made in its sheet', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world);

    for (final (label, route) in [
      ('Promos & reviews', Routes.venueMarketing),
      ('Integrations', Routes.venueIntegrations),
      ('Export', Routes.venueExport),
      ('Passes & memberships', Routes.venueMemberships),
    ]) {
      await openFromMore(tester, container, label);
      expect(container.read(appRouterProvider).state.uri.path, route, reason: label);
    }

    // On Passes & memberships now: the seeded plans, then a new one.
    expect(find.text('10-game pass'), findsOneWidget);
    await tester.tap(find.text('New plan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create plan'));
    await tester.pumpAndSettle();
    expect(find.text('Give the plan a name.'), findsOneWidget, reason: 'refused in place, sheet still open');

    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Morning club');
    await tester.enterText(find.widgetWithText(TextField, 'Price'), '800');
    await tester.enterText(find.widgetWithText(TextField, 'Discount'), '20');
    await tester.tap(find.text('Create plan'));
    await tester.pumpAndSettle();

    expect(find.text('Morning club'), findsOneWidget);
    expect(world.store.plans.any((p) => p.name == 'Morning club' && p.priceCents == 80000), isTrue);
    await finish(container);
  });

  testWidgets('a pass sold at the desk shows on the customer\'s profile', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world);
    final venue = world.store.venueBySlug(FakeVenues.katipunan)!;
    final customer = world.store.customers.firstWhere(
      (c) => c.venueId == venue.id && world.store.holdings.every((h) => h.customerId != c.id),
    );

    container.read(appRouterProvider).go(Routes.customer(customer.id));
    await tester.pumpAndSettle();
    expect(find.text('None. A pass or membership sold at the desk goes here.'), findsOneWidget);
    expect(find.textContaining('loyalty point'), findsOneWidget);

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('10-game pass'));
    await tester.pumpAndSettle();

    expect(find.textContaining('10 credits left'), findsOneWidget);
    expect(world.store.holdings.where((h) => h.customerId == customer.id), hasLength(1));
    await finish(container);
  });

  testWidgets('an API key is shown once, in a dialog that will not dismiss by accident', (tester) async {
    // Nothing answers the clipboard channel in a test; answer it.
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String?;
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));

    final world = TestWorld();
    final container = await boot(tester, world);
    await openFromMore(tester, container, 'Integrations');

    await tester.tap(find.text('Create key'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Accounting');
    await tester.tap(find.widgetWithText(FilledButton, 'Create key'));
    await tester.pumpAndSettle();

    expect(find.text('Copy your key now'), findsOneWidget);
    final key = world.store.apiKeys.single;
    expect(find.textContaining(key.prefix), findsWidgets);

    // A tap outside does not close it.
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text('Copy your key now'), findsOneWidget);

    await tester.tap(find.text('Copy and close'));
    await tester.pumpAndSettle();
    expect(find.text('Copy your key now'), findsNothing);
    expect(copied, startsWith(key.prefix), reason: 'the whole key went to the clipboard');
    expect(find.text('Accounting'), findsOneWidget);
    await finish(container);
  });

  testWidgets('front-desk staff see promos but no create button', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world, email: FakeAccounts.staffEmail);
    await openFromMore(tester, container, 'Promos & reviews');

    expect(find.text('WELCOME10'), findsOneWidget);
    expect(find.text('New code'), findsNothing);
    await finish(container);
  });
}
