import 'package:dio/dio.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/billing.dart';

/// [BillingRepository] over the HTTP API (API-CONTRACT #32).
class RealBillingRepository implements BillingRepository {
  RealBillingRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard() {
    if (!isAvailable(Feature.billing, _mode)) throw ApiError.notAvailable();
  }

  Billing _billing(Map<String, dynamic> json) =>
      Billing.fromJson(json['billing'] as Map<String, dynamic>);

  @override
  Future<Billing> get(String venueSlug) async {
    _guard();
    return _billing(await _api.get('/mobile/venues/$venueSlug/billing'));
  }

  @override
  Future<Billing> submitProof(
    String venueSlug,
    PaymentProofInput input, {
    List<int>? receipt,
  }) async {
    _guard();
    // Multipart even without a screenshot, so the server has one shape to
    // parse. The amount is deliberately absent: it comes from the band.
    return _billing(await _api.upload(
      '/mobile/venues/$venueSlug/billing/proof',
      FormData.fromMap({
        ...input.toJson(),
        if (receipt != null)
          'image': MultipartFile.fromBytes(receipt, filename: 'receipt.jpg'),
      }),
    ));
  }
}
