import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/app.dart';
import 'package:reservme/core/network/retry_policy.dart';
import 'package:reservme/core/router/app_router.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/shell/application/app_mode_controller.dart';

import '../helpers/fakes.dart';

void main() {
  Future<ProviderContainer> boot(WidgetTester tester, TestWorld world) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final container = ProviderContainer(overrides: world.overrides, retry: appRetryPolicy);
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const ReservMeApp()),
    );
    await tester.pumpAndSettle();
    return container;
  }

  testWidgets('opens on the customer shell with three tabs', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world);

    expect(container.read(appRouterProvider).state.uri.path, '/c/find');
    expect(find.text('Find'), findsWidgets);
    expect(find.text('Bookings'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);

    await tester.tap(find.text('Bookings'));
    await tester.pumpAndSettle();
    expect(container.read(appRouterProvider).state.uri.path, '/c/bookings');
  });

  testWidgets('demo sign-in unlocks the venue shell and the picker', (tester) async {
    final world = TestWorld();
    final container = await boot(tester, world);

    await tester.tap(find.text('Account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Demo: sign in as the venue owner'));
    await tester.pumpAndSettle();

    // The owner has three venues, so the picker appears first.
    expect(container.read(authControllerProvider).hasVenueAccess, isTrue);
    expect(container.read(appRouterProvider).state.uri.path, '/v/venues');
    expect(find.text('Katipunan Courts'), findsOneWidget);

    await tester.tap(find.text('Katipunan Courts'));
    await tester.pumpAndSettle();
    expect(container.read(appRouterProvider).state.uri.path, '/v/today');
    expect(container.read(appModeControllerProvider), AppMode.venue);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('Customers'), findsOneWidget);

    // More → sign out → back to the customer shell.
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Sign out'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(container.read(appRouterProvider).state.uri.path, '/c/find');
    expect(container.read(authControllerProvider).isSignedIn, isFalse);
  });
}
