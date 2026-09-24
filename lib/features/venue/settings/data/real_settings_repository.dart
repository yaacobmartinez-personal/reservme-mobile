import 'package:dio/dio.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/venue_settings.dart';

/// [SettingsRepository] over the HTTP API (API-CONTRACT #30).
class RealSettingsRepository implements SettingsRepository {
  RealSettingsRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard() {
    if (!isAvailable(Feature.venueSettings, _mode)) throw ApiError.notAvailable();
  }

  VenueSettings _venue(Map<String, dynamic> json) =>
      VenueSettings.fromJson(json['venue'] as Map<String, dynamic>);

  @override
  Future<VenueSettings> get(String venueSlug) async {
    _guard();
    return _venue(await _api.get('/mobile/venues/$venueSlug/settings'));
  }

  @override
  Future<VenueSettings> update(
    String venueSlug,
    VenueSettingsInput input,
  ) async {
    _guard();
    return _venue(
      await _api.patch('/mobile/venues/$venueSlug', body: input.toJson()),
    );
  }

  @override
  Future<VenueSettings> setBranding(
    String venueSlug,
    BrandingSlot slot,
    List<int>? image,
  ) async {
    _guard();
    final path = '/mobile/venues/$venueSlug/branding/${slot.wire}';
    if (image == null) return _venue(await _api.delete(path));
    return _venue(await _api.upload(
      path,
      FormData.fromMap({
        'image': MultipartFile.fromBytes(image, filename: '${slot.wire}.jpg'),
      }),
    ));
  }
}
