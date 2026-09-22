import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/api_mode.dart';
import '../../../core/config/app_config.dart';
import '../../../core/fake/fake_providers.dart';
import '../../../core/fake/seed.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/token_codec.dart';
import '../../../core/network/unauthorized_events.dart';
import '../../../core/storage/boot_data.dart';
import '../../../core/storage/prefs.dart';
import '../../../core/storage/secure_store.dart';
import '../../../core/time/clock.dart';
import '../../shell/application/app_mode_controller.dart';
import '../../venue/venues/domain/venue_membership.dart';
import '../domain/user.dart';
import 'auth_state.dart';

part 'auth_controller.g.dart';

/// The venue-staff session. Phase 0 restores a persisted session and signs
/// out; sign-in, `/me` refresh and expiry timers arrive with Phase 2 (the
/// login flow) — the shape is fixed here so the router and shells are final.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    final events = ref.watch(unauthorizedEventsProvider);
    final sub = events.stream.listen((_) {
      if (state.isSignedIn) signOut(reason: SignOutReason.sessionExpired);
    });
    ref.onDispose(sub.cancel);

    final boot = ref.watch(bootDataProvider);
    final token = boot.token;
    final user = boot.user;
    if (token == null || user == null) return const AuthState.signedOut();
    final expiry = TokenCodec.expiry(token);
    final now = ref.read(clockProvider)();
    if (expiry == null || !expiry.isAfter(now)) {
      return const AuthState.signedOut(reason: SignOutReason.sessionExpired);
    }
    return AuthState.signedIn(
      user: user,
      token: token,
      expiresAt: expiry,
      venues: boot.venues,
    );
  }

  SecureStore get _secure => ref.read(secureStoreProvider);

  /// Establish a session from a login result and persist it.
  Future<void> establish({
    required User user,
    required String token,
    required List<VenueMembership> venues,
  }) async {
    final expiresAt = TokenCodec.expiry(token) ?? ref.read(clockProvider)().add(const Duration(days: 30));
    ref.read(currentTokenProvider.notifier).set(token);
    await _secure.write(SecureStore.keyToken, token);
    await _secure.writeJson(SecureStore.keyUser, user.toJson());
    await _secure.writeJson(SecureStore.keyVenues, venues.map((v) => v.toJson()).toList());
    state = AuthState.signedIn(user: user, token: token, expiresAt: expiresAt, venues: venues, venuesFresh: true);
  }

  /// Fake mode only: sign in as the seeded venue owner without the login
  /// screen, so the venue shell can be exercised before Phase 2. Refused in
  /// real mode.
  Future<void> devSignInAsDemo() async {
    if (ref.read(apiModeProvider) != ApiMode.fake) return;
    final store = ref.read(fakeStoreProvider);
    final owner = store.userByEmail(FakeAccounts.ownerEmail)!;
    final venues = [
      for (final m in store.membershipsOf(owner.id))
        if (store.venueById(m.venueId) case final v?)
          VenueMembership(
            orgId: v.id,
            slug: v.slug,
            name: v.name,
            role: m.role,
            timezone: v.timezone,
            currency: v.currency,
            theme: v.theme,
            suspended: v.suspended,
            activeSpaces: store.spacesOf(v.id, activeOnly: true).length,
          ),
    ];
    final token = TokenCodec.mintFake(owner.id, ref.read(clockProvider)().add(const Duration(days: 30)));
    await establish(
      user: User(id: owner.id, email: owner.email, name: owner.name, emailVerified: owner.emailVerified),
      token: token,
      venues: venues,
    );
  }

  /// Ends the session and wipes everything tied to it. The customer wallet
  /// and preferences are untouched — they belong to the phone, not the login.
  Future<void> signOut({SignOutReason reason = SignOutReason.user}) async {
    ref.read(currentTokenProvider.notifier).set(null);
    await _secure.clearSession();
    await ref.read(prefsProvider).setString(Prefs.keySelectedVenue, null);
    ref.read(appModeControllerProvider.notifier).set(AppMode.customer);
    state = AuthState.signedOut(reason: reason);
  }
}
