import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/app.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/retry_policy.dart';
import 'package:reservme/core/router/app_router.dart';
import 'package:reservme/features/customer/booking/application/book_controller.dart';
import 'package:reservme/features/customer/booking/domain/booking.dart';
import 'package:reservme/features/customer/customer_providers.dart';
import 'package:reservme/features/customer/wallet/application/wallet_controller.dart';
import 'package:reservme/features/customer/wallet/presentation/booking_detail_screen.dart';

import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

/// The whole customer loop through the real screens: find → venue → slot →
/// details → booked → wallet.
void main() {
  Future<ProviderContainer> boot(WidgetTester tester, TestWorld world) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final container = ProviderContainer(overrides: world.overrides, retry: appRetryPolicy);
    addTearDown(() async {
      container.dispose();
      await world.local.dispose();
    });
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const ReservMeApp()),
    );
    await tester.pumpAndSettle();
    return container;
  }

  testWidgets('a venue code opens the venue page with its spaces', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world);

    await tester.enterText(find.byType(TextField).first, FakeVenues.katipunan);
    await tester.testTextInput.receiveAction(TextInputAction.go);
    await tester.pumpAndSettle();

    expect(container.read(appRouterProvider).state.uri.path, '/c/find/venues/katipunan');
    expect(find.text('Katipunan Courts'), findsWidgets);
    expect(find.text('Court 1'), findsOneWidget);
    expect(find.text('Court 5 (annex)'), findsNothing); // paused space
  });

  testWidgets('an unknown code is refused before any request', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world);

    await tester.enterText(find.byType(TextField).first, 'Not A Slug!');
    await tester.testTextInput.receiveAction(TextInputAction.go);
    await tester.pumpAndSettle();

    expect(find.text("That doesn't look like a venue code."), findsOneWidget);
    expect(container.read(appRouterProvider).state.uri.path, '/c/find');
  });

  testWidgets('booking a slot saves it to the wallet', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world);

    // Find → venue
    await tester.enterText(find.byType(TextField).first, FakeVenues.katipunan);
    await tester.testTextInput.receiveAction(TextInputAction.go);
    await tester.pumpAndSettle();

    // Venue → slot picker
    await tester.tap(find.text('Court 1'));
    await tester.pumpAndSettle();
    expect(find.textContaining('TIME ·'), findsOneWidget);

    // Pick the first open slot: its tile shows a price, so find by the peso.
    final open = find.textContaining('₱').first;
    await tester.tap(open);
    await tester.pumpAndSettle();
    expect(find.text('Continue'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text("WHO'S BOOKING"), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Maria Santos');
    await tester.enterText(find.widgetWithText(TextField, 'Email'), 'maria@example.com');
    await tester.pumpAndSettle();

    await tester.tap(find.textContaining('Confirm booking'));
    await tester.pumpAndSettle();

    // Landed on the booking, and it is in the wallet.
    expect(container.read(appRouterProvider).state.uri.path, startsWith('/c/bookings/katipunan/'));
    expect(find.text("You're booked"), findsOneWidget);
    expect(find.text('REFERENCE'), findsOneWidget);

    // Hold a subscription: nothing on screen watches the wallet right now, so
    // an auto-disposed stream provider would be torn down mid-read.
    final sub = container.listen(walletProvider, (_, _) {});
    addTearDown(sub.close);
    final saved = await container.read(walletProvider.future);
    expect(saved, hasLength(1));
    expect(saved.first.venue.slug, FakeVenues.katipunan);

    // The contact details are remembered for next time.
    final contact = await container.read(savedContactProvider.future);
    expect(contact.name, 'Maria Santos');
    expect(contact.email, 'maria@example.com');
  });

  testWidgets('the booking form refuses an obviously wrong email', (tester) async {
    final world = TestWorld();
    await boot(tester, world);

    await tester.enterText(find.byType(TextField).first, FakeVenues.katipunan);
    await tester.testTextInput.receiveAction(TextInputAction.go);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Court 1'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('₱').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Maria');
    await tester.enterText(find.widgetWithText(TextField, 'Email'), 'nope');
    await tester.tap(find.textContaining('Confirm booking'));
    await tester.pumpAndSettle();

    expect(find.text("That email doesn't look right."), findsOneWidget);
  });

  testWidgets('a booking the policy freezes offers neither button',
      (tester) async {
    // Cancel was gated on the policy and Reschedule was not, so a booking
    // inside its grace window let the customer pick through seven days of
    // slots and meet the refusal at the very end. Both are the same rule.
    final world = TestWorld();
    final container = world.container();

    final venue = await container.read(venuesRepositoryProvider).bySlug(
          FakeVenues.katipunan,
        );
    final space = venue.spaces.first;

    // A booking starting inside the venue's cancellation grace window.
    final soon = world.now.add(const Duration(hours: 2));
    final outcome = await container.read(bookingRepositoryProvider).book(
          venueSlug: FakeVenues.katipunan,
          input: BookingInput(
            spaceId: space.id,
            startsAt: soon,
            endsAt: soon.add(const Duration(hours: 1)),
            name: 'Rafael',
            email: 'rafael@example.com',
          ),
        );

    // Asserted rather than skipped: an early return here would let this test
    // pass by finding nothing, which is how the last two regression tests in
    // this repo went wrong.
    expect(outcome, isA<Booked>(), reason: 'the slot two hours out was free');
    final booking = (outcome as Booked).booking;
    expect(
      booking.cancellation.canCancel,
      isFalse,
      reason: 'two hours out is inside the venue 24-hour grace window',
    );

    await pumpApp(
      tester,
      BookingDetailScreen(slug: FakeVenues.katipunan, token: booking.manageToken!),
      world: world,
    );
    await tester.pumpAndSettle();

    final reschedule = tester.widget<OutlinedButton>(
      find.ancestor(
        of: find.text('Reschedule'),
        matching: find.byType(OutlinedButton),
      ),
    );
    final cancel = tester.widget<OutlinedButton>(
      find.ancestor(
        of: find.text('Cancel'),
        matching: find.byType(OutlinedButton),
      ),
    );

    expect(cancel.onPressed, isNull, reason: 'the policy forbids cancelling');
    expect(
      reschedule.onPressed,
      isNull,
      reason: 'the same policy forbids moving it',
    );
  });

  testWidgets('the wallet is empty until something is booked', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world);

    await tester.tap(find.text('Bookings'));
    await tester.pumpAndSettle();

    expect(find.text('No bookings yet'), findsOneWidget);
    final sub = container.listen(walletProvider, (_, _) {});
    addTearDown(sub.close);
    expect(await container.read(walletProvider.future), isEmpty);
  });
}
