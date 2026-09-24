import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/venue/spaces/application/spaces_controller.dart';
import 'package:reservme/features/venue/spaces/presentation/space_editor_screen.dart';
import 'package:reservme/features/venue/venues/application/selected_venue_controller.dart';
import 'package:reservme/features/venue/venues/domain/venue_membership.dart';

import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

void main() {
  const katipunan = VenueMembership(
    orgId: 'v1',
    slug: FakeVenues.katipunan,
    name: 'Katipunan Courts',
    role: VenueRole.owner,
    timezone: 'Asia/Manila',
    currency: 'PHP',
    theme: VenueTheme.pine,
  );

  final asOwner = [selectedVenueProvider.overrideWithValue(katipunan)];

  /// The editor is keyed by id, so every test needs one from the seed first.
  Future<String> anActiveSpace(WidgetTester tester, TestWorld world) async {
    final container = world.container();
    await container
        .read(authControllerProvider.notifier)
        .signIn(email: FakeAccounts.ownerEmail, password: FakeAccounts.password);
    final spaces =
        await container.read(spacesProvider(FakeVenues.katipunan).future);
    final id = spaces.firstWhere((s) => s.isActive).id;
    await container.read(authControllerProvider.notifier).signOut();
    container.dispose();
    return id;
  }

  testWidgets('the editor shows the basics, the week and peak pricing',
      (tester) async {
    final world = TestWorld();
    final id = await anActiveSpace(tester, world);

    await pumpApp(
      tester,
      SpaceEditorScreen(spaceId: id),
      world: world,
      extraOverrides: asOwner,
      surface: const Size(1080, 3600),
    );
    await tester.pumpAndSettle();

    expect(find.text('BASICS'), findsOneWidget);
    expect(find.text('OPENING HOURS'), findsOneWidget);
    expect(find.text('PEAK PRICING'), findsOneWidget);
    expect(find.text('CLOSURES'), findsOneWidget);
    // Pausing is offered in full, because it is the reversible action.
    expect(find.text('Pause this space'), findsOneWidget);
    expect(find.text('Delete this space'), findsOneWidget);
  });

  testWidgets('the basics sheet refuses a nameless space in place',
      (tester) async {
    final world = TestWorld();
    final id = await anActiveSpace(tester, world);

    await pumpApp(
      tester,
      SpaceEditorScreen(spaceId: id),
      world: world,
      extraOverrides: asOwner,
      surface: const Size(1080, 3600),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TextButton, 'Edit').first);
    await tester.pumpAndSettle();
    expect(find.text('Edit space'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, '   ');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    // The refusal lands on the sheet, next to the field that caused it.
    expect(find.text('Give the space a name.'), findsOneWidget);
    expect(find.text('Edit space'), findsOneWidget);
  });

  testWidgets('a space with no open day says nobody can book it',
      (tester) async {
    final world = TestWorld();
    final id = await anActiveSpace(tester, world);
    // Close every day behind the screen's back, the way a bad save would.
    world.store.openingHours.removeWhere((h) => h.spaceId == id);

    await pumpApp(
      tester,
      SpaceEditorScreen(spaceId: id),
      world: world,
      extraOverrides: asOwner,
      surface: const Size(1080, 3600),
    );
    await tester.pumpAndSettle();

    expect(find.text('Nobody can book this space'), findsOneWidget);
  });
}
