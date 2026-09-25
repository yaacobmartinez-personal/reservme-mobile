import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../../booking/domain/availability.dart';
import '../../booking/domain/booking.dart';
import '../domain/manage_repository.dart';

/// [ManageRepository] over the HTTP API (API-CONTRACT #5–#8).
class RealManageRepository implements ManageRepository {
  RealManageRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  String _base(String slug, String token) => '/public/venues/$slug/bookings/$token';

  @override
  Future<Booking> byToken({required String venueSlug, required String token}) async {
    if (!isAvailable(Feature.manageBooking, _mode)) throw ApiError.notAvailable();
    final json = await _api.get(_base(venueSlug, token));
    return Booking.fromJson(json['booking'] as Map<String, dynamic>);
  }

  @override
  Future<CancelOutcome> cancel({required String venueSlug, required String token}) async {
    if (!isAvailable(Feature.manageBooking, _mode)) throw ApiError.notAvailable();
    try {
      final json = await _api.post('${_base(venueSlug, token)}/cancel');
      if (json['outcome'] == 'refused') {
        return CancelRefused(
          json['reason'] as String? ?? 'This booking cannot be cancelled online.',
        );
      }
      return Cancelled(Booking.fromJson(json['booking'] as Map<String, dynamic>));
    } on ApiError catch (e) {
      if (e.status == 422) return CancelRefused(e.message);
      rethrow;
    }
  }

  @override
  Future<List<RescheduleDay>> rescheduleOptions({
    required String venueSlug,
    required String token,
    int days = 7,
  }) async {
    if (!isAvailable(Feature.reschedule, _mode)) throw ApiError.notAvailable();
    final json = await _api.get(
      '${_base(venueSlug, token)}/reschedule-options',
      query: {'days': days},
    );
    final raw = (json['days'] as List<dynamic>? ?? const []);
    return [
      for (final d in raw.whereType<Map<String, dynamic>>())
        RescheduleDay(
          date: d['date'] as String,
          slots: [
            for (final s in (d['slots'] as List<dynamic>? ?? const [])
                .whereType<Map<String, dynamic>>())
              Slot.fromJson(s),
          ],
        ),
    ];
  }

  @override
  Future<RescheduleOutcome> reschedule({
    required String venueSlug,
    required String token,
    required DateTime startsAt,
    required DateTime endsAt,
  }) async {
    if (!isAvailable(Feature.reschedule, _mode)) throw ApiError.notAvailable();
    try {
      final json = await _api.post(
        '${_base(venueSlug, token)}/reschedule',
        body: {
          'startsAt': startsAt.toUtc().toIso8601String(),
          'endsAt': endsAt.toUtc().toIso8601String(),
        },
      );
      return Rescheduled(Booking.fromJson(json['booking'] as Map<String, dynamic>));
    } on ApiError catch (e) {
      return switch (e.status) {
        409 => const RescheduleSlotTaken(),
        422 => RescheduleRefused(e.message),
        _ => throw e,
      };
    }
  }
}
