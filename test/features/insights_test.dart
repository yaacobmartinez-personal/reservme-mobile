import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/fake_store.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/features/auth/application/auth_controller.dart';
import 'package:reservme/features/venue/insights/application/insights_controller.dart';
import 'package:reservme/features/venue/insights/domain/insights.dart';

import '../helpers/fakes.dart';

void main() {
  const slug = FakeVenues.katipunan;

  Future<void> signIn(ProviderContainer container, String email) => container
      .read(authControllerProvider.notifier)
      .signIn(email: email, password: FakeAccounts.password);

  Future<Insights> load(
    ProviderContainer container, [
    InsightsRange range = InsightsRange.month,
  ]) =>
      container.read(insightsProvider(slug, range).future);

  group('ranges', () {
    test('an unknown period falls back to 30 days rather than throwing', () {
      expect(InsightsRange.fromWire('7d'), InsightsRange.week);
      expect(InsightsRange.fromWire('90d'), InsightsRange.quarter);
      expect(InsightsRange.fromWire('all-time'), InsightsRange.month);
      expect(InsightsRange.fromWire(null), InsightsRange.month);
    });
  });

  group('deltas', () {
    test('a jump from nothing has no percentage, because it has no baseline',
        () {
      expect(Kpi.delta(10, 0), isNull);
      expect(Kpi.delta(0, 0), isNull);
    });

    test('a delta is a percentage to one decimal place', () {
      expect(Kpi.delta(150, 100), 50.0);
      expect(Kpi.delta(50, 100), -50.0);
      expect(Kpi.delta(1, 3), -66.7);
    });

    test('no change is neither good news nor bad', () {
      // Found on a device against a real venue whose takings were identical
      // to the month before: the card painted 0.0% red, which tells an owner
      // their takings fell when they did not move.
      const flat = Kpi(value: 900, previous: 900, deltaPct: 0);
      expect(flat.isGood(), isNull);
      expect(flat.isGood(lowerIsBetter: true), isNull);

      // And with no baseline at all there is nothing to judge either.
      const first = Kpi(value: 900, previous: 0);
      expect(first.isGood(), isNull);
    });

    test('up is good, unless lower is better', () {
      const up = Kpi(value: 150, previous: 100, deltaPct: 50);
      const down = Kpi(value: 50, previous: 100, deltaPct: -50);

      expect(up.isGood(), isTrue);
      expect(down.isGood(), isFalse);
      // No-shows: fewer is the win.
      expect(up.isGood(lowerIsBetter: true), isFalse);
      expect(down.isGood(lowerIsBetter: true), isTrue);
    });
  });

  group('the dashboard', () {
    test('every window has one point per day and a previous window to match',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      for (final range in InsightsRange.values) {
        final data = await load(container, range);
        expect(data.bookedByDay, hasLength(range.days), reason: range.label);
        expect(data.bookings.series, hasLength(range.days), reason: range.label);
        expect(data.range, range);
      }
    });

    test('bookings and value come from what customers book', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final data = await load(container);

      expect(data.bookings.value, greaterThan(0));
      expect(data.bookedValueCents.value, greaterThan(0));
      // The daily series adds up to the headline, or one of them is lying.
      expect(
        data.bookings.series.fold<num>(0, (t, n) => t + n),
        data.bookings.value,
      );
      expect(
        data.bookedValueCents.series.fold<num>(0, (t, n) => t + n),
        data.bookedValueCents.value,
      );
    });

    test('utilisation is a percentage and never exceeds a hundred', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final data = await load(container);

      expect(data.utilisationPct.value, greaterThanOrEqualTo(0));
      expect(data.utilisationPct.value, lessThanOrEqualTo(100));
      for (final point in data.bookedByDay) {
        expect(point.utilisationPct, lessThanOrEqualTo(100));
      }
    });

    test('a seat is booked but does not occupy the court', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      final before = await load(container);

      // A session seat is what a customer books; the session block is what
      // holds the court. Counting seats as occupancy would push a full court
      // past a hundred per cent.
      final venue = world.store.venueBySlug(slug)!;
      final session = world.store.sessionsOf(venue.id).first;
      world.store.reservations.add(FakeReservation(
        id: world.store.nextId('r'),
        venueId: venue.id,
        spaceId: session.spaceId,
        sessionId: session.id,
        kind: ReservationKind.sessionSeat,
        status: ReservationStatus.confirmed,
        startsAt: session.startsAt,
        endsAt: session.endsAt,
        partySize: 1,
        amountCents: 20000,
        reference: 'SEAT-1',
        manageToken: 'tok-seat-1',
        createdAt: DateTime.now().toUtc(),
      ));
      container.invalidate(insightsProvider(slug, InsightsRange.month));
      final after = await load(container);

      expect(after.bookings.value, before.bookings.value + 1);
      expect(after.bookedValueCents.value, before.bookedValueCents.value + 20000);
      // Utilisation is untouched: the seat sold a spot, not an hour.
      expect(after.utilisationPct.value, before.utilisationPct.value);
    });

    test('the heatmap is seven days by twenty-four hours, venue-local',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final data = await load(container);

      expect(data.peakHours, hasLength(7));
      for (final row in data.peakHours) {
        expect(row, hasLength(24));
      }
      expect(data.peakMax, greaterThan(0));
    });

    test('value by space is biggest first and keeps the empty ones', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final data = await load(container);
      final spaceCount = world.store
          .spacesOf(world.store.venueBySlug(slug)!.id)
          .length;

      expect(data.bySpace, hasLength(spaceCount));
      for (var i = 1; i < data.bySpace.length; i++) {
        expect(
          data.bySpace[i - 1].cents,
          greaterThanOrEqualTo(data.bySpace[i].cents),
        );
      }
    });

    test('the mix counts every ending, and no-show rate follows from it',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final data = await load(container);

      expect(data.mix.confirmed, data.bookings.value);
      expect(data.mix.total, greaterThan(0));
      if (data.mix.confirmed + data.mix.noShow > 0) {
        final expected = (data.mix.noShow /
                (data.mix.confirmed + data.mix.noShow) *
                1000)
            .round() /
            10;
        expect(data.noShowRatePct.value, closeTo(expected, 0.05));
      }
    });

    test('a venue with nothing in the window says so rather than drawing zeroes',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);
      world.store.reservations.clear();
      container.invalidate(insightsProvider(slug, InsightsRange.month));

      final data = await load(container);

      expect(data.isEmpty, isTrue);
      expect(data.bookings.value, 0);
      expect(data.peakMax, 0);
    });

    test('needs-you flags today\'s uncheck-ins and half-empty sessions',
        () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.ownerEmail);

      final data = await load(container);

      expect(data.needsYou.toCheckIn, greaterThanOrEqualTo(0));
      for (final session in data.needsYou.halfEmptySessions) {
        // Less than half sold is the whole point of the list.
        expect(session.spotsLeft * 2, greaterThan(session.capacity));
      }
    });

    test('front desk can see insights — they run the day', () async {
      final world = TestWorld();
      final container = world.container();
      await signIn(container, FakeAccounts.staffEmail);

      final data = await load(container);
      expect(data.bookings.value, greaterThanOrEqualTo(0));
    });
  });
}
