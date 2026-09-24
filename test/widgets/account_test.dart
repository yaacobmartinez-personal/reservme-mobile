import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/auth/presentation/reset_password_screen.dart';
import 'package:reservme/features/venue/account/presentation/owner_account_screen.dart';

import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

void main() {
  testWidgets('the account screen shows who you are and where you work',
      (tester) async {
    final world = TestWorld();
    final container = await pumpApp(
      tester,
      const OwnerAccountScreen(),
      world: world,
      surface: const Size(1080, 3600),
    );
    await container.read(authControllerProvider.notifier).signIn(
          email: FakeAccounts.ownerEmail,
          password: FakeAccounts.password,
        );
    await tester.pumpAndSettle();

    expect(find.text('SIGNED IN AS'), findsOneWidget);
    expect(find.text(FakeAccounts.ownerEmail), findsOneWidget);
    expect(find.text('WHERE YOU WORK'), findsOneWidget);
    expect(find.text('Delete your account'), findsOneWidget);

    await container.read(authControllerProvider.notifier).signOut();
  });

  testWidgets('deleting asks you to type the word first', (tester) async {
    final world = TestWorld();
    final container = await pumpApp(
      tester,
      const OwnerAccountScreen(),
      world: world,
      surface: const Size(1080, 3600),
    );
    await container.read(authControllerProvider.notifier).signIn(
          email: FakeAccounts.ownerEmail,
          password: FakeAccounts.password,
        );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Delete your account'));
    await tester.pumpAndSettle();

    expect(find.text('Delete your account'), findsWidgets);
    // The confirm button is dead until the word is typed, so a mis-tap
    // cannot end an account.
    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Delete my account'),
    );
    expect(button.onPressed, isNull);

    await tester.enterText(find.byType(TextField).last, 'delete');
    await tester.pumpAndSettle();
    final armed = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Delete my account'),
    );
    expect(armed.onPressed, isNotNull);

    await container.read(authControllerProvider.notifier).signOut();
  });

  testWidgets('a reset finishes in the app, not on the website',
      (tester) async {
    final world = TestWorld();
    final container = await pumpApp(
      tester,
      const ResetPasswordScreen(email: FakeAccounts.ownerEmail),
      world: world,
      surface: const Size(1080, 3600),
    );
    await container
        .read(authControllerProvider.notifier)
        .requestPasswordReset(FakeAccounts.ownerEmail);
    await tester.pumpAndSettle();

    expect(find.text('Check your email'), findsOneWidget);

    // A short password is refused in place rather than at the server.
    await tester.enterText(find.byType(TextField).at(0), '000000');
    await tester.enterText(find.byType(TextField).at(1), 'short');
    await tester.tap(find.widgetWithText(FilledButton, 'Change password'));
    await tester.pumpAndSettle();
    expect(find.text('Use at least 10 characters.'), findsOneWidget);

    // And a wrong code is refused by the server, with its own wording.
    await tester.enterText(find.byType(TextField).at(1), 'a-good-long-password');
    await tester.tap(find.widgetWithText(FilledButton, 'Change password'));
    await tester.pumpAndSettle();
    expect(
      find.text("That code doesn't match. Check the email again."),
      findsOneWidget,
    );
  });
}
