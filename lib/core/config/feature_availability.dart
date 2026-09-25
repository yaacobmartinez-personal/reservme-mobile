import 'app_config.dart';

/// Features whose backend endpoints do not exist yet (see docs/API-CONTRACT.md).
///
/// In [ApiMode.fake] everything is available. In [ApiMode.real] a feature is
/// available only once its endpoints ship; until then the UI hides the entry
/// point so a build against today's server never shows a dead button.
enum Feature {
  /// Public venue page + availability (#1, #2).
  customerBrowse,

  /// Creating a booking or a session seat (#3, #4).
  customerBooking,

  /// Reading / cancelling a booking by manage token (#5, #6).
  manageBooking,

  /// Reschedule options + move (#7, #8).
  reschedule,

  /// Customer waitlist (#9).
  waitlist,

  /// Staff login, forgot password, /me (#10–#13).
  venueLogin,

  /// Run sheet + booking actions (#14, #15).
  today,

  /// Day calendar, manual booking, move, block (#16–#19).
  calendar,

  /// Customers list/detail/notes/tags (#20–#22).
  customers,

  /// Venue-side waitlist (#23).
  venueWaitlist,

  /// Spaces list + active toggle (#24).
  spaces,

  /// Sign-up, verification, in-app reset (#25, #26).
  signup,

  /// Create venue + space/hours/pricing/closures/sessions editors (#27–#29).
  onboarding,

  /// Venue settings + branding (#30).
  venueSettings,

  /// Team invites and roles (#31).
  team,

  /// Billing status + proof upload (#32).
  billing,

  /// Insights (#33).
  insights,

  /// Delete account (#34).
  deleteAccount,
}

/// Flip an entry to `true` when the corresponding contract items land on the
/// real server. Kept as a plain map so the change is a one-line diff.
///
/// Auth shipped on 2026-09-25 (Better Auth bearer + email OTP, walked against
/// the real database by `npm run test:mobile-auth` in the web repo). Everything
/// else is still a separate plan.
///
/// `signup` stays false on purpose even though #25 and #26 are live: the
/// sign-up screen leads straight into "name your venue", which is #27 and does
/// not exist. Opening it would walk a new owner into a wall.
const Map<Feature, bool> _shippedOnRealServer = {
  Feature.customerBrowse: false, // #1, #2
  Feature.customerBooking: false, // #3, #4
  Feature.manageBooking: false, // #5, #6
  Feature.reschedule: false, // #7, #8
  Feature.waitlist: false, // #9
  Feature.venueLogin: true, // #10–#13 — live
  Feature.today: false, // #14, #15
  Feature.calendar: false, // #16–#19
  Feature.customers: false, // #20–#22
  Feature.venueWaitlist: false, // #23
  Feature.spaces: false, // #24
  Feature.signup: false, // #25, #26
  Feature.onboarding: false, // #27–#29
  Feature.venueSettings: false, // #30
  Feature.team: false, // #31
  Feature.billing: false, // #32
  Feature.insights: false, // #33
  Feature.deleteAccount: true, // #34 — live
};

bool isAvailable(Feature feature, ApiMode mode) => switch (mode) {
      ApiMode.fake => true,
      ApiMode.real => _shippedOnRealServer[feature] ?? false,
    };
