import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/core/time/app_time.dart';
import 'package:reservme/features/customer/booking/data/booking_mapper.dart';
import 'package:reservme/features/customer/booking/domain/booking.dart';
import 'package:reservme/features/customer/booking/domain/booking_repository.dart';
import 'package:reservme/features/customer/customer_providers.dart';
import 'package:reservme/features/customer/venues/domain/public_venue.dart';
import 'package:reservme/features/customer/wallet/domain/manage_repository.dart';

import '../helpers/fakes.dart';

void main() {
  const zone = 'Asia/Manila';

  group('cancelEligibility — the web policy, word for word', () {
    final now = DateTime.utc(2026, 9, 26, 2); // 10:00 Manila
    final future = now.add(const Duration(days: 2));
    final soon = now.add(const Duration(hours: 3));

    Cancellation check({
      ReservationStatus status = ReservationStatus.confirmed,
      required DateTime startsAt,
      CancellationMode mode = CancellationMode.anytime,
      int graceHours = 24,
    }) =>
        cancelEligibility(
          status: status,
          startsAt: startsAt,
          mode: mode,
          graceHours: graceHours,
          now: now,
        );

    test('anytime allows a future booking', () {
      expect(check(startsAt: future).canCancel, isTrue);
      expect(check(startsAt: soon).canCancel, isTrue);
    });

    test('a past booking can never be cancelled', () {
      final result = check(startsAt: now.subtract(const Duration(hours: 1)));
      expect(result.canCancel, isFalse);
      expect(result.reason, 'This booking has already passed.');
    });

    test('never refuses with the venue wording', () {
      final result = check(startsAt: future, mode: CancellationMode.never);
      expect(result.canCancel, isFalse);
      expect(result.reason, contains("doesn't allow online cancellation"));
    });

    test('grace allows outside the window and refuses inside it', () {
      expect(
        check(startsAt: future, mode: CancellationMode.grace).canCancel,
        isTrue,
      );
      final inside = check(startsAt: soon, mode: CancellationMode.grace);
      expect(inside.canCancel, isFalse);
      expect(inside.reason, contains('within 24 hours'));
    });

    test('an already-cancelled or no-show booking is closed', () {
      expect(
        check(startsAt: future, status: ReservationStatus.cancelled).reason,
        'This booking has already been cancelled.',
      );
      expect(
        check(startsAt: future, status: ReservationStatus.noShow).reason,
        'This booking was marked as a no-show.',
      );
    });
  });

  group('managing a booking by token', () {
    late TestWorld world;
    late BookingRepository bookings;
    late ManageRepository manage;
    late PublicVenue venue;
    late Booking booking;

    setUp(() async {
      world = TestWorld();
      final container = world.container();
      bookings = container.read(bookingRepositoryProvider);
      manage = container.read(manageRepositoryProvider);
      venue = await container.read(venuesRepositoryProvider).bySlug(FakeVenues.katipunan);

      final court = venue.spaces.firstWhere((s) => s.name == 'Court 2');
      final date = AppTime.addDays(AppTime.today(world.now, zone), 2, zone);
      final day = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: court.id,
        date: date,
      );
      final slot = day.openSlots.first;
      final outcome = await bookings.book(
        venueSlug: venue.slug,
        input: BookingInput(
          spaceId: court.id,
          startsAt: slot.startsAt,
          endsAt: slot.endsAt,
          name: 'Maria Santos',
          email: 'maria@example.com',
        ),
      );
      booking = (outcome as Booked).booking;
    });

    test('reads back by token', () async {
      final fetched = await manage.byToken(
        venueSlug: venue.slug,
        token: booking.manageToken!,
      );
      expect(fetched.reference, booking.reference);
      expect(fetched.cancellation.canCancel, isTrue);
    });

    test('an unknown token is a 404 with the customer wording', () async {
      await expectLater(
        manage.byToken(venueSlug: venue.slug, token: 'nope'),
        throwsA(
          isA<ApiError>()
              .having((e) => e.status, 'status', 404)
              .having((e) => e.message, 'message', 'This link is no longer valid.'),
        ),
      );
    });

    test('cancelling frees the slot', () async {
      final before = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: booking.space.id,
        date: AppTime.localDate(booking.startsAt, zone),
      );
      expect(
        before.slots.firstWhere((s) => s.startsAt == booking.startsAt).reason,
        SlotReason.taken,
      );

      final outcome =
          await manage.cancel(venueSlug: venue.slug, token: booking.manageToken!);
      expect(outcome, isA<Cancelled>());
      expect((outcome as Cancelled).booking.status, ReservationStatus.cancelled);

      final after = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: booking.space.id,
        date: AppTime.localDate(booking.startsAt, zone),
      );
      expect(
        after.slots.firstWhere((s) => s.startsAt == booking.startsAt).available,
        isTrue,
      );
    });

    test('cancelling twice is refused the second time', () async {
      await manage.cancel(venueSlug: venue.slug, token: booking.manageToken!);
      final again =
          await manage.cancel(venueSlug: venue.slug, token: booking.manageToken!);
      expect(again, isA<CancelRefused>());
    });

    test('reschedule options never offer the current slot', () async {
      final days = await manage.rescheduleOptions(
        venueSlug: venue.slug,
        token: booking.manageToken!,
      );
      expect(days, isNotEmpty);
      final all = days.expand((d) => d.slots);
      expect(all.any((s) => s.startsAt == booking.startsAt), isFalse);
      expect(all.every((s) => s.available), isTrue);
    });

    test('moving frees the old slot and takes the new one', () async {
      final days = await manage.rescheduleOptions(
        venueSlug: venue.slug,
        token: booking.manageToken!,
      );
      final target = days.first.slots.first;
      final oldStart = booking.startsAt;

      final outcome = await manage.reschedule(
        venueSlug: venue.slug,
        token: booking.manageToken!,
        startsAt: target.startsAt,
        endsAt: target.endsAt,
      );
      expect(outcome, isA<Rescheduled>());
      expect((outcome as Rescheduled).booking.startsAt, target.startsAt);

      final oldDay = await bookings.availability(
        venueSlug: venue.slug,
        spaceId: booking.space.id,
        date: AppTime.localDate(oldStart, zone),
      );
      expect(oldDay.slots.firstWhere((s) => s.startsAt == oldStart).available, isTrue);
    });

    test('moving onto a slot someone took loses', () async {
      final court = venue.spaces.firstWhere((s) => s.name == 'Court 2');
      final days = await manage.rescheduleOptions(
        venueSlug: venue.slug,
        token: booking.manageToken!,
      );
      final target = days.first.slots.first;

      // Someone else books it first.
      await bookings.book(
        venueSlug: venue.slug,
        input: BookingInput(
          spaceId: court.id,
          startsAt: target.startsAt,
          endsAt: target.endsAt,
          name: 'Someone Else',
          email: 'else@example.com',
        ),
      );

      final outcome = await manage.reschedule(
        venueSlug: venue.slug,
        token: booking.manageToken!,
        startsAt: target.startsAt,
        endsAt: target.endsAt,
      );
      expect(outcome, isA<RescheduleSlotTaken>());
    });
  });
}
