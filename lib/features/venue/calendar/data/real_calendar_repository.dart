import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../../today/domain/run_sheet.dart';
import '../domain/calendar_day.dart';
import '../domain/calendar_repository.dart';
import '../domain/manual_booking_input.dart';

/// [CalendarRepository] over the HTTP API (API-CONTRACT #16–#20).
class RealCalendarRepository implements CalendarRepository {
  RealCalendarRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard() {
    if (!isAvailable(Feature.calendar, _mode)) throw ApiError.notAvailable();
  }

  @override
  Future<CalendarDay> day(String venueSlug, String date) async {
    _guard();
    return CalendarDay.fromJson(
      await _api.get('/mobile/venues/$venueSlug/calendar', query: {'date': date}),
    );
  }

  @override
  Future<RunSheetEntry> createBooking(
    String venueSlug,
    ManualBookingInput input,
  ) async {
    _guard();
    final json = await _api.post(
      '/mobile/venues/$venueSlug/bookings',
      body: input.toJson(),
    );
    return RunSheetEntry.fromJson(json['booking'] as Map<String, dynamic>);
  }

  @override
  Future<RunSheetEntry> move(
    String venueSlug,
    String bookingId, {
    required String spaceId,
    required String date,
    required String time,
  }) async {
    _guard();
    final json = await _api.post(
      '/mobile/venues/$venueSlug/bookings/$bookingId/move',
      body: {'spaceId': spaceId, 'date': date, 'time': time},
    );
    return RunSheetEntry.fromJson(json['booking'] as Map<String, dynamic>);
  }

  @override
  Future<CalendarItem> block(String venueSlug, BlockInput input) async {
    _guard();
    final json = await _api.post(
      '/mobile/venues/$venueSlug/blocks',
      body: input.toJson(),
    );
    return CalendarItem.fromJson(json['block'] as Map<String, dynamic>);
  }

  @override
  Future<void> removeBlock(String venueSlug, String blockId) async {
    _guard();
    await _api.delete('/mobile/venues/$venueSlug/blocks/$blockId');
  }

  @override
  Future<List<CustomerHit>> searchCustomers(
    String venueSlug,
    String query,
  ) async {
    _guard();
    final json = await _api.get(
      '/mobile/venues/$venueSlug/customers',
      query: {'q': query},
    );
    // Same endpoint as the Customers screen (#20), so the same page shape:
    // `rows` plus a `total` the typeahead has no use for.
    final rows = (json['rows'] as List?) ?? const [];
    return [
      for (final row in rows.whereType<Map<String, dynamic>>())
        CustomerHit(
          id: row['id'] as String,
          name: row['name'] as String? ?? '',
          email: row['email'] as String? ?? '',
          phone: row['phone'] as String?,
          visits: (row['bookings'] as num?)?.toInt() ?? 0,
        ),
    ];
  }
}
