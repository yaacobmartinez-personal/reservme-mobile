import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/space_summary.dart';

/// [SpacesRepository] over the HTTP API (API-CONTRACT #24).
class RealSpacesRepository implements SpacesRepository {
  RealSpacesRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard() {
    if (!isAvailable(Feature.spaces, _mode)) throw ApiError.notAvailable();
  }

  @override
  Future<List<SpaceSummary>> list(String venueSlug) async {
    _guard();
    final json = await _api.get('/mobile/venues/$venueSlug/spaces');
    final rows = (json['spaces'] as List?) ?? const [];
    return [
      for (final row in rows.whereType<Map<String, dynamic>>())
        SpaceSummary.fromJson(row),
    ];
  }

  @override
  Future<SpaceSummary> setActive(
    String venueSlug,
    String spaceId,
    bool active,
  ) async {
    _guard();
    final json = await _api.post(
      '/mobile/venues/$venueSlug/spaces/$spaceId/active',
      body: {'active': active},
    );
    return SpaceSummary.fromJson(json['space'] as Map<String, dynamic>);
  }
}
