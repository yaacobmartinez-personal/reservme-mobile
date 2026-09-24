import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/onboarding/application/onboarding_controller.dart';
import 'package:reservme/features/onboarding/presentation/policy_screen.dart';
import 'package:reservme/features/onboarding/presentation/signup_screen.dart';
import 'package:reservme/features/onboarding/presentation/welcome_screen.dart';

import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

void main() {
  testWidgets('the welcome screen pitches the venue and offers a way out',
      (tester) async {
    final world = TestWorld();
    await pumpApp(tester, const WelcomeScreen(), world: world);
    await tester.pumpAndSettle();

    expect(find.textContaining('booked while'), findsOneWidget);
    expect(find.text('Start your venue — first month free'), findsOneWidget);
    // The one screen where both audiences meet, so customers get an exit.
    expect(find.text('Just booking? Find a venue →'), findsOneWidget);
  });

  testWidgets('signup refuses before it asks the server', (tester) async {
    final world = TestWorld();
    final container = await pumpApp(tester, const SignupScreen(), world: world, surface: const Size(1080, 3600));
    await tester.pumpAndSettle();

    expect(find.text('Step 1 of 6'), findsOneWidget);
    expect(find.text('At least 10 characters'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();
    expect(find.text('What should we call you?'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'Rafael');
    await tester.enterText(find.byType(TextField).at(1), 'nope');
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();
    expect(find.text("That email doesn't look right."), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(1), 'rafael@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'short');
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Use at least 10 characters.'), findsOneWidget);

    // Nothing was created while the form was wrong.
    expect(world.store.userByEmail('rafael@example.com'), isNull);
    expect(container.read(onboardingProvider).step, OnboardingStep.signup);
  });

  testWidgets('signup without the terms box is refused', (tester) async {
    final world = TestWorld();
    await pumpApp(tester, const SignupScreen(), world: world, surface: const Size(1080, 3600));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Rafael');
    await tester.enterText(find.byType(TextField).at(1), 'rafael@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'a-good-long-password');
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Please accept the terms to continue.'), findsOneWidget);
  });

  testWidgets('a complete signup creates the account and moves on',
      (tester) async {
    final world = TestWorld();
    final container = await pumpApp(tester, const SignupScreen(), world: world, surface: const Size(1080, 3600));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Rafael Katipunan');
    await tester.enterText(find.byType(TextField).at(1), 'rafael@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'a-good-long-password');
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(world.store.userByEmail('rafael@example.com'), isNotNull);
    expect(container.read(onboardingProvider).step, OnboardingStep.verify);
    // And a code was "emailed", which O2 then asks for.
    expect(world.store.emailCodes['rafael@example.com'], isNotNull);

    // Leave no session behind: its expiry timer would outlive the test.
    await container.read(authControllerProvider.notifier).signOut();
  });

  testWidgets('the policy step offers defaults and explains payment',
      (tester) async {
    final world = TestWorld();
    await pumpApp(tester, const PolicyScreen(), world: world, surface: const Size(1080, 3600));
    await tester.pumpAndSettle();

    expect(find.text('Step 6 of 6'), findsOneWidget);
    expect(find.text('Anytime before the booking'), findsOneWidget);
    expect(find.text('Never — they contact us'), findsOneWidget);
    // v1 is pay-at-venue, and the screen says so rather than implying online
    // payment is coming with a toggle.
    expect(find.text('Pay at the venue'), findsOneWidget);
    expect(find.text('Go live'), findsOneWidget);
  });
}
