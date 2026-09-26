import '../../../core/fake/fake_latency.dart';
import '../../../core/fake/fake_store.dart';
import '../../../core/model/enums.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/token_codec.dart';
import '../../../core/time/clock.dart';
import '../../venue/venues/domain/venue_membership.dart';
import '../domain/auth_repository.dart';
import '../domain/user.dart';

/// In-memory [AuthRepository]. Answers the way the server does: a wrong
/// password is a 401 with the server's wording, a reset request always
/// succeeds, and `/me` is the only thing that confirms a token.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository(this._store, this._latency, this._clock, this._offline, this._token);

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;

  /// The token currently held by the app, so `/me` can resolve its subject
  /// exactly as the server resolves `sub`.
  final String? Function() _token;

  /// Tokens live 30 days, like the real ones.
  static const _ttl = Duration(days: 30);

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  @override
  Future<AuthResult> signIn({required String email, required String password}) async {
    await _tick();
    final user = _store.userByEmail(email);
    if (user == null || user.password != password) {
      throw ApiError(401, "That email and password don't match.");
    }
    return AuthResult(
      token: TokenCodec.mintFake(user.id, _clock().add(_ttl)),
      user: _userOf(user),
    );
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    await _tick();
    final user = _store.userByEmail(email);
    // Silence either way; only a real account gets an email.
    if (user == null) return;
    final code = (100000 + (user.id.hashCode.abs() % 900000)).toString();
    _store.emailCodes[user.email.toLowerCase()] = code;
    _store.outbox.add(FakeEmail(
      to: user.email,
      kind: FakeEmailKind.reset,
      body: 'Your ReservMe reset code is $code.',
      sentAt: _clock(),
    ));
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    await _tick();
    final key = email.trim().toLowerCase();
    final user = _store.userByEmail(key);
    final expected = _store.emailCodes[key];

    // One refusal for a wrong code and for an address with no account: the
    // reset request itself is deliberately silent about which emails exist,
    // and this step must not undo that.
    if (user == null || expected == null || code.trim() != expected) {
      throw ApiError(400, "That code doesn't match. Check the email again.");
    }
    if (password.length < _minPasswordLength) {
      throw ApiError(400, 'Use at least $_minPasswordLength characters.');
    }

    user.password = password;
    _store.emailCodes.remove(key);
  }

  /// Better Auth's `minPasswordLength`, the same number sign-up enforces.
  static const _minPasswordLength = 10;

  @override
  Future<void> deleteAccount() async {
    await _tick();
    final user = _me();

    // A venue whose only owner leaves has nobody who can pay for it or hand
    // it on, and no way back short of support. The same guard the team
    // screen applies to the last owner.
    final stranded = <String>[];
    for (final m in _store.membershipsOf(user.id)) {
      if (m.role != VenueRole.owner) continue;
      final owners = _store
          .membersOf(m.venueId)
          .where((other) => other.role == VenueRole.owner)
          .length;
      if (owners <= 1) {
        stranded.add(_store.venueById(m.venueId)?.name ?? 'a venue');
      }
    }
    if (stranded.isNotEmpty) {
      throw ApiError(
        409,
        stranded.length == 1
            ? 'You are the only owner of ${stranded.single}. Make someone '
                'else an owner first, or delete the venue.'
            : 'You are the only owner of ${stranded.join(', ')}. Make someone '
                'else an owner of each first, or delete them.',
        reason: 'sole_owner',
      );
    }

    // Everything that belongs only to this user goes with them. Venues they
    // merely worked at keep their bookings, which belong to the venue.
    _store.memberships.removeWhere((m) => m.userId == user.id);
    _store.customerNotes.removeWhere((n) => n.authorUserId == user.id);
    _store.emailCodes.remove(user.email.toLowerCase());
    _store.users.remove(user);
  }

  @override
  Future<Me> me() async {
    await _tick();
    final user = _me();

    final venues = [
      for (final m in _store.membershipsOf(user.id))
        if (_store.venueById(m.venueId) case final v?)
          VenueMembership(
            orgId: v.id,
            slug: v.slug,
            name: v.name,
            role: m.role,
            timezone: v.timezone,
            currency: v.currency,
            theme: v.theme,
            suspended: v.suspended,
            activeSpaces: _store.spacesOf(v.id, activeOnly: true).length,
          ),
    ]..sort((a, b) => a.name.compareTo(b.name));

    return Me(
      user: _userOf(user),
      venues: venues,
      platformAdmin: _store.platformAdmins.contains(user.id),
    );
  }

  @override
  Future<void> signOut() async {
    // The fake server has no session table; the app forgetting the token is
    // the whole of it.
  }

  /// The user the bearer token names, or a 401 — the same check `me()` makes.
  FakeUser _me() {
    final token = _token();
    final userId = token == null ? null : TokenCodec.subject(token);
    final user = userId == null ? null : _store.userById(userId);
    if (user == null) {
      throw ApiError(401, 'Your session has expired. Sign in again.');
    }
    return user;
  }

  User _userOf(FakeUser u) => User(
        id: u.id,
        email: u.email,
        name: u.name,
        emailVerified: u.emailVerified,
      );
}
