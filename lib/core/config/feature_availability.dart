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
/// Two that look like they should have moved and have not:
///
/// - `spaces` gates every method on `RealSpacesRepository`, including pricing
///   rules and closures — which are #29 and do not exist. Turning it on would
///   open the space editor with two buttons that refuse, which is the same
///   wall the sign-up flow used to walk into.
/// - `today` is the screen O7 hands the new owner to. It is #14 and still to
///   come, so finishing onboarding on a real server lands on a run sheet that
///   says it is not available yet. That is legible rather than broken, and it
///   is the next thing to fix.
const Map<Feature, bool> _shippedOnRealServer = {
  Feature.customerBrowse: false, // #1, #2
  Feature.customerBooking: false, // #3, #4
  Feature.manageBooking: false, // #5, #6
  Feature.reschedule: false, // #7, #8
  Feature.waitlist: false, // #9
  Feature.venueLogin: true, // #10–#13 — live
  Feature.today: true, // #14, #15 — live
  Feature.calendar: false, // #16–#19
  Feature.customers: false, // #20–#22
  Feature.venueWaitlist: false, // #23
  Feature.spaces: false, // #24
  Feature.signup: true, // #25, #26 — live
  Feature.onboarding: true, // #27, #28 — live (#29 is not, see below)
  Feature.venueSettings: true, // #30 — live
  Feature.team: false, // #31
  Feature.billing: false, // #32
  Feature.insights: false, // #33
  Feature.deleteAccount: true, // #34 — live
};

bool isAvailable(Feature feature, ApiMode mode) => switch (mode) {
      ApiMode.fake => true,
      ApiMode.real => _shippedOnRealServer[feature] ?? false,
    };
