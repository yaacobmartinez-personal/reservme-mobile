import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/availability.dart';
import '../domain/booking.dart';
import '../domain/booking_repository.dart';

/// [BookingRepository] over the HTTP API (API-CONTRACT #2–#4, #9).
///
/// The expected refusals — a taken slot, a full session, a closed venue, a
/// rate limit — are mapped to [BookOutcome] rather than thrown, so the UI
/// treats them as answers instead of errors.
class RealBookingRepository implements BookingRepository {
  RealBookingRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  @override
  Future<DayAvailability> availability({
    required String venueSlug,
    required String spaceId,
    required String date,
  }) async {
    if (!isAvailable(Feature.customerBrowse, _mode)) throw ApiError.notAvailable();
    final json = await _api.get(
      '/public/venues/$venueSlug/availability',
      query: {'space': spaceId, 'date': date},
    );
    return DayAvailability.fromJson(json);
  }

  @override
  Future<BookOutcome> book({
    required String venueSlug,
    required BookingInput input,
    String? idempotencyKey,
  }) async {
    if (!isAvailable(Feature.customerBooking, _mode)) throw ApiError.notAvailable();
    return _attempt(() async {
      final json = await _api.post(
        '/public/venues/$venueSlug/bookings',
        body: {
          'spaceId': input.spaceId,
          'startsAt': input.startsAt.toUtc().toIso8601String(),
          'endsAt': input.endsAt.toUtc().toIso8601String(),
          'name': input.name.trim(),
          'email': input.email.trim(),
          if (input.phone != null && input.phone!.trim().isNotEmpty)
            'phone': input.phone!.trim(),
          if (input.promo != null && input.promo!.trim().isNotEmpty)
            'promo': input.promo!.trim(),
          'partySize': input.partySize,
        },
        idempotencyKey: idempotencyKey,
      );
      return Booked(Booking.fromJson(json['booking'] as Map<String, dynamic>));
    });
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
    if (!isAvailable(Feature.customerBooking, _mode)) throw ApiError.notAvailable();
    return _attempt(() async {
      final json = await _api.post(
        '/public/venues/$venueSlug/sessions/$sessionId/bookings',
        body: {
          'spots': spots,
          'name': name.trim(),
          'email': email.trim(),
          if (phone != null && phone.trim().isNotEmpty) 'phone': phone.trim(),
        },
        idempotencyKey: idempotencyKey,
      );
      return Booked(Booking.fromJson(json['booking'] as Map<String, dynamic>));
    });
  }

  @override
  Future<void> joinWaitlist({
    required String venueSlug,
    required String spaceId,
    required DateTime startsAt,
    required DateTime endsAt,
    required String name,
    required String email,
    String? phone,
  }) async {
    if (!isAvailable(Feature.waitlist, _mode)) throw ApiError.notAvailable();
    await _api.post(
      '/public/venues/$venueSlug/waitlist',
      body: {
        'spaceId': spaceId,
        'startsAt': startsAt.toUtc().toIso8601String(),
        'endsAt': endsAt.toUtc().toIso8601String(),
        'name': name.trim(),
        'email': email.trim(),
        if (phone != null && phone.trim().isNotEmpty) 'phone': phone.trim(),
      },
    );
  }

  /// Turns the contract's expected failures into outcomes; anything else
  /// (404, 500, transport) stays an exception for `AsyncView` to show.
  Future<BookOutcome> _attempt(Future<BookOutcome> Function() run) async {
    try {
      return await run();
    } on ApiError catch (e) {
      return switch (e) {
        ApiError(status: 409, reason: 'session_full') => const SessionFull(),
        ApiError(status: 409) => const SlotTaken(),
        ApiError(status: 403) => VenueClosed(e.message),
        ApiError(status: 429) => RateLimited(e.message),
        ApiError(status: 400) => BookingInvalid(e.fieldErrors, e.message),
        _ => throw e,
      };
    }
  }
}
