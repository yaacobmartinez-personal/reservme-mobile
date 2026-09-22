import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/token_codec.dart';
import '../../../core/network/unauthorized_events.dart';
import '../../../core/storage/boot_data.dart';
import '../../../core/storage/local_store.dart';
import '../../../core/storage/prefs.dart';
import '../../../core/storage/secure_store.dart';
import '../../../core/time/clock.dart';
import '../../shell/application/app_mode_controller.dart';
import '../../venue/venues/domain/venue_membership.dart';
import '../auth_providers.dart';
import '../domain/user.dart';
import 'auth_state.dart';

part 'auth_controller.g.dart';

/// The venue-staff session.
///
/// Boot restores a persisted session optimistically — the cached user and
/// venue list are enough to draw the shell — then confirms it with `/me`. An
/// expired token, a 401 from anywhere, or a deliberate sign-out ends it.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  Timer? _expiryTimer;

  @override
  AuthState build() {
    final events = ref.watch(unauthorizedEventsProvider);
    final sub = events.stream.listen((_) {
      if (state.isSignedIn) signOut(reason: SignOutReason.sessionExpired);
    });
    ref.onDispose(() {
      sub.cancel();
      _expiryTimer?.cancel();
    });

    final boot = ref.watch(bootDataProvider);
    final token = boot.token;
    final user = boot.user;
    if (token == null || user == null) return const AuthState.signedOut();

    final expiry = TokenCodec.expiry(token);
    final now = ref.read(clockProvider)();
    if (expiry == null || !expiry.isAfter(now)) {
      return const AuthState.signedOut(reason: SignOutReason.sessionExpired);
    }

    // Confirm the restored session without blocking the first frame.
    Future.microtask(refreshVenues);
    _armExpiry(expiry);
    return AuthState.signedIn(
      user: user,
      token: token,
      expiresAt: expiry,
      venues: boot.venues,
    );
  }

  SecureStore get _secure => ref.read(secureStoreProvider);

  /// Sign in with email and password. Errors propagate so the login screen
  /// can show the server's own wording (wrong password, rate limit).
  Future<void> signIn({required String email, required String password}) async {
    final result = await ref.read(authRepositoryProvider).signIn(
          email: email,
          password: password,
        );
    await _establish(result.user, result.token, const []);
    await refreshVenues();
  }

  Future<void> requestPasswordReset(String email) =>
      ref.read(authRepositoryProvider).requestPasswordReset(email);

  /// Pull the venue list from `/me`. This is also what confirms a restored
  /// token: a 401 here signs the app out through [UnauthorizedEvents].
  Future<List<VenueMembership>> refreshVenues() async {
    if (!state.isSignedIn) return const [];
    try {
      final me = await ref.read(authRepositoryProvider).me();
      final current = state;
      if (current is! SignedIn) return const [];
      await _secure.writeJson(SecureStore.keyUser, me.user.toJson());
      await _secure.writeJson(
        SecureStore.keyVenues,
        me.venues.map((v) => v.toJson()).toList(),
      );
      state = current.copyWith(user: me.user, venues: me.venues, venuesFresh: true);
      return me.venues;
    } on ApiError catch (e) {
      // 401 already signed us out via the interceptor. Anything else (offline,
      // server down) leaves the cached list in place.
      if (e.isUnauthorized) return const [];
      return state.venuesOrEmpty;
    }
  }

  Future<void> _establish(User user, String token, List<VenueMembership> venues) async {
    final expiresAt =
        TokenCodec.expiry(token) ?? ref.read(clockProvider)().add(const Duration(days: 30));
    ref.read(currentTokenProvider.notifier).set(token);
    await _secure.write(SecureStore.keyToken, token);
    await _secure.writeJson(SecureStore.keyUser, user.toJson());
    await _secure.writeJson(SecureStore.keyVenues, venues.map((v) => v.toJson()).toList());
    _armExpiry(expiresAt);
    state = AuthState.signedIn(
      user: user,
      token: token,
      expiresAt: expiresAt,
      venues: venues,
    );
  }

  /// Sign out at the moment the token dies, rather than letting the next
  /// request fail and look like a server problem.
  void _armExpiry(DateTime expiresAt) {
    _expiryTimer?.cancel();
    final remaining = expiresAt.difference(ref.read(clockProvider)());
    if (remaining <= Duration.zero) {
      signOut(reason: SignOutReason.sessionExpired);
      return;
    }
    // Timer takes an int of microseconds; a 30-day duration is well within it.
    _expiryTimer = Timer(remaining, () => signOut(reason: SignOutReason.sessionExpired));
  }

  /// Ends the session and wipes everything tied to it: the token, the cached
  /// user and venue list, the selected venue and the venue read cache. The
  /// customer wallet and preferences are untouched — they belong to the
  /// phone, not the login.
  Future<void> signOut({SignOutReason reason = SignOutReason.user}) async {
    _expiryTimer?.cancel();
    if (reason == SignOutReason.user) {
      await ref.read(authRepositoryProvider).signOut();
    }
    ref.read(currentTokenProvider.notifier).set(null);
    await _secure.clearSession();
    await ref.read(localStoreProvider).clearVenueCache();
    await ref.read(prefsProvider).setString(Prefs.keySelectedVenue, null);
    ref.read(appModeControllerProvider.notifier).set(AppMode.customer);
    state = AuthState.signedOut(reason: reason);
  }
}
