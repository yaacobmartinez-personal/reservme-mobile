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
/// The whole venue side is live as of 2026-09-25: the four tabs, onboarding,
/// settings, and the space editor. `spaces` was the last to move, because one
/// flag gates every method on `RealSpacesRepository` — turning it on before
/// #29 existed would have opened the editor with two buttons that refuse,
/// which is the same wall the sign-up flow used to walk into.
///
/// The venue side is complete as of 2026-09-26 — every flag below it is true.
/// What is still false is the customer half, #1–#9: the public booking loop,
/// which is the part a member of the public touches rather than a member of
/// staff.
const Map<Feature, bool> _shippedOnRealServer = {
  Feature.customerBrowse: false, // #1, #2
  Feature.customerBooking: false, // #3, #4
  Feature.manageBooking: false, // #5, #6
  Feature.reschedule: false, // #7, #8
  Feature.waitlist: false, // #9
  Feature.venueLogin: true, // #10–#13 — live
  Feature.today: true, // #14, #15 — live
  Feature.calendar: true, // #16–#19 — live
  Feature.customers: true, // #20–#22 — live
  Feature.venueWaitlist: true, // #23 — live
  Feature.spaces: true, // #24, #28, #29 — live
  Feature.signup: true, // #25, #26 — live
  Feature.onboarding: true, // #27, #28 — live
  Feature.venueSettings: true, // #30 — live
  Feature.team: true, // #31 — live
  Feature.billing: true, // #32 — live
  Feature.insights: true, // #33 — live
  Feature.deleteAccount: true, // #34 — live
};

bool isAvailable(Feature feature, ApiMode mode) => switch (mode) {
      ApiMode.fake => true,
      ApiMode.real => _shippedOnRealServer[feature] ?? false,
    };
