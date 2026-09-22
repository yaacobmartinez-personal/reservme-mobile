import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/public_venue.dart';
import '../domain/venues_repository.dart';

/// [VenuesRepository] over the HTTP API (API-CONTRACT #1).
class RealVenuesRepository implements VenuesRepository {
  RealVenuesRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  @override
  Future<PublicVenue> bySlug(String slug) async {
    if (!isAvailable(Feature.customerBrowse, _mode)) throw ApiError.notAvailable();
    final json = await _api.get('/public/venues/$slug');
    return PublicVenue.fromJson(json['venue'] as Map<String, dynamic>);
  }
}
