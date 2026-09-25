import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/model/enums.dart';
import 'package:reservme/core/router/app_router.dart';
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

  String? go(
    String path,
    AuthState auth, {
    AppMode mode = AppMode.customer,
    String? selected,
    bool canOnboard = true,
  }) =>
      computeRedirect(
        uri: Uri.parse(path),
        auth: auth,
        mode: mode,
        canOnboard: canOnboard,
        selectedVenueSlug: selected,
      );

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

  group('signing in with no venue', () {
    // Found on a device against the real server: login succeeded, /me came
    // back with no venues, and the app opened "Name your venue" — whose only
    // button answers "Not available on this server yet", because creating a
    // venue is contract #27 and has not shipped. The gate caught the tap; the
    // routing should never have gone there.
    test('goes to onboarding when this server can create venues', () {
      expect(go('/v/today', noVenue, mode: AppMode.venue), Routes.createVenue);
      expect(
        afterSignInTarget(from: null, auth: noVenue, canOnboard: true),
        Routes.createVenue,
      );
    });

    test('goes to the picker when it cannot', () {
      expect(
        go('/v/today', noVenue, mode: AppMode.venue, canOnboard: false),
        Routes.venuePicker,
      );
      expect(
        afterSignInTarget(from: null, auth: noVenue, canOnboard: false),
        Routes.venuePicker,
      );
    });

    test('and the picker itself is not bounced away, or it would loop', () {
      // The redirect has to let the destination through. Sending someone to a
      // route that redirects them again is a hang, not a screen.
      expect(
        go(Routes.venuePicker, noVenue, mode: AppMode.venue, canOnboard: false),
        anyOf(isNull, Routes.venuePicker),
      );
    });

    test('an owner with a venue is unaffected either way', () {
      for (final canOnboard in [true, false]) {
        expect(
          afterSignInTarget(from: null, auth: oneVenue, canOnboard: canOnboard),
          AppMode.venue.home,
        );
      }
    });
  });

  group('the reset screen', () {
    String? go(String location, AuthState auth) => computeRedirect(
          uri: Uri.parse(location),
          auth: auth,
          mode: AppMode.venue,
          canOnboard: true,
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

  group('where the app opens', () {
    test('a brand-new install is pitched to, not dropped on Find', () {
      // O0 is the front door for an owner, and the only screen where the two
      // audiences meet. Nothing else in the app navigates to it, so if the
      // first location skips it, it is unreachable.
      expect(
        firstLocation(
          auth: const AuthState.signedOut(),
          mode: AppMode.customer,
          welcomeSeen: false,
        ),
        Routes.welcome,
      );
    });

    test('once it has been seen, the app opens where you left off', () {
      expect(
        firstLocation(
          auth: const AuthState.signedOut(),
          mode: AppMode.customer,
          welcomeSeen: true,
        ),
        AppMode.customer.home,
      );
    });

    test('signed-in staff go to their desk, seen or not', () {
      for (final seen in [true, false]) {
        expect(
          firstLocation(auth: oneVenue, mode: AppMode.venue, welcomeSeen: seen),
          AppMode.venue.home,
          reason: 'welcomeSeen: $seen',
        );
      }
    });

    test('a signed-in customer-mode session still gets the customer home', () {
      expect(
        firstLocation(auth: oneVenue, mode: AppMode.customer, welcomeSeen: true),
        AppMode.customer.home,
      );
    });
  });
}
