import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/app.dart';
import 'package:reservme/core/fake/fake_store.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/retry_policy.dart';
import 'package:reservme/core/router/app_router.dart';
import 'package:reservme/core/router/routes.dart';
import 'package:reservme/features/admin/presentation/admin_home_screen.dart';
import 'package:reservme/features/admin/presentation/admin_payments_screen.dart';
import 'package:reservme/features/admin/presentation/admin_tenant_screen.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/venue/venues/application/selected_venue_controller.dart';

import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

void main() {
  Future<void> signIn(ProviderContainer container, String email) => container
      .read(authControllerProvider.notifier)
      .signIn(email: email, password: FakeAccounts.password);

  FakeBillingPayment submit(TestWorld world, String slug, String reference) {
    final pay = FakeBillingPayment(
      id: world.store.nextId('pay'),
      venueId: world.store.venueBySlug(slug)!.id,
      amountCents: 49900,
      reference: reference,
      paidAt: '2026-09-20',
      createdAt: world.now,
    );
    world.store.billingPayments.add(pay);
    return pay;
  }

  /// The whole app, signed in, so entry points are tested through the router
  /// rather than by pumping a screen nothing might reach.
  Future<ProviderContainer> boot(WidgetTester tester, TestWorld world, String email) async {
    // Tall, so More's last rows are built rather than below the fold.
    tester.view.physicalSize = const Size(1080, 4800);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final container = ProviderContainer(overrides: world.overrides, retry: appRetryPolicy);
    addTearDown(() async {
      container.dispose();
      await world.local.dispose();
    });
    await signIn(container, email);
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const ReservMeApp()),
    );
    await tester.pumpAndSettle();
    return container;
  }

  testWidgets('a platform admin reaches the console from More', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world, FakeAccounts.ownerEmail);

    // The demo owner runs three venues; without one picked, /v goes to the picker.
    container.read(selectedVenueSlugProvider.notifier).set(FakeVenues.katipunan);
    container.read(appRouterProvider).go(Routes.venueMore);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Platform admin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Platform admin'));
    await tester.pumpAndSettle();

    expect(container.read(appRouterProvider).state.uri.path, Routes.admin);
    expect(find.text('NEEDS AN EYE'), findsOneWidget);

    // Sign-in arms the session-expiry timer; ending the session cancels it.
    await container.read(authControllerProvider.notifier).signOut();
  });

  testWidgets('staff see no way in, and a typed link bounces them', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world, FakeAccounts.staffEmail);

    container.read(appRouterProvider).go(Routes.venueMore);
    await tester.pumpAndSettle();
    expect(find.text('Platform admin'), findsNothing);

    container.read(appRouterProvider).go(Routes.adminPayments);
    await tester.pumpAndSettle();
    expect(container.read(appRouterProvider).state.uri.path, isNot(startsWith(Routes.admin)));

    // Sign-in arms the session-expiry timer; ending the session cancels it.
    await container.read(authControllerProvider.notifier).signOut();
  });

  testWidgets('the front page flags waiting payments and the unpaid venue', (tester) async {
    final world = TestWorld();
    submit(world, FakeVenues.katipunan, 'REF-HOME');
    final container = await pumpApp(
      tester,
      const AdminHomeScreen(),
      world: world,
      surface: const Size(1080, 4800),
      setup: (c) => signIn(c, FakeAccounts.ownerEmail),
    );
    await tester.pumpAndSettle();

    expect(find.text('1 payment to review'), findsOneWidget);
    expect(find.text('Switched off for non-payment'), findsOneWidget);
    expect(find.text('Marikina Futsal'), findsWidgets);

    // Sign-in arms the session-expiry timer; ending the session cancels it.
    await container.read(authControllerProvider.notifier).signOut();
  });

  testWidgets('approving a payment clears it and brings the venue back', (tester) async {
    final world = TestWorld();
    submit(world, FakeVenues.marikinaFutsal, 'REF-MARIKINA');
    final marikina = world.store.venueBySlug(FakeVenues.marikinaFutsal)!;
    expect(marikina.suspended, isTrue);

    final container = await pumpApp(
      tester,
      const AdminPaymentsScreen(),
      world: world,
      setup: (c) => signIn(c, FakeAccounts.ownerEmail),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('REF-MARIKINA'), findsOneWidget);

    await tester.tap(find.text('Approve'));
    await tester.pumpAndSettle();
    // The dialog's own Approve.
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.text('Approve')));
    await tester.pumpAndSettle();

    expect(find.textContaining('REF-MARIKINA'), findsNothing);
    expect(find.text('Nothing to review'), findsOneWidget);
    expect(marikina.suspended, isFalse);

    // Sign-in arms the session-expiry timer; ending the session cancels it.
    await container.read(authControllerProvider.notifier).signOut();
  });

  testWidgets('rejecting asks for a note and keeps it', (tester) async {
    final world = TestWorld();
    final pay = submit(world, FakeVenues.katipunan, 'REF-BAD');
    final container = await pumpApp(
      tester,
      const AdminPaymentsScreen(),
      world: world,
      setup: (c) => signIn(c, FakeAccounts.ownerEmail),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Reject'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'No transfer with that reference');
    await tester.tap(find.widgetWithText(TextButton, 'Reject'));
    await tester.pumpAndSettle();

    expect(pay.status, 'rejected');
    expect(pay.note, 'No transfer with that reference');

    // Sign-in arms the session-expiry timer; ending the session cancels it.
    await container.read(authControllerProvider.notifier).signOut();
  });

  testWidgets('suspending a venue from its page takes the reason', (tester) async {
    final world = TestWorld();
    final norte = world.store.venueBySlug(FakeVenues.studioNorte)!;
    final container = await pumpApp(
      tester,
      AdminTenantScreen(orgId: norte.id),
      world: world,
      surface: const Size(1080, 4800),
      setup: (c) => signIn(c, FakeAccounts.ownerEmail),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Suspend'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Chargeback dispute');
    await tester.tap(find.widgetWithText(TextButton, 'Suspend'));
    await tester.pumpAndSettle();

    expect(norte.suspendedReason, 'Chargeback dispute');
    expect(find.text('Reactivate'), findsOneWidget, reason: 'the page shows the new state');

    // Sign-in arms the session-expiry timer; ending the session cancels it.
    await container.read(authControllerProvider.notifier).signOut();
  });
}
