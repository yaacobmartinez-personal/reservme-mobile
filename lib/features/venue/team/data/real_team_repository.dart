import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/team.dart';

/// [TeamRepository] over the HTTP API (API-CONTRACT #31).
class RealTeamRepository implements TeamRepository {
  RealTeamRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard() {
    if (!isAvailable(Feature.team, _mode)) throw ApiError.notAvailable();
  }

  String _base(String venueSlug) => '/mobile/venues/$venueSlug/team';

  Team _team(Map<String, dynamic> json) => Team.fromJson(json);

  @override
  Future<Team> get(String venueSlug) async {
    _guard();
    return _team(await _api.get(_base(venueSlug)));
  }

  @override
  Future<Team> invite(String venueSlug, InviteInput input) async {
    _guard();
    return _team(await _api.post(
      '${_base(venueSlug)}/invitations',
      body: input.toJson(),
    ));
  }

  @override
  Future<Team> cancelInvite(String venueSlug, String invitationId) async {
    _guard();
    return _team(
      await _api.delete('${_base(venueSlug)}/invitations/$invitationId'),
    );
  }

  @override
  Future<Team> setRole(
    String venueSlug,
    String memberId,
    VenueRole role,
  ) async {
    _guard();
    return _team(await _api.patch(
      '${_base(venueSlug)}/members/$memberId',
      body: {'role': role.wire},
    ));
  }

  @override
  Future<Team> removeMember(String venueSlug, String memberId) async {
    _guard();
    return _team(await _api.delete('${_base(venueSlug)}/members/$memberId'));
  }
}
