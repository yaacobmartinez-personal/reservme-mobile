import '../../venue/venues/domain/venue_membership.dart';
import 'user.dart';

/// What a successful sign-in returns (API-CONTRACT #10): the bearer token and
/// who it belongs to. The venue list arrives separately from `/mobile/me`,
/// because the same call refreshes it later in the session.
class AuthResult {
  const AuthResult({required this.token, required this.user});

  final String token;
  final User user;
}

/// The signed-in user and every venue they belong to (API-CONTRACT #13).
class Me {
  const Me({required this.user, required this.venues});

  final User user;
  final List<VenueMembership> venues;
}

/// Staff authentication. Customers never sign in, so this is the whole of it:
/// email and password, a reset request, `/me`, and sign-out.
abstract class AuthRepository {
  /// Throws `ApiError(401)` for a wrong password and `ApiError(429)` when the
  /// server is rate-limiting attempts.
  Future<AuthResult> signIn({required String email, required String password});

  /// Always succeeds, whether or not the address has an account — otherwise
  /// this endpoint would tell an attacker which emails exist.
  Future<void> requestPasswordReset(String email);

  /// Confirms the token and refreshes the venue list.
  Future<Me> me();

  /// Best-effort: the app forgets the session either way.
  Future<void> signOut();
}
