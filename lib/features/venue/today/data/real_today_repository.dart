import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/run_sheet.dart';
import '../domain/today_repository.dart';

/// [TodayRepository] over the HTTP API (API-CONTRACT #14, #15).
class RealTodayRepository implements TodayRepository {
  RealTodayRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard() {
    if (!isAvailable(Feature.today, _mode)) throw ApiError.notAvailable();
  }

  @override
  Future<TodayView> today(String venueSlug) async {
    _guard();
    return TodayView.fromJson(await _api.get('/mobile/venues/$venueSlug/today'));
  }

  @override
  Future<RunSheetEntry> checkIn(String venueSlug, String bookingId, {DateTime? at}) =>
      _action(venueSlug, bookingId, 'checkin', body: {
        if (at != null) 'at': at.toUtc().toIso8601String(),
      });

  @override
  Future<RunSheetEntry> undoCheckIn(String venueSlug, String bookingId) =>
      _action(venueSlug, bookingId, 'undo-checkin');

  @override
  Future<RunSheetEntry> noShow(String venueSlug, String bookingId) =>
      _action(venueSlug, bookingId, 'no-show');

  @override
  Future<RunSheetEntry> cancel(String venueSlug, String bookingId) =>
      _action(venueSlug, bookingId, 'cancel');

  Future<RunSheetEntry> _action(
    String venueSlug,
    String bookingId,
    String action, {
    Map<String, dynamic>? body,
  }) async {
    _guard();
    final json = await _api.post(
      '/mobile/venues/$venueSlug/bookings/$bookingId/$action',
      body: body,
      idempotent: true,
    );
    return RunSheetEntry.fromJson(json['booking'] as Map<String, dynamic>);
  }
}
