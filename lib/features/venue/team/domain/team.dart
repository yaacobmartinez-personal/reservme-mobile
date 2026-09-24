import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/enums.dart';

part 'team.freezed.dart';
part 'team.g.dart';

/// G3 · Team (API-CONTRACT #31). One Better Auth organization is one venue, so
/// "the team" is that organization's members plus its pending invitations.
@freezed
abstract class Team with _$Team {
  const Team._();

  const factory Team({
    @Default(<TeamMember>[]) List<TeamMember> members,
    @Default(<PendingInvite>[]) List<PendingInvite> invitations,

    /// What the signed-in user may do here, so the screen can explain rather
    /// than hide.
    @Default(VenueRole.member) VenueRole yourRole,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  int get ownerCount => members.where((m) => m.role == VenueRole.owner).length;

  /// Admins invite and manage staff; only an owner can hand over ownership.
  bool get canManage => yourRole.atLeast(VenueRole.admin);
  bool get canAssignOwner => yourRole == VenueRole.owner;
}

@freezed
abstract class TeamMember with _$TeamMember {
  const TeamMember._();

  const factory TeamMember({
    required String id,
    required String userId,
    required String name,
    required String email,
    @Default(VenueRole.member) VenueRole role,
    @Default(false) bool isSelf,
    required DateTime joinedAt,
  }) = _TeamMember;

  factory TeamMember.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberFromJson(json);
}

@freezed
abstract class PendingInvite with _$PendingInvite {
  const PendingInvite._();

  const factory PendingInvite({
    required String id,
    required String email,
    @Default(VenueRole.member) VenueRole role,
    required DateTime expiresAt,
  }) = _PendingInvite;

  factory PendingInvite.fromJson(Map<String, dynamic> json) =>
      _$PendingInviteFromJson(json);

  bool expiredAt(DateTime now) => !expiresAt.isAfter(now);
}

/// An invitation the owner is about to send.
class InviteInput {
  const InviteInput({required this.email, this.role = VenueRole.member});

  final String email;
  final VenueRole role;

  static final _email = RegExp(r'^[^@\s]+@[^@\s.]+\.[^@\s]+$');

  String? validate() {
    final trimmed = email.trim();
    if (trimmed.isEmpty) return 'Who are you inviting?';
    if (!_email.hasMatch(trimmed)) return "That email doesn't look right.";
    return null;
  }

  bool get isValid => validate() == null;

  InviteInput copyWith({String? email, VenueRole? role}) =>
      InviteInput(email: email ?? this.email, role: role ?? this.role);

  Map<String, dynamic> toJson() => {
        'email': email.trim().toLowerCase(),
        'role': role.wire,
      };
}

abstract class TeamRepository {
  Future<Team> get(String venueSlug);

  Future<Team> invite(String venueSlug, InviteInput input);

  Future<Team> cancelInvite(String venueSlug, String invitationId);

  /// Refused when it would leave the venue with no owner (409 `last_owner`).
  Future<Team> setRole(String venueSlug, String memberId, VenueRole role);

  Future<Team> removeMember(String venueSlug, String memberId);
}
