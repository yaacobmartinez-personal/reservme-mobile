import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/model/enums.dart';
import '../../venue_providers.dart';
import '../domain/team.dart';

part 'team_controller.g.dart';

/// G3 · Team. Every write returns the whole team, because the rules are about
/// the shape of it — demoting the last owner is only refusable if you can see
/// how many owners there are.
@riverpod
class TeamController extends _$TeamController {
  @override
  Future<Team> build(String venueSlug) =>
      ref.watch(teamRepositoryProvider).get(venueSlug);

  Future<void> invite(InviteInput input) async {
    state = AsyncData(await _repo.invite(venueSlug, input));
  }

  Future<void> cancelInvite(String invitationId) async {
    state = AsyncData(await _repo.cancelInvite(venueSlug, invitationId));
  }

  Future<void> setRole(String memberId, VenueRole role) async {
    state = AsyncData(await _repo.setRole(venueSlug, memberId, role));
  }

  Future<void> remove(String memberId) async {
    state = AsyncData(await _repo.removeMember(venueSlug, memberId));
  }

  TeamRepository get _repo => ref.read(teamRepositoryProvider);
}
