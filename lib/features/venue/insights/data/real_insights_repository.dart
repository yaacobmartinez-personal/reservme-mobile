import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/insights.dart';

/// [InsightsRepository] over the HTTP API (API-CONTRACT #33).
class RealInsightsRepository implements InsightsRepository {
  RealInsightsRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  @override
  Future<Insights> get(String venueSlug, InsightsRange range) async {
    if (!isAvailable(Feature.insights, _mode)) throw ApiError.notAvailable();
    final json = await _api.get(
      '/mobile/venues/$venueSlug/insights',
      query: {'period': range.wire},
    );
    return Insights.fromJson(json['insights'] as Map<String, dynamic>);
  }
}
