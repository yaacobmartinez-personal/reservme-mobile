import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/time/app_time.dart';

import '../helpers/fakes.dart';

void main() {
  test('the fake world is coherent', () {
    final world = TestWorld();
    final store = world.store;

    final owner = store.userByEmail(FakeAccounts.ownerEmail)!;
    expect(store.membershipsOf(owner.id).length, 3);

    final k = store.venueBySlug(FakeVenues.katipunan)!;
    expect(store.spacesOf(k.id, activeOnly: true).length, 4);
    expect(store.spacesOf(k.id).length, 5);

    // No two live rentals overlap on one space — the exclusion constraint.
    for (final s in store.spacesOf(k.id)) {
      final live = store.reservations
          .where((r) => r.spaceId == s.id && r.status.isLive && r.kind != ReservationKind.sessionSeat)
          .toList();
      for (var i = 0; i < live.length; i++) {
        for (var j = i + 1; j < live.length; j++) {
          final a = live[i], b = live[j];
          final overlap = a.startsAt.isBefore(b.endsAt) && b.startsAt.isBefore(a.endsAt);
          expect(overlap, isFalse, reason: '${a.id} overlaps ${b.id} on ${s.name}');
        }
      }
    }

    // Today's run sheet exists in venue-local terms.
    final today = AppTime.today(world.now, k.timezone);
    final runSheet = store.reservationsOf(k.id).where(
        (r) => r.status.isLive && r.kind != ReservationKind.sessionBlock && AppTime.localDate(r.startsAt, k.timezone) == today);
    expect(runSheet.length, greaterThanOrEqualTo(8));
    expect(runSheet.where((r) => r.checkedInAt != null).length, greaterThanOrEqualTo(3));

    // Open play lands on Tuesdays and Thursdays, on Court 4.
    for (final s in store.sessionsOf(k.id)) {
      final wd = AppTime.weekday(AppTime.localDate(s.startsAt, k.timezone), k.timezone);
      expect(wd == 2 || wd == 4, isTrue);
      expect(store.spaceById(s.spaceId)!.name, 'Court 4');
    }

    // The Madrid venue renders in its own zone.
    final n = store.venueBySlug(FakeVenues.studioNorte)!;
    expect(n.timezone, 'Europe/Madrid');
    expect(store.reservationsOf(n.id).length, 3);

    expect(store.venueBySlug('marikina-futsal')!.suspended, isTrue);
  });
}
