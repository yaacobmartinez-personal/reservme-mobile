import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/waitlist_entry.dart';

/// [VenueWaitlistRepository] over the HTTP API (API-CONTRACT #23).
class RealWaitlistRepository implements VenueWaitlistRepository {
  RealWaitlistRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  @override
  Future<List<WaitlistEntry>> entries(String venueSlug) async {
    if (!isAvailable(Feature.venueWaitlist, _mode)) throw ApiError.notAvailable();
    final json = await _api.get('/mobile/venues/$venueSlug/waitlist');
    final rows = (json['entries'] as List?) ?? const [];
    return [
      for (final row in rows.whereType<Map<String, dynamic>>())
        WaitlistEntry.fromJson(row),
    ];
  }
}
