import '../../../core/config/app_config.dart';
import '../../../core/config/feature_availability.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../venue/venues/domain/venue_membership.dart';
import '../domain/auth_repository.dart';
import '../domain/user.dart';

/// [AuthRepository] over the HTTP API (API-CONTRACT #10–#13).
class RealAuthRepository implements AuthRepository {
  RealAuthRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  @override
  Future<AuthResult> signIn({required String email, required String password}) async {
    if (!isAvailable(Feature.venueLogin, _mode)) throw ApiError.notAvailable();
    final json = await _api.post(
      '/mobile/auth/login',
      body: {'email': email.trim(), 'password': password},
    );
    return AuthResult(
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    if (!isAvailable(Feature.venueLogin, _mode)) throw ApiError.notAvailable();
    await _api.post('/mobile/auth/forgot-password', body: {'email': email.trim()});
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    // The in-app reset belongs to the sign-up feature's endpoints (#26),
    // not to login, so it is gated with them.
    if (!isAvailable(Feature.signup, _mode)) throw ApiError.notAvailable();
    await _api.post('/mobile/auth/reset-password', body: {
      'email': email.trim().toLowerCase(),
      'code': code.trim(),
      'password': password,
    });
  }

  @override
  Future<void> deleteAccount() async {
    if (!isAvailable(Feature.deleteAccount, _mode)) {
      throw ApiError.notAvailable();
    }
    await _api.delete('/mobile/me');
  }

  @override
  Future<Me> me() async {
    if (!isAvailable(Feature.venueLogin, _mode)) throw ApiError.notAvailable();
    final json = await _api.get('/mobile/me');
    return Me(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      venues: [
        for (final v in (json['venues'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>())
          VenueMembership.fromJson(v),
      ],
    );
  }

  @override
  Future<void> signOut() async {
    if (!isAvailable(Feature.venueLogin, _mode)) return;
    try {
      await _api.post('/mobile/auth/logout');
    } on ApiError {
      // Revoking server-side is best effort; the app forgets the token anyway.
    }
  }
}
