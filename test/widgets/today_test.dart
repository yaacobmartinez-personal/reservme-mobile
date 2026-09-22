import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/features/venue/today/application/today_controller.dart';
import 'package:reservme/features/venue/today/domain/run_sheet.dart';
import 'package:reservme/features/venue/today/presentation/today_screen.dart';
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

  final overrides = [selectedVenueProvider.overrideWithValue(katipunan)];

  testWidgets('the run sheet lists the day with its stats', (tester) async {
    final world = TestWorld();
    final container = await pumpApp(
      tester,
      const TodayScreen(),
      world: world,
      extraOverrides: overrides,
    );
    await tester.pumpAndSettle();

    expect(find.text('Today'), findsWidgets);
    expect(find.text('Bookings'), findsOneWidget);
    expect(find.text('Checked in'), findsOneWidget);
    expect(find.text('RUN SHEET'), findsOneWidget);
    expect(find.text('Live'), findsOneWidget);

    final view = (await container.read(todayProvider(katipunan.slug).future)).view;
    expect(find.text(view.runSheet.first.customerName ?? 'Walk-in'), findsWidgets);
  });

  testWidgets('checking someone in is confirmed on the row', (tester) async {
    final world = TestWorld();
    final container = await pumpApp(
      tester,
      const TodayScreen(),
      world: world,
      extraOverrides: overrides,
    );
    await tester.pumpAndSettle();

    final view = (await container.read(todayProvider(katipunan.slug).future)).view;
    final target = view.runSheet.firstWhere(
      (r) => r.customerName != null && !r.isSession && !r.isCheckedIn,
    );

    // Any row opens its actions; the due one also has them inline.
    await tester.ensureVisible(find.text(target.customerName!).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(target.customerName!).first);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Check in'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Checked in'), findsWidgets);
    final after = (await container.read(todayProvider(katipunan.slug).future)).view;
    expect(after.runSheet.firstWhere((r) => r.id == target.id).isCheckedIn, isTrue);
  });

  testWidgets('cancelling asks first, then says the slot is free', (tester) async {
    final world = TestWorld();
    final container = await pumpApp(
      tester,
      const TodayScreen(),
      world: world,
      extraOverrides: overrides,
    );
    await tester.pumpAndSettle();

    final view = (await container.read(todayProvider(katipunan.slug).future)).view;
    final target = view.runSheet.firstWhere(
      (r) => r.customerName != null && !r.isSession,
    );

    await tester.ensureVisible(find.text(target.customerName!).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(target.customerName!).first);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Cancel booking'));
    await tester.pumpAndSettle();

    // Nothing has happened yet — the dialog is the gate.
    expect(find.textContaining('goes back on sale'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Cancel booking'));
    await tester.pumpAndSettle();

    expect(find.textContaining('the slot is free'), findsOneWidget);
    final after = (await container.read(todayProvider(katipunan.slug).future)).view;
    expect(after.runSheet.where((r) => r.id == target.id), isEmpty);
  });

  testWidgets('offline shows the saved copy and withdraws the actions', (tester) async {
    final world = TestWorld(online: false);
    final saved = TodayView(
      date: '2026-09-26',
      stats: const VenueStats(todayCount: 2, checkedIn: 1, activeSpaces: 4, totalSpaces: 5),
      runSheet: [
        RunSheetEntry(
          id: 'r1',
          reference: 'SK4-33BY',
          spaceName: 'Court 1',
          customerId: 'c1',
          customerName: 'Ana Reyes',
          label: '16:00–17:00',
          startsAt: DateTime.utc(2026, 9, 26, 8),
          endsAt: DateTime.utc(2026, 9, 26, 9),
          amountCents: 45000,
        ),
      ],
    );

    await pumpApp(
      tester,
      const TodayScreen(),
      world: world,
      extraOverrides: overrides,
      setup: (_) => world.local.saveVenueCache(
        katipunan.slug,
        Today.cacheKey,
        jsonDecode(jsonEncode(saved.toJson())) as Map<String, dynamic>,
        now: testNow.subtract(const Duration(minutes: 20)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("You're offline"), findsOneWidget);
    expect(find.text('Updated 20 min ago'), findsOneWidget);
    expect(find.text('Live'), findsNothing);
    expect(find.text('Ana Reyes'), findsOneWidget);

    // The desk can read the day, but not change it.
    await tester.tap(find.text('Ana Reyes'));
    await tester.pumpAndSettle();
    expect(find.textContaining('need a connection'), findsOneWidget);
    expect(tester.widget<ListTile>(find.widgetWithText(ListTile, 'Check in')).enabled, isFalse);
  });

  testWidgets('no venue selected asks for one rather than erroring', (tester) async {
    final world = TestWorld();
    await pumpApp(
      tester,
      const TodayScreen(),
      world: world,
      extraOverrides: [selectedVenueProvider.overrideWithValue(null)],
    );
    await tester.pumpAndSettle();

    expect(find.text('No venue selected'), findsOneWidget);
  });
}
