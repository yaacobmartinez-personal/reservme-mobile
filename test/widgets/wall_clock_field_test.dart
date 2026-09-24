import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/widgets/wall_clock_field.dart';

import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

void main() {
  testWidgets('a date shows as the venue reads it, not as ISO', (tester) async {
    final world = TestWorld();
    await pumpApp(
      tester,
      Scaffold(
        body: DateField(
          label: 'Date',
          value: '2026-09-26',
          timezone: 'Asia/Manila',
          onChanged: (_) {},
        ),
      ),
      world: world,
    );
    await tester.pumpAndSettle();

    expect(find.text('Date'), findsOneWidget);
    expect(find.text('Sat 26 Sep'), findsOneWidget);
    // The raw wall-clock string is the value, never the label.
    expect(find.text('2026-09-26'), findsNothing);
  });

  testWidgets('picking a date hands back a wall-clock string', (tester) async {
    final world = TestWorld();
    String? picked;
    await pumpApp(
      tester,
      Scaffold(
        body: DateField(
          label: 'Date',
          value: '2026-09-26',
          timezone: 'Asia/Manila',
          onChanged: (v) => picked = v,
        ),
      ),
      world: world,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sat 26 Sep'));
    await tester.pumpAndSettle();
    // The picker opens on the current value.
    expect(find.byType(DatePickerDialog), findsOneWidget);
    await tester.tap(find.text('28'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(picked, '2026-09-28');
  });

  testWidgets('a time field shows its wall clock and opens a picker',
      (tester) async {
    final world = TestWorld();
    await pumpApp(
      tester,
      Scaffold(
        body: TimeField(label: 'From', value: '18:00', onChanged: (_) {}),
      ),
      world: world,
    );
    await tester.pumpAndSettle();

    expect(find.text('18:00'), findsOneWidget);
    await tester.tap(find.text('18:00'));
    await tester.pumpAndSettle();
    expect(find.byType(TimePickerDialog), findsOneWidget);
  });

  testWidgets('a malformed value still renders rather than throwing',
      (tester) async {
    final world = TestWorld();
    await pumpApp(
      tester,
      Scaffold(
        body: DateField(
          label: 'Date',
          value: 'not-a-date',
          timezone: 'Asia/Manila',
          onChanged: (_) {},
        ),
      ),
      world: world,
    );
    await tester.pumpAndSettle();

    expect(find.text('not-a-date'), findsOneWidget);
  });
}
