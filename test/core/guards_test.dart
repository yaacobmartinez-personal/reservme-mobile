import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/router/guards.dart';
import 'package:reservme/core/router/routes.dart';
import 'package:reservme/features/auth/application/auth_state.dart';
import 'package:reservme/features/auth/domain/user.dart';
import 'package:reservme/features/shell/application/app_mode_controller.dart';
import 'package:reservme/features/venue/venues/domain/venue_membership.dart';

void main() {
  const user = User(id: 'u_1', email: 'owner@reservme.test');
  final expiry = DateTime.utc(2027);
  const katipunan = VenueMembership(orgId: 'v_1', slug: 'katipunan', name: 'Katipunan Courts', role: VenueRole.owner);
  const norte = VenueMembership(orgId: 'v_2', slug: 'studio-norte', name: 'Studio Norte', role: VenueRole.owner);

  final signedOut = const AuthState.signedOut();
  final signedOutByUser = const AuthState.signedOut(reason: SignOutReason.user);
  final expired = const AuthState.signedOut(reason: SignOutReason.sessionExpired);
  final oneVenue = AuthState.signedIn(user: user, token: 't', expiresAt: expiry, venues: const [katipunan]);
  final twoVenues = AuthState.signedIn(user: user, token: 't', expiresAt: expiry, venues: const [katipunan, norte]);
  final noVenue = AuthState.signedIn(user: user, token: 't', expiresAt: expiry);

  String? go(String path, AuthState auth, {AppMode mode = AppMode.customer, String? selected}) =>
      computeRedirect(uri: Uri.parse(path), auth: auth, mode: mode, selectedVenueSlug: selected);

  test('customer routes are public', () {
    expect(go('/c/find', signedOut), isNull);
    expect(go('/c/find/venues/katipunan', signedOut), isNull);
    expect(go('/c/bookings/katipunan/tok', signedOut), isNull);
    expect(go('/c/account', signedOut), isNull);
  });

  test('venue routes need a session', () {
    // Never signed in, or expired: go to login and come back here.
    expect(go('/v/today', signedOut), '${Routes.login}?from=%2Fv%2Ftoday');
    expect(go('/v/today', expired), '${Routes.login}?from=%2Fv%2Ftoday');
    // A deliberate sign-out lands on the customer home instead.
    expect(go('/v/today', signedOutByUser), AppMode.customer.home);
  });

  test('venue routes need a membership; none sends you to venue setup', () {
    expect(go('/v/today', noVenue), Routes.createVenue);
  });

  test('one venue auto-selects; several need the picker', () {
    expect(go('/v/today', oneVenue, selected: 'katipunan'), isNull);
    expect(go('/v/today', twoVenues), Routes.venuePicker);
    expect(go('/v/today', twoVenues, selected: 'studio-norte'), isNull);
    expect(go(Routes.venuePicker, twoVenues), isNull);
  });

  test('auth screens bounce a signed-in person', () {
    expect(go(Routes.login, oneVenue), AppMode.venue.home);
    expect(go('${Routes.login}?from=%2Fv%2Fcalendar', oneVenue), '/v/calendar');
    expect(go('${Routes.login}?from=%2Fc%2Ffind', oneVenue), AppMode.venue.home);
    expect(go(Routes.login, noVenue), Routes.createVenue);
    expect(go(Routes.login, signedOut), isNull);
  });

  test('onboarding: welcome and sign-up are public, later steps need a session', () {
    expect(go(Routes.welcome, signedOut), isNull);
    expect(go(Routes.signup, signedOut), isNull);
    expect(go(Routes.verify, signedOut), isNull);
    expect(go(Routes.createVenue, signedOut), '${Routes.login}?from=%2Fonboarding%2Fvenue');
    expect(go(Routes.createVenue, noVenue), isNull);
    expect(go(Routes.firstSpace, oneVenue), isNull);
  });

  test('safeFrom only honours in-app, non-auth paths', () {
    expect(safeFrom('/v/today'), '/v/today');
    expect(safeFrom('//evil.example'), isNull);
    expect(safeFrom('https://evil.example'), isNull);
    expect(safeFrom('/auth/login'), isNull);
    expect(safeFrom(null), isNull);
  });

  group('the reset screen', () {
    String? go(String location, AuthState auth) => computeRedirect(
          uri: Uri.parse(location),
          auth: auth,
          mode: AppMode.venue,
          selectedVenueSlug: katipunan.slug,
        );

    test('is reachable while signed in, unlike the rest of /auth', () {
      // Changing your password from the account screen goes here with a
      // session in hand; bouncing it would make that button do nothing.
      expect(go('/auth/reset?email=a%40b.co', oneVenue), isNull);
      expect(go('/auth/login', oneVenue), isNotNull);
      expect(go('/auth/forgot', oneVenue), isNotNull);
    });

    test('is reachable signed out too, which is where a reset starts', () {
      expect(go('/auth/reset?email=a%40b.co', const AuthState.signedOut()), isNull);
    });
  });
}
