import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/connectivity/connectivity_provider.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/core/time/app_time.dart';
import 'package:reservme/features/customer/booking/domain/booking.dart';
import 'package:reservme/features/customer/booking/domain/booking_repository.dart';
import 'package:reservme/features/customer/customer_providers.dart';
import 'package:reservme/features/customer/venues/domain/public_venue.dart';

import '../helpers/fakes.dart';

void main() {
  late TestWorld world;
  late BookingRepository bookings;
  late PublicVenue venue;
  const zone = 'Asia/Manila';

  setUp(() async {
    world = TestWorld();
    final container = world.container();
    bookings = container.read(bookingRepositoryProvider);
    venue = await container.read(venuesRepositoryProvider).bySlug(FakeVenues.katipunan);
  });

  /// A date far enough out that notice and horizon both pass.
  String tomorrow() => AppTime.addDays(AppTime.today(world.now, zone), 1, zone);

  VenueSpace spaceNamed(String name) =>
      venue.spaces.firstWhere((s) => s.name == name);

  BookingInput inputAt(VenueSpace space, DateTime start, {String? email}) => BookingInput(
        spaceId: space.id,
        startsAt: start,
        endsAt: start.add(Duration(minutes: space.slotMinutes)),
        name: 'Maria Santos',
        email: email ?? 'maria@example.com',
        phone: '0917 555 0142',
      );

  group('the venue page', () {
    test('shows only active spaces, with peak pricing and open counts', () {
      expect(venue.spaces.length, 4);
      expect(venue.spaces.any((s) => s.name.contains('annex')), isFalse);
      final court1 = spaceNamed('Court 1');
      expect(court1.priceCents, 35000);
      expect(court1.peakPriceCents, 45000);
      expect(court1.openToday, isNotNull);
    });

    test('an unknown slug is a 404', () async {
      await expectLater(
        world.container().read(venuesRepositoryProvider).bySlug('nope'),
        throwsA(isA<ApiError>().having((e) => e.status, 'status', 404)),
      );
    });

    test('a suspended venue still resolves but offers nothing', () async {
      final suspended =
          await world.container().read(venuesRepositoryProvider).bySlug('marikina-futsal');
      expect(suspended.suspended, isTrue);
      expect(suspended.spaces.every((s) => s.openToday == 0), isTrue);
    });
  });

  group('availability', () {
    test('is generated in venue-local time and marks taken slots', () async {
      final court1 = spaceNamed('Court 1');
      final day = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: court1.id,
        date: tomorrow(),
      );
      expect(day.date, tomorrow());
      expect(day.slots, isNotEmpty);
      // Courts open 09:00 on weekdays and 08:00 at the weekend; either way the
      // first slot is the venue's opening hour, not a UTC one.
      final weekend = AppTime.weekday(tomorrow(), zone) == 0 ||
          AppTime.weekday(tomorrow(), zone) == 6;
      expect(day.slots.first.label, weekend ? '08:00' : '09:00');
      expect(
        day.slots.every((s) => AppTime.localDate(s.startsAt, zone) == tomorrow()),
        isTrue,
      );
      // The seed books some slots; those read as taken, not open.
      final taken = day.slots.where((s) => s.reason == SlotReason.taken);
      expect(taken.every((s) => !s.available), isTrue);
    });

    test('peak pricing follows the venue rules', () async {
      final court1 = spaceNamed('Court 1');
      final day = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: court1.id,
        date: tomorrow(),
      );
      final morning = day.slots.firstWhere((s) => s.label == '10:00');
      final evening = day.slots.firstWhere((s) => s.label == '18:00');
      final weekday = AppTime.weekday(tomorrow(), zone);
      if (weekday == 0 || weekday == 6) {
        expect(morning.peak, isTrue); // weekend rule covers the whole day
      } else {
        expect(morning.peak, isFalse);
        expect(evening.peak, isTrue);
        expect(evening.priceCents, 45000);
      }
    });

    test('slots inside the notice window read as too soon', () async {
      final court1 = spaceNamed('Court 1');
      final today = AppTime.today(world.now, zone);
      final day = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: court1.id,
        date: today,
      );
      // "now" is 10:00 Manila with a 60-minute notice, so 09:00 is past.
      final early = day.slots.firstWhere((s) => s.label == '09:00');
      expect(early.reason, SlotReason.tooSoon);
      expect(early.available, isFalse);
    });

    test('open play appears as a session on its day', () async {
      final court4 = spaceNamed('Court 4');
      var found = false;
      for (var i = 0; i < 7 && !found; i++) {
        final date = AppTime.addDays(AppTime.today(world.now, zone), i, zone);
        final day = await bookings.availability(
          venueSlug: venue.slug,
          spaceId: court4.id,
          date: date,
        );
        if (day.sessions.isNotEmpty) {
          found = true;
          final session = day.sessions.first;
          expect(session.title, 'Open play');
          expect(session.capacity, 12);
          expect(session.spotsLeft, greaterThan(0));
        }
      }
      expect(found, isTrue, reason: 'open play should fall within the next week');
    });
  });

  group('booking', () {
    test('books an open slot and returns a manage token', () async {
      final court1 = spaceNamed('Court 1');
      final day = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: court1.id,
        date: tomorrow(),
      );
      final slot = day.openSlots.first;

      final outcome = await bookings.book(
        venueSlug: venue.slug,
        input: inputAt(court1, slot.startsAt),
      );
      expect(outcome, isA<Booked>());
      final booking = (outcome as Booked).booking;
      expect(booking.manageToken, isNotNull);
      expect(booking.reference, matches(RegExp(r'^[A-Z2-9]{3}-[A-Z2-9]{4}$')));
      expect(booking.amountCents, slot.priceCents);
      expect(booking.status, ReservationStatus.confirmed);

      // The slot is gone from availability afterwards.
      final after = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: court1.id,
        date: tomorrow(),
      );
      final same = after.slots.firstWhere((s) => s.startsAt == slot.startsAt);
      expect(same.reason, SlotReason.taken);
    });

    test('the second booking of the same slot loses', () async {
      final court1 = spaceNamed('Court 1');
      final day = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: court1.id,
        date: tomorrow(),
      );
      final slot = day.openSlots.first;

      final first = await bookings.book(
        venueSlug: venue.slug,
        input: inputAt(court1, slot.startsAt),
      );
      final second = await bookings.book(
        venueSlug: venue.slug,
        input: inputAt(court1, slot.startsAt, email: 'other@example.com'),
      );
      expect(first, isA<Booked>());
      expect(second, isA<SlotTaken>());
    });

    test('a suspended venue refuses', () async {
      final suspended =
          await world.container().read(venuesRepositoryProvider).bySlug('marikina-futsal');
      final outcome = await bookings.book(
        venueSlug: suspended.slug,
        input: inputAt(
          suspended.spaces.first,
          AppTime.fromLocal(tomorrow(), '10:00', zone)!,
        ),
      );
      expect(outcome, isA<VenueClosed>());
    });

    test('validation errors come back per field', () async {
      final court1 = spaceNamed('Court 1');
      final outcome = await bookings.book(
        venueSlug: venue.slug,
        input: BookingInput(
          spaceId: court1.id,
          startsAt: AppTime.fromLocal(tomorrow(), '10:00', zone)!,
          endsAt: AppTime.fromLocal(tomorrow(), '11:00', zone)!,
          name: '',
          email: 'not-an-email',
        ),
      );
      expect(outcome, isA<BookingInvalid>());
      final invalid = outcome as BookingInvalid;
      expect(invalid.fieldErrors.keys, containsAll(['name', 'email']));
    });

    test('a flood of attempts is rate limited', () async {
      final court1 = spaceNamed('Court 1');
      final day = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: court1.id,
        date: tomorrow(),
      );
      final slots = day.openSlots.toList();
      var limited = false;
      for (var i = 0; i < 9 && i < slots.length; i++) {
        final outcome = await bookings.book(
          venueSlug: venue.slug,
          input: inputAt(court1, slots[i].startsAt, email: 'flood$i@example.com'),
        );
        if (outcome is RateLimited) limited = true;
      }
      expect(limited, isTrue);
    });

    test('a session seat claims a spot, and a full session refuses', () async {
      final court4 = spaceNamed('Court 4');
      var sessionId = '';
      var spotsLeft = 0;
      for (var i = 0; i < 7 && sessionId.isEmpty; i++) {
        final date = AppTime.addDays(AppTime.today(world.now, zone), i, zone);
        final day = await bookings.availability(
          venueSlug: venue.slug,
          spaceId: court4.id,
          date: date,
        );
        if (day.sessions.isNotEmpty) {
          sessionId = day.sessions.first.id;
          spotsLeft = day.sessions.first.spotsLeft;
        }
      }

      final ok = await bookings.bookSession(
        venueSlug: venue.slug,
        sessionId: sessionId,
        spots: 1,
        name: 'Maria Santos',
        email: 'maria@example.com',
      );
      expect(ok, isA<Booked>());
      expect((ok as Booked).booking.kind, ReservationKind.sessionSeat);

      final tooMany = await bookings.bookSession(
        venueSlug: venue.slug,
        sessionId: sessionId,
        spots: spotsLeft + 5,
        name: 'Crowd',
        email: 'crowd@example.com',
      );
      expect(tooMany, isA<SessionFull>());
    });

    test('offline surfaces as a transport error, not an outcome', () async {
      // `isOnline` is optimistic until the connectivity stream delivers, so
      // the test pins it rather than racing the stream.
      final offline = TestWorld(online: false);
      final container = ProviderContainer(
        overrides: [...offline.overrides, isOnlineProvider.overrideWithValue(false)],
      );
      addTearDown(container.dispose);
      final repo = container.read(bookingRepositoryProvider);
      await expectLater(
        repo.availability(
          venueSlug: FakeVenues.katipunan,
          spaceId: 'sp_1',
          date: tomorrow(),
        ),
        throwsA(isA<ApiError>().having((e) => e.isNetwork, 'isNetwork', isTrue)),
      );
    });
  });
}
