import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/app.dart';
import 'package:reservme/core/config/legal.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/retry_policy.dart';
import 'package:reservme/core/router/app_router.dart';
import 'package:reservme/core/router/routes.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/customer/account/presentation/account_screen.dart';
import 'package:reservme/features/onboarding/presentation/signup_screen.dart';
import 'package:reservme/features/venue/venues/application/selected_venue_controller.dart';

import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

/// What the store reviewers look for: a privacy policy reachable from inside
/// the app, and — on iOS — no subscription payment taken outside Apple's
/// in-app purchase.
void main() {
  late List<Uri> opened;
  setUp(() {
    opened = [];
    legalLauncher = (url) async {
      opened.add(url);
      return true;
    };
  });

  testWidgets('sign-up links Terms and Privacy, and a link tap leaves the box alone', (tester) async {
    await pumpApp(tester, const SignupScreen(), world: TestWorld(), surface: const Size(1080, 4800));
    await tester.pumpAndSettle();

    await tester.tapOnText(find.textRange.ofSubstring('Terms'));
    await tester.tapOnText(find.textRange.ofSubstring('Privacy Policy'));
    await tester.pumpAndSettle();

    expect(opened.map((u) => u.path), ['/terms', '/privacy']);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);
  });

  testWidgets('a customer reaches the privacy policy and the terms from Account', (tester) async {
    await pumpApp(tester, const AccountScreen(), world: TestWorld(), surface: const Size(1080, 7200));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Privacy policy'));
    await tester.tap(find.text('Terms of service'));
    expect(opened, [LegalPage.privacy.url, LegalPage.terms.url]);
  });

  Future<ProviderContainer> openBilling(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 4800);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final world = TestWorld();
    final container = ProviderContainer(overrides: world.overrides, retry: appRetryPolicy);
    addTearDown(() async {
      container.dispose();
      await world.local.dispose();
    });
    await container
        .read(authControllerProvider.notifier)
        .signIn(email: FakeAccounts.ownerEmail, password: FakeAccounts.password);
    container.read(selectedVenueSlugProvider.notifier).set(FakeVenues.katipunan);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const ReservMeApp()));
    await tester.pumpAndSettle();
    container.read(appRouterProvider).go(Routes.venueBilling);
    await tester.pumpAndSettle();
    return container;
  }

  testWidgets('Android: billing says how to pay', (tester) async {
    final container = await openBilling(tester);
    expect(find.text('YOUR PLAN'), findsOneWidget);
    expect(find.text('HOW TO PAY'), findsOneWidget);
    await container.read(authControllerProvider.notifier).signOut();
  });

  testWidgets('iOS: billing shows where things stand and never asks for payment', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final container = await openBilling(tester);
    expect(find.text('YOUR PLAN'), findsOneWidget);
    expect(find.text('HOW TO PAY'), findsNothing);
    expect(find.textContaining('InstaPay'), findsNothing);
    expect(find.text("I've paid — tell us"), findsNothing);
    await container.read(authControllerProvider.notifier).signOut();
    debugDefaultTargetPlatformOverride = null;
  });
}
