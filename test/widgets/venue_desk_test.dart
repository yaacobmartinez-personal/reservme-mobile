import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/time/app_time.dart';
import 'package:reservme/features/venue/calendar/application/calendar_controller.dart';
import 'package:reservme/features/venue/calendar/presentation/calendar_screen.dart';
import 'package:reservme/features/venue/customers/application/customers_controller.dart';
import 'package:reservme/features/venue/customers/presentation/customer_detail_screen.dart';
import 'package:reservme/features/venue/customers/presentation/customers_screen.dart';
import 'package:reservme/features/venue/spaces/presentation/spaces_screen.dart';
import 'package:reservme/features/venue/venues/application/selected_venue_controller.dart';
import 'package:reservme/features/venue/venues/domain/venue_membership.dart';
import 'package:reservme/features/venue/waitlist/presentation/waitlist_screen.dart';

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

  group('calendar', () {
    testWidgets('draws a lane per space with the day is bookings', (tester) async {
      final world = TestWorld();
      final container = await pumpApp(
        tester,
        const CalendarScreen(),
        world: world,
        extraOverrides: asOwner,
      );
      await tester.pumpAndSettle();

      expect(find.text('Calendar'), findsWidgets);
      expect(find.text('Court 1'), findsOneWidget);
      expect(find.text('Court 2'), findsOneWidget);

      final date = AppTime.today(testNow, katipunan.timezone);
      final state = await container.read(
        calendarProvider(katipunan.slug, date).future,
      );
      final someone = state.day.lanes
          .expand((l) => l.items)
          .firstWhere((i) => i.isBooking);
      expect(find.text(someone.title), findsWidgets);
    });

    testWidgets('the seeded block shows its reason, not a booking', (tester) async {
      final world = TestWorld();
      await pumpApp(
        tester,
        const CalendarScreen(),
        world: world,
        extraOverrides: asOwner,
      );
      await tester.pumpAndSettle();

      expect(find.text('Blocked'), findsWidgets);
      expect(find.text('Net repair'), findsWidgets);
    });

    testWidgets('a block can be lifted from its sheet', (tester) async {
      final world = TestWorld();
      final container = await pumpApp(
        tester,
        const CalendarScreen(),
        world: world,
        extraOverrides: asOwner,
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Blocked').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Blocked').first);
      await tester.pumpAndSettle();

      expect(find.text('Lift this block'), findsOneWidget);
      await tester.tap(find.text('Lift this block'));
      await tester.pumpAndSettle();

      expect(find.textContaining('bookable again'), findsOneWidget);
      final date = AppTime.today(testNow, katipunan.timezone);
      final state = await container.read(
        calendarProvider(katipunan.slug, date).future,
      );
      expect(state.day.lanes.expand((l) => l.items).where((i) => i.isBlock), isEmpty);
    });

    testWidgets('the new-booking sheet refuses a walk-in with no details',
        (tester) async {
      final world = TestWorld();
      await pumpApp(
        tester,
        const CalendarScreen(),
        world: world,
        extraOverrides: asOwner,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('New booking'));
      await tester.pumpAndSettle();
      expect(find.text('New booking'), findsWidgets);

      await tester.tap(find.textContaining('Book Court'));
      await tester.pumpAndSettle();

      expect(
        find.text('Choose a customer, or enter a name and email.'),
        findsOneWidget,
      );
    });
  });

  group('customers', () {
    testWidgets('the list shows the count and filters by segment', (tester) async {
      final world = TestWorld();
      final container = await pumpApp(
        tester,
        const CustomersScreen(),
        world: world,
        extraOverrides: asOwner,
      );
      await tester.pumpAndSettle();

      final page = await container.read(customersProvider(katipunan.slug).future);
      expect(find.text('${page.total} customers'), findsOneWidget);
      expect(find.text('All'), findsOneWidget);

      await tester.tap(find.text('No-shows'));
      await tester.pumpAndSettle();
      expect(find.textContaining('no-show'), findsWidgets);
    });

    testWidgets('an unmatched search says so instead of showing nothing',
        (tester) async {
      final world = TestWorld();
      await pumpApp(
        tester,
        const CustomersScreen(),
        world: world,
        extraOverrides: asOwner,
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'zzzzz');
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpAndSettle();

      expect(find.text('Nobody matches "zzzzz"'), findsOneWidget);
    });

    testWidgets('a note can be added from the detail screen', (tester) async {
      final world = TestWorld();
      final container = await pumpApp(
        tester,
        const CustomersScreen(),
        world: world,
        extraOverrides: asOwner,
      );
      await tester.pumpAndSettle();
      final page = await container.read(customersProvider(katipunan.slug).future);
      final someone = page.rows.first;

      await tester.pumpWidget(const SizedBox());
      await pumpApp(
        tester,
        CustomerDetailScreen(customerId: someone.id),
        world: world,
        extraOverrides: asOwner,
      );
      await tester.pumpAndSettle();

      expect(find.text(someone.name), findsWidgets);
      expect(find.text('Visits'), findsOneWidget);

      await tester.tap(find.text('Add note'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'Prefers Court 3.');
      await tester.tap(find.widgetWithText(FilledButton, 'Save'));
      await tester.pumpAndSettle();

      expect(find.text('Prefers Court 3.'), findsOneWidget);
    });
  });

  group('spaces', () {
    testWidgets('a paused space says so and its switch is off', (tester) async {
      final world = TestWorld();
      await pumpApp(
        tester,
        const SpacesScreen(),
        world: world,
        extraOverrides: asOwner,
      );
      await tester.pumpAndSettle();

      expect(find.text('Active spaces set your billing band'), findsOneWidget);
      expect(find.text('Paused · not bookable'), findsOneWidget);
      final switches = tester.widgetList<Switch>(find.byType(Switch)).toList();
      expect(switches.where((s) => !s.value), hasLength(1));
    });
  });

  group('waitlist', () {
    testWidgets('shows the queue oldest first with the auto-fill note',
        (tester) async {
      final world = TestWorld();
      await pumpApp(
        tester,
        const WaitlistScreen(),
        world: world,
        extraOverrides: asOwner,
      );
      await tester.pumpAndSettle();

      expect(find.text('Auto-fills on cancellation'), findsOneWidget);
      expect(find.textContaining('oldest first'), findsOneWidget);
      // The queue runs past the fold, so look into the list, not just the
      // painted part of it.
      expect(find.text('Waiting', skipOffstage: false), findsWidgets);
      expect(find.textContaining('Notified', skipOffstage: false), findsWidgets);
    });
  });
}
