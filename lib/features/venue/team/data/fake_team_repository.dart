import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/clock.dart';
import '../domain/team.dart';

/// In-memory [TeamRepository]. Mutations go through Better Auth's organization
/// plugin on the web; the rules that matter here are the ones the plugin and
/// its guards enforce, and they are the ones this fake keeps:
///
/// - only an owner or admin may touch the team at all;
/// - only an owner may make someone else an owner, or demote one;
/// - a venue can never be left with no owner.
///
/// You *may* change or remove yourself, subject to that last rule — an owner
/// handing the venue over and stepping down is a thing that happens, and the
/// owner count is what stops it going wrong. Forbidding self-changes outright
/// would be safe-looking and would make the last-owner guard unreachable,
/// since an owner can only be demoted by another owner.
class FakeTeamRepository implements TeamRepository {
  FakeTeamRepository(
    this._store,
    this._latency,
    this._clock,
    this._offline,
    this._roleFor,
    this._currentUserId,
  );

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;
  final VenueRole? Function(String venueSlug) _roleFor;
  final String? Function() _currentUserId;

  static const _inviteDays = 7;

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  FakeVenue _venue(String slug) {
    final v = _store.venueBySlug(slug);
    if (v == null) throw ApiError(404, 'We could not find that venue.');
    return v;
  }

  VenueRole _requireManage(String slug) {
    final role = _roleFor(slug);
    if (role == null || !role.atLeast(VenueRole.admin)) {
      throw ApiError(403, 'Only an owner or admin can manage the team.');
    }
    return role;
  }

  @override
  Future<Team> get(String venueSlug) async {
    await _tick();
    return _view(_venue(venueSlug));
  }

  @override
  Future<Team> invite(String venueSlug, InviteInput input) async {
    await _tick();
    final venue = _venue(venueSlug);
    final role = _requireManage(venueSlug);
    final refusal = input.validate();
    if (refusal != null) throw ApiError(400, refusal);

    if (input.role == VenueRole.owner && role != VenueRole.owner) {
      throw ApiError(403, 'Only an owner can invite another owner.');
    }

    final email = input.email.trim().toLowerCase();
    final already = _store.membersOf(venue.id).any((m) =>
        _store.userById(m.userId)?.email.toLowerCase() == email);
    if (already) throw ApiError(409, 'They are already on your team.');

    final pending = _store.invitations.any(
      (i) => i.venueId == venue.id && i.email.toLowerCase() == email,
    );
    if (pending) throw ApiError(409, 'They already have an invitation.');

    _store.invitations.add(FakeInvitation(
      id: _store.nextId('inv'),
      venueId: venue.id,
      email: email,
      role: input.role,
      expiresAt: _clock().add(const Duration(days: _inviteDays)),
      createdAt: _clock(),
    ));
    _store.outbox.add(FakeEmail(
      to: email,
      kind: FakeEmailKind.invite,
      body: 'You have been invited to help run ${venue.name} on ReservMe.',
      sentAt: _clock(),
    ));
    return _view(venue);
  }

  @override
  Future<Team> cancelInvite(String venueSlug, String invitationId) async {
    await _tick();
    final venue = _venue(venueSlug);
    _requireManage(venueSlug);
    _store.invitations
        .removeWhere((i) => i.id == invitationId && i.venueId == venue.id);
    return _view(venue);
  }

  @override
  Future<Team> setRole(
    String venueSlug,
    String memberId,
    VenueRole role,
  ) async {
    await _tick();
    final venue = _venue(venueSlug);
    final yours = _requireManage(venueSlug);
    final member = _member(venue, memberId);

    // Ownership is the one thing an admin cannot hand out or take away.
    if ((role == VenueRole.owner || member.role == VenueRole.owner) &&
        yours != VenueRole.owner) {
      throw ApiError(403, 'Only an owner can change who owns the venue.');
    }
    if (member.role == VenueRole.owner && role != VenueRole.owner) {
      _guardLastOwner(venue);
    }

    member.role = role;
    return _view(venue);
  }

  @override
  Future<Team> removeMember(String venueSlug, String memberId) async {
    await _tick();
    final venue = _venue(venueSlug);
    final yours = _requireManage(venueSlug);
    final member = _member(venue, memberId);

    if (member.role == VenueRole.owner) {
      if (yours != VenueRole.owner) {
        throw ApiError(403, 'Only an owner can remove another owner.');
      }
      _guardLastOwner(venue);
    }

    _store.memberships.remove(member);
    return _view(venue);
  }

  /// The last-owner guard. A venue with no owner has nobody who can pay for
  /// it or hand it on, and no way back short of support.
  void _guardLastOwner(FakeVenue venue) {
    final owners = _store
        .membersOf(venue.id)
        .where((m) => m.role == VenueRole.owner)
        .length;
    if (owners <= 1) {
      throw ApiError(
        409,
        'Every venue needs an owner. Make someone else an owner first.',
      );
    }
  }

  FakeMembership _member(FakeVenue venue, String memberId) {
    final member = _store
        .membersOf(venue.id)
        .where((m) => m.id == memberId)
        .firstOrNull;
    if (member == null) throw ApiError(404, 'They are not on your team.');
    return member;
  }

  Team _view(FakeVenue venue) {
    final me = _currentUserId();
    final members = [
      for (final m in _store.membersOf(venue.id))
        if (_store.userById(m.userId) case final user?)
          TeamMember(
            id: m.id,
            userId: m.userId,
            // A member who signed up without a name is still on the team;
            // show the local part of their email rather than a blank row.
            name: user.name ?? user.email.split('@').first,
            email: user.email,
            role: m.role,
            isSelf: m.userId == me,
            joinedAt: m.createdAt,
          ),
    ]..sort((a, b) {
        // Owners first, then oldest first — the web's ORDER BY.
        final byRole = (b.role == VenueRole.owner ? 1 : 0)
            .compareTo(a.role == VenueRole.owner ? 1 : 0);
        return byRole != 0 ? byRole : a.joinedAt.compareTo(b.joinedAt);
      });

    return Team(
      members: members,
      invitations: [
        for (final i in _store.invitations)
          if (i.venueId == venue.id)
            PendingInvite(
              id: i.id,
              email: i.email,
              role: i.role,
              expiresAt: i.expiresAt,
            ),
      ]..sort((a, b) => b.expiresAt.compareTo(a.expiresAt)),
      yourRole: _roleFor(venue.slug) ?? VenueRole.member,
    );
  }
}
