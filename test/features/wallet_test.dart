import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/connectivity/connectivity_provider.dart';
import 'package:reservme/core/fake/seed.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/core/storage/local_store.dart';
import 'package:reservme/core/time/app_time.dart';
import 'package:reservme/features/customer/booking/domain/booking.dart';
import 'package:reservme/features/customer/customer_providers.dart';
import 'package:reservme/features/customer/wallet/application/wallet_controller.dart';

import '../helpers/fakes.dart';

/// How the wallet behaves when the phone and the venue disagree: offline, and
/// a booking the venue no longer recognises.
void main() {
  const zone = 'Asia/Manila';

  test('a saved booking is shown when the venue cannot be reached', () async {
    final world = TestWorld();
    final container = world.container();
    final venue =
        await container.read(venuesRepositoryProvider).bySlug(FakeVenues.katipunan);
    final court = venue.spaces.first;
    final date = AppTime.addDays(AppTime.today(world.now, zone), 2, zone);
    final day = await container.read(bookingRepositoryProvider).availability(
          venueSlug: venue.slug,
          spaceId: court.id,
          date: date,
        );
    final slot = day.openSlots.first;
    final outcome = await container.read(bookingRepositoryProvider).book(
          venueSlug: venue.slug,
          input: BookingInput(
            spaceId: court.id,
            startsAt: slot.startsAt,
            endsAt: slot.endsAt,
            name: 'Maria Santos',
            email: 'maria@example.com',
          ),
        );
    final booking = (outcome as Booked).booking;
    await container.read(localStoreProvider).saveBooking(booking, now: world.now);

    // Online: the fresh copy comes back.
    final fresh = await container
        .read(bookingDetailProvider(venue.slug, booking.manageToken!).future);
    expect(fresh.stale, isFalse);
    expect(fresh.missing, isFalse);

    // Offline: the saved copy, flagged stale but not missing. `isOnline` is
    // optimistic until the connectivity stream delivers, so it is pinned here
    // rather than raced. The world's local store is shared, so the booking
    // saved above is still on the "phone".
    final offlineContainer = ProviderContainer(
      overrides: [...world.overrides, isOnlineProvider.overrideWithValue(false)],
    );
    addTearDown(offlineContainer.dispose);
    final offline = await offlineContainer
        .read(bookingDetailProvider(venue.slug, booking.manageToken!).future);
    expect(offline.stale, isTrue);
    expect(offline.missing, isFalse);
    expect(offline.booking.reference, booking.reference);
  });

  test('a token the venue does not know is shown as missing, not hidden', () async {
    final world = TestWorld();
    final container = world.container();

    // A booking saved on the phone whose token the venue has never heard of —
    // cancelled elsewhere, erased, or the link rotated.
    const token = 'deadbeefdeadbeefdeadbeefdeadbeef';
    final orphan = Booking(
      reference: 'KTP-7H4M',
      venue: const BookingVenue(slug: FakeVenues.katipunan, name: 'Katipunan Courts'),
      space: const BookingSpace(id: 'sp_1', name: 'Court 1'),
      startsAt: world.now.add(const Duration(days: 1)),
      endsAt: world.now.add(const Duration(days: 1, hours: 1)),
      whenLabel: 'tomorrow',
      manageToken: token,
    );
    await container.read(localStoreProvider).saveBooking(orphan, now: world.now);

    final view =
        await container.read(bookingDetailProvider(FakeVenues.katipunan, token).future);
    expect(view.missing, isTrue);
    expect(view.stale, isTrue);
    expect(view.booking.reference, 'KTP-7H4M');
  });

  test('an unknown token with nothing saved is still an error', () async {
    final world = TestWorld();
    final container = world.container();
    await expectLater(
      container.read(bookingDetailProvider(FakeVenues.katipunan, 'nope').future),
      throwsA(isA<ApiError>().having((e) => e.isNotFound, 'isNotFound', isTrue)),
    );
  });
}
