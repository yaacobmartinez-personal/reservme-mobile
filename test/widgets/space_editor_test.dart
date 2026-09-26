import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/widgets/app_choice_chip.dart';
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

  testWidgets('a picked day still says which day it is', (tester) async {
    // Material paints a selected chip's label from the colour scheme rather
    // than from our tokens, and against this theme that came out the same
    // shade as the fill — so a picked day rendered as a filled pill with
    // nothing written on it, and the sheet could not say what the rule
    // covered. Found on a device; invisible to a test that only counts chips.
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

    await tester.tap(find.widgetWithText(TextButton, 'Add').first);
    await tester.pumpAndSettle();
    expect(find.text('Peak pricing'), findsOneWidget);

    // Every weekday is on a chip, selected or not.
    for (final day in ['Mon', 'Sat', 'Sun']) {
      expect(find.widgetWithText(AppChoiceChip, day), findsOneWidget, reason: day);
    }

    // Finding the text is not the test — the label was always *there*, it was
    // painted the colour of the fill behind it. So this asserts the two
    // differ, in whichever state the chip is in.
    void expectReadable(String day) {
      final chip = tester.widget<ChoiceChip>(
        find.descendant(
          of: find.widgetWithText(AppChoiceChip, day),
          matching: find.byType(ChoiceChip),
        ),
      );
      final labelFinder = find.descendant(
        of: find.widgetWithText(AppChoiceChip, day),
        matching: find.text(day),
      );
      final label = tester.widget<Text>(labelFinder);
      final background = chip.selected
          ? chip.selectedColor
          : Theme.of(tester.element(labelFinder)).chipTheme.backgroundColor;
      final foreground = (label.style ?? chip.labelStyle)?.color;

      expect(foreground, isNotNull, reason: '$day has no label colour');
      expect(
        foreground,
        isNot(background),
        reason: '$day is written in the colour of the pill behind it',
      );
    }

    expectReadable('Mon'); // selected by default
    expectReadable('Sat'); // not

    await tester.tap(find.widgetWithText(AppChoiceChip, 'Sat'));
    await tester.pumpAndSettle();
    expectReadable('Sat'); // and still readable once picked
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
