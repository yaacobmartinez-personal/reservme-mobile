import 'package:dio/dio.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/model/opening_hours.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/space_detail.dart';
import '../domain/space_input.dart';
import '../domain/space_summary.dart';

/// [SpacesRepository] over the HTTP API (API-CONTRACT #24, #28, #29).
class RealSpacesRepository implements SpacesRepository {
  RealSpacesRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard() {
    if (!isAvailable(Feature.spaces, _mode)) throw ApiError.notAvailable();
  }

  String _base(String venueSlug) => '/mobile/venues/$venueSlug/spaces';

  SpaceDetail _detail(Map<String, dynamic> json) =>
      SpaceDetail.fromJson(json['space'] as Map<String, dynamic>);

  @override
  Future<List<SpaceSummary>> list(String venueSlug) async {
    _guard();
    final json = await _api.get(_base(venueSlug));
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
      '${_base(venueSlug)}/$spaceId/active',
      body: {'active': active},
    );
    return SpaceSummary.fromJson(json['space'] as Map<String, dynamic>);
  }

  @override
  Future<SpaceDetail> detail(String venueSlug, String spaceId) async {
    _guard();
    return _detail(await _api.get('${_base(venueSlug)}/$spaceId'));
  }

  @override
  Future<SpaceDetail> create(String venueSlug, SpaceInput input) async {
    _guard();
    return _detail(await _api.post(_base(venueSlug), body: input.toJson()));
  }

  @override
  Future<SpaceDetail> update(
    String venueSlug,
    String spaceId,
    SpaceInput input,
  ) async {
    _guard();
    return _detail(
      await _api.patch('${_base(venueSlug)}/$spaceId', body: input.toJson()),
    );
  }

  @override
  Future<void> remove(String venueSlug, String spaceId) async {
    _guard();
    await _api.delete('${_base(venueSlug)}/$spaceId');
  }

  @override
  Future<SpaceDetail> setHours(
    String venueSlug,
    String spaceId,
    HoursInput hours,
  ) async {
    _guard();
    // A closed day is an absent row, never a row with a flag — that is what
    // `setOpeningHours` writes and what availability reads.
    return _detail(await _api.put(
      '${_base(venueSlug)}/$spaceId/hours',
      body: {
        'hours': [
          for (final day in hours.days.where((d) => d.isUsable))
            {
              'weekday': day.weekday,
              'opensAt': day.opensAt,
              'closesAt': day.closesAt,
            },
        ],
      },
    ));
  }

  @override
  Future<SpaceDetail> setImage(
    String venueSlug,
    String spaceId,
    List<int>? image,
  ) async {
    _guard();
    final path = '${_base(venueSlug)}/$spaceId/image';
    if (image == null) return _detail(await _api.delete(path));
    return _detail(await _api.upload(
      path,
      FormData.fromMap({
        'image': MultipartFile.fromBytes(image, filename: 'space.jpg'),
      }),
    ));
  }

  @override
  Future<SpaceDetail> addPricingRule(
    String venueSlug,
    String spaceId,
    PricingRuleInput input,
  ) async {
    _guard();
    return _detail(await _api.post(
      '${_base(venueSlug)}/$spaceId/pricing-rules',
      body: input.toJson(),
    ));
  }

  @override
  Future<SpaceDetail> removePricingRule(
    String venueSlug,
    String spaceId,
    String ruleId,
  ) async {
    _guard();
    return _detail(
      await _api.delete('${_base(venueSlug)}/$spaceId/pricing-rules/$ruleId'),
    );
  }

  @override
  Future<SpaceDetail> addClosure(
    String venueSlug,
    String spaceId,
    ClosureInput input,
  ) async {
    _guard();
    return _detail(await _api.post(
      '/mobile/venues/$venueSlug/closures',
      body: {...input.toJson(), 'forSpaceId': spaceId},
    ));
  }

  @override
  Future<SpaceDetail> removeClosure(
    String venueSlug,
    String spaceId,
    String closureId,
  ) async {
    _guard();
    // The space to answer with rides in the query, not a body: a DELETE body
    // is legal and quietly dropped by enough proxies not to depend on.
    return _detail(await _api.delete(
      '/mobile/venues/$venueSlug/closures/$closureId?forSpaceId=$spaceId',
    ));
  }
}
