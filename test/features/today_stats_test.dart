import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/time/app_time.dart';
import 'package:reservme/features/venue/today/application/today_controller.dart';

import '../helpers/fakes.dart';

/// The run sheet and the stats disagree on purpose, and the web is the
/// arbiter: `getRunSheet` shows rentals and session seats (the app rolls the
/// seats into one line per session, which is what the V4 board draws), while
/// `getVenueStats` counts `kind IN ('rental','session_seat')` — so a session
/// *block* is in neither, and a *seat* is counted individually.
void main() {
  const slug = FakeVenues.katipunan;
  const zone = 'Asia/Manila';

  // Open play runs Tue and Thu, so the session cases need one of those days:
  // Thursday 24 September 2026, 10:00 in Manila.
  final onSessionDay = DateTime.utc(2026, 9, 24, 2);

  test('a block is on the calendar but never on the run sheet', () async {
    final world = TestWorld();
    final container = world.container();
    final venue = world.store.venueBySlug(slug)!;

    // The seed blocks Court 3 for a net repair today - as a closure.
    expect(
      world.store.closuresOf(venue.id).where(
            (c) => AppTime.localDate(c.startsAt, zone) == AppTime.today(testNow, zone),
          ),
      isNotEmpty,
    );

    final view = (await container.read(todayProvider(slug).future)).view;
    expect(view.runSheet.where((r) => r.customerName == 'Blocked'), isEmpty);
  });

  test('the stats count seats, not the session block that holds the space',
      () async {
    final world = TestWorld(now: onSessionDay);
    final container = world.container();
    final venue = world.store.venueBySlug(slug)!;
    final date = AppTime.today(onSessionDay, zone);

    final counted = world.store.reservationsOf(venue.id).where((r) =>
        r.status.isLive &&
        r.kind != ReservationKind.sessionBlock &&
        AppTime.localDate(r.startsAt, zone) == date);

    final view = (await container.read(todayProvider(slug).future)).view;

    expect(view.stats.todayCount, counted.length);
    expect(
      view.stats.todayRevenueCents,
      counted
          .where((r) => r.status == ReservationStatus.confirmed)
          .fold(0, (sum, r) => sum + r.amountCents),
    );
    // A session block carries no money and no customer, so counting it would
    // both inflate the count and understate nothing - a silent wrong number.
    expect(
      view.stats.todayCount,
      isNot(world.store
          .reservationsOf(venue.id)
          .where((r) =>
              r.status.isLive && AppTime.localDate(r.startsAt, zone) == date)
          .length),
      reason: 'the session block must be excluded',
    );
  });

  test('the run sheet still shows open play as one line', () async {
    final world = TestWorld(now: onSessionDay);
    final container = world.container();

    final view = (await container.read(todayProvider(slug).future)).view;
    final sessions = view.runSheet.where((r) => r.isSession);

    expect(sessions, isNotEmpty);
    expect(sessions.first.sessionCapacity, isNotNull);
    expect(sessions.first.sessionBooked, isNotNull);
  });
}
