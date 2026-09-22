import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/auth/presentation/login_screen.dart';

import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

void main() {
  Future<void> fill(WidgetTester tester, String email, String password) async {
    await tester.enterText(find.widgetWithText(TextField, 'Email'), email);
    await tester.enterText(find.widgetWithText(TextField, 'Password'), password);
  }

  testWidgets('the right password opens a session', (tester) async {
    final world = TestWorld();
    final container = await pumpApp(tester, const LoginScreen(), world: world);

    await fill(tester, FakeAccounts.ownerEmail, FakeAccounts.password);
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(container.read(authControllerProvider).isSignedIn, isTrue);

    // Leave no session behind: the expiry timer would outlive the test.
    await container.read(authControllerProvider.notifier).signOut();
  });

  testWidgets('a wrong password shows the server wording and stays put', (tester) async {
    final world = TestWorld();
    final container = await pumpApp(tester, const LoginScreen(), world: world);

    await fill(tester, FakeAccounts.ownerEmail, 'wrong');
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.textContaining("don't match"), findsOneWidget);
    expect(container.read(authControllerProvider).isSignedIn, isFalse);
    // The button is usable again rather than stuck spinning.
    expect(
      tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Sign in')).onPressed,
      isNotNull,
    );
  });

  testWidgets('an empty form is refused before any request', (tester) async {
    final world = TestWorld();
    await pumpApp(tester, const LoginScreen(), world: world);

    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Enter your email and password.'), findsOneWidget);
  });

  testWidgets('the demo chip fills the seeded owner in fake mode', (tester) async {
    final world = TestWorld();
    await pumpApp(tester, const LoginScreen(), world: world);

    await tester.tap(find.text('Owner'));
    await tester.pump();

    expect(find.text(FakeAccounts.ownerEmail), findsOneWidget);
  });

  testWidgets('customers are pointed back to the side without accounts', (tester) async {
    final world = TestWorld();
    await pumpApp(tester, const LoginScreen(), world: world);

    expect(find.text('Just booking a court?'), findsOneWidget);
    expect(find.text('Find a venue'), findsOneWidget);
  });
}
