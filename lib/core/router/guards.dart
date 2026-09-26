import '../../features/auth/application/auth_state.dart';
import '../../features/shell/application/app_mode_controller.dart';
import 'routes.dart';

/// Pure redirect rules, kept free of Riverpod so they can be unit-tested.
/// Returns the location to send the person to, or null to let them through.
///
/// - Everything under `/c` is public: customers never sign in.
/// - Everything under `/v` needs a session with at least one venue
///   membership. A session that ended deliberately (sign out, delete) goes to
///   the customer home; one that expired goes to login and comes back here.
/// - `/v/*` with no selected venue: one membership auto-selects (handled by
///   the venue controller), several go to the picker.
/// - Auth screens bounce a signed-in person to `from` (or their shell home) —
///   except the reset screen, which is also how you change a password you
///   still know, from the account screen.
/// - Onboarding steps after sign-up need a session; the welcome and sign-up
///   screens do not.
/// - [canOnboard] is `Feature.onboarding` for the running API mode. Signing in
///   with no venue normally means "finish setting one up" — but against a
///   server that cannot create venues yet, that sends the owner to a form whose
///   only button refuses. They go to the picker and read why instead.
String? computeRedirect({
  required Uri uri,
  required AuthState auth,
  required AppMode mode,
  required bool canOnboard,
  String? selectedVenueSlug,
}) {
  final path = uri.path;
  final signedIn = auth.isSignedIn;

  if (path.startsWith('/auth/')) {
    // Changing your password is the reset flow with the address already
    // known, so a signed-in person belongs on this one.
    if (signedIn && path != Routes.resetPasswordPath) {
      return afterSignInTarget(
        from: uri.queryParameters['from'],
        auth: auth,
        canOnboard: canOnboard,
      );
    }
    return null;
  }

  if (!signedIn && requiresSession(path)) {
    final reason = auth is SignedOut ? auth.reason : null;
    final deliberate =
        reason == SignOutReason.user || reason == SignOutReason.accountDeleted;
    return deliberate ? AppMode.customer.home : loginFor(uri);
  }

  if (isAdminPath(path) && !auth.isPlatformAdmin) {
    // Not an admin (or not confirmed as one yet): somewhere they belong.
    return auth.hasVenueAccess ? AppMode.venue.home : AppMode.customer.home;
  }

  if (isVenuePath(path)) {
    if (!auth.hasVenueAccess) {
      // Signed in but no venue yet: finish setting one up, when this server
      // can. When it cannot, the picker says so — better than a form that
      // refuses on submit.
      return canOnboard ? Routes.createVenue : Routes.venuePicker;
    }
    if (path != Routes.venuePicker && selectedVenueSlug == null) {
      final venues = auth.venuesOrEmpty;
      if (venues.length > 1) return Routes.venuePicker;
    }
  }
  return null;
}

/// `/v` and everything under it.
bool isVenuePath(String path) => path == '/v' || path.startsWith('/v/');

/// The platform-admin console.
bool isAdminPath(String path) => path == Routes.admin || path.startsWith('${Routes.admin}/');

/// Onboarding steps that come after the account exists.
bool isPostSignupOnboarding(String path) =>
    path.startsWith('/onboarding/') &&
    path != Routes.signup &&
    path != Routes.verify;

bool requiresSession(String path) =>
    isVenuePath(path) || isAdminPath(path) || isPostSignupOnboarding(path);

/// The login route that returns to [uri] afterwards.
String loginFor(Uri uri) => '${Routes.login}?from=${Uri.encodeComponent(uri.toString())}';

/// Where to go once signed in: `from` if it is a safe in-app venue path,
/// else the venue home (that is what a staff login is for) — or venue setup
/// when the account has no venue yet.
String afterSignInTarget({
  required String? from,
  required AuthState auth,
  required bool canOnboard,
}) {
  final safe = safeFrom(from);
  if (safe != null && isAdminPath(safe) && auth.isPlatformAdmin) return safe;
  if (!auth.hasVenueAccess) {
    // A platform admin with no venue of their own is here to run the
    // platform, not to set up a court.
    if (auth.isPlatformAdmin) return Routes.admin;
    return canOnboard ? Routes.createVenue : Routes.venuePicker;
  }
  if (safe != null && (isVenuePath(safe) || safe.startsWith('/onboarding/'))) return safe;
  return AppMode.venue.home;
}

/// Only in-app paths are honoured, so a crafted link cannot bounce the app to
/// an arbitrary location.
String? safeFrom(String? from) {
  if (from == null || !from.startsWith('/') || from.startsWith('//')) return null;
  if (from.startsWith('/auth/')) return null;
  return from;
}
