import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/network/api_error.dart';
import 'package:reservme/features/customer/booking/application/book_controller.dart';
import 'package:reservme/features/customer/booking/domain/availability.dart';
import 'package:reservme/features/customer/booking/domain/booking.dart';
import 'package:reservme/features/customer/booking/domain/booking_repository.dart';
import 'package:reservme/features/customer/customer_providers.dart';

import '../helpers/fakes.dart';

/// The one thing an idempotency key has to do: be the **same** across retries
/// of one attempt.
///
/// The client used to mint a fresh uuid inside every request, which meant a
/// retried booking carried a new key and the server would happily book twice —
/// the exact failure the header exists to prevent. These tests watch the keys
/// rather than their presence, because a key that is merely *there* proves
/// nothing.
class _RecordingRepository implements BookingRepository {
  _RecordingRepository({this.failFirst = 0});

  /// How many attempts blow up with a transport error before one succeeds.
  int failFirst;
  final keys = <String?>[];

  @override
  Future<BookOutcome> book({
    required String venueSlug,
    required BookingInput input,
    String? idempotencyKey,
  }) async {
    keys.add(idempotencyKey);
    if (failFirst > 0) {
      failFirst -= 1;
      throw ApiError.network();
    }
    return Booked(_booking);
  }

  @override
  Future<BookOutcome> bookSession({
    required String venueSlug,
    required String sessionId,
    required int spots,
    required String name,
    required String email,
    String? phone,
    String? idempotencyKey,
  }) async {
    keys.add(idempotencyKey);
    if (failFirst > 0) {
      failFirst -= 1;
      throw ApiError.network();
    }
    return Booked(_booking);
  }

  @override
  Future<DayAvailability> availability({
    required String venueSlug,
    required String spaceId,
    required String date,
  }) async =>
      const DayAvailability(date: '2026-10-01');

  @override
  Future<void> joinWaitlist({
    required String venueSlug,
    required String spaceId,
    required DateTime startsAt,
    required DateTime endsAt,
    required String name,
    required String email,
    String? phone,
  }) async {}
}

final _booking = Booking(
  reference: 'ABC-1234',
  venue: const BookingVenue(slug: 'katipunan', name: 'Katipunan Courts'),
  space: const BookingSpace(id: 's1', name: 'Court 1'),
  startsAt: DateTime.utc(2026, 10, 1, 10),
  endsAt: DateTime.utc(2026, 10, 1, 11),
  whenLabel: 'Thu 01 Oct · 18:00–19:00',
  manageToken: 'tok-1',
);

final _input = BookingInput(
  spaceId: 's1',
  startsAt: DateTime.utc(2026, 10, 1, 10),
  endsAt: DateTime.utc(2026, 10, 1, 11),
  name: 'Rafael',
  email: 'rafael@example.com',
);

void main() {
  ProviderContainer containerWith(TestWorld world, BookingRepository repo) {
    final c = ProviderContainer(
      overrides: [
        ...world.overrides,
        bookingRepositoryProvider.overrideWithValue(repo),
      ],
    );
    addTearDown(c.dispose);
    return c;
  }

  test('a retry after a dropped connection carries the same key', () async {
    // The ambiguous case: the booking may or may not have been written. The
    // whole point of the key is that the server can tell us which.
    final world = TestWorld();
    final repo = _RecordingRepository(failFirst: 1);
    final container = containerWith(world, repo);
    final notifier = container.read(bookControllerProvider.notifier);

    await expectLater(
      notifier.book(venueSlug: 'katipunan', input: _input),
      throwsA(isA<ApiError>()),
    );
    await notifier.book(venueSlug: 'katipunan', input: _input);

    expect(repo.keys, hasLength(2));
    expect(repo.keys.first, isNotNull);
    expect(repo.keys[1], repo.keys.first, reason: 'the retry reuses the key');
  });

  test('a genuinely new booking gets a new key', () async {
    // Once the server has answered, the next tap is a second booking, not a
    // retry — reusing the key there would silently refuse it.
    final world = TestWorld();
    final repo = _RecordingRepository();
    final container = containerWith(world, repo);
    final notifier = container.read(bookControllerProvider.notifier);

    await notifier.book(venueSlug: 'katipunan', input: _input);
    await notifier.book(venueSlug: 'katipunan', input: _input);

    expect(repo.keys, hasLength(2));
    expect(repo.keys[1], isNot(repo.keys.first));
  });

  test('session seats follow the same rule', () async {
    final world = TestWorld();
    final repo = _RecordingRepository(failFirst: 1);
    final container = containerWith(world, repo);
    final notifier = container.read(bookControllerProvider.notifier);

    await expectLater(
      notifier.bookSession(
        venueSlug: 'katipunan',
        sessionId: 'sess-1',
        spots: 2,
        contact: const Contact(name: 'Rafael', email: 'rafael@example.com'),
      ),
      throwsA(isA<ApiError>()),
    );
    await notifier.bookSession(
      venueSlug: 'katipunan',
      sessionId: 'sess-1',
      spots: 2,
      contact: const Contact(name: 'Rafael', email: 'rafael@example.com'),
    );

    expect(repo.keys[1], repo.keys.first);
  });
}
