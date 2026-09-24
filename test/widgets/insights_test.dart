import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/features/venue/insights/presentation/insights_screen.dart';
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

  testWidgets('the dashboard leads with the four numbers', (tester) async {
    await pumpApp(
      tester,
      const InsightsScreen(),
      world: TestWorld(),
      extraOverrides: asOwner,
      surface: const Size(1080, 3600),
    );
    await tester.pumpAndSettle();

    expect(find.text('Booked value'), findsOneWidget);
    expect(find.text('Bookings'), findsOneWidget);
    expect(find.text('Utilisation'), findsOneWidget);
    expect(find.text('No-shows'), findsOneWidget);
    expect(find.text('WHEN PEOPLE BOOK'), findsOneWidget);

    // Pay-at-venue: the screen never implies the money has arrived. The note
    // sits at the foot of a long list, so scroll to it.
    await tester.scrollUntilVisible(
      find.textContaining('not cash collected'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.textContaining('not cash collected'), findsOneWidget);
  });

  testWidgets('switching the period reloads the window', (tester) async {
    await pumpApp(
      tester,
      const InsightsScreen(),
      world: TestWorld(),
      extraOverrides: asOwner,
      surface: const Size(1080, 3600),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('7 days'));
    await tester.pumpAndSettle();

    expect(find.text('Booked value'), findsOneWidget);
  });

  testWidgets('an empty window says so rather than drawing four flat charts',
      (tester) async {
    final world = TestWorld();
    world.store.reservations.clear();

    await pumpApp(
      tester,
      const InsightsScreen(),
      world: world,
      extraOverrides: asOwner,
      surface: const Size(1080, 3600),
    );
    await tester.pumpAndSettle();

    expect(find.text('Nothing booked in this window'), findsOneWidget);
    expect(find.text('Booked value'), findsNothing);
  });
}
