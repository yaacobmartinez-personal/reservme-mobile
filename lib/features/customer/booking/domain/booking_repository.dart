import 'availability.dart';
import 'booking.dart';

/// Availability + creating a booking (API-CONTRACT #2–#4, #9).
abstract class BookingRepository {
  /// Slots and sessions for one space on one venue-local date.
  Future<DayAvailability> availability({
    required String venueSlug,
    required String spaceId,
    required String date,
  });

  /// Book a slot. Never throws for an expected outcome — a taken slot, a
  /// closed venue and a rate limit all come back as a [BookOutcome].
  /// [idempotencyKey] must be the *same* string across retries of one attempt:
  /// that is the whole point of it. The caller owns it, because only the
  /// caller knows whether this is a retry or a second booking.
  Future<BookOutcome> book({
    required String venueSlug,
    required BookingInput input,
    String? idempotencyKey,
  });

  /// Claim seats in a shared session.
  Future<BookOutcome> bookSession({
    required String venueSlug,
    required String sessionId,
    required int spots,
    required String name,
    required String email,
    String? phone,
    String? idempotencyKey,
  });

  /// Ask to be told if a taken slot frees up. No idempotency key: joining
  /// twice is already a no-op on the server, which dedupes on
  /// (space, slot, customer).
  Future<void> joinWaitlist({
    required String venueSlug,
    required String spaceId,
    required DateTime startsAt,
    required DateTime endsAt,
    required String name,
    required String email,
    String? phone,
  });
}
