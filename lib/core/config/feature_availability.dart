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

  /// Memberships, promo codes, the review link and loyalty rules,
  /// integrations and CSV export (#42–#47) — what only the web dashboard did.
  growth,
}

/// Flip an entry to `true` when the corresponding contract items land on the
/// real server. Kept as a plain map so the change is a one-line diff.
///
/// **Every row of the contract is live as of 2026-09-26** — the venue side
/// first (auth, onboarding, the desk, the calendar, customers, the waitlist,
/// the space editor, settings, team, billing, insights), then the public
/// booking loop. Each row shipped the same way: endpoints, then the flag, then
/// a walk on a device against the real database.
///
/// The map is kept rather than deleted. It is what the next unshipped endpoint
/// gets added to, and every `Real*` repository still asks it before it calls,
/// so a row that is postponed or pulled refuses in one place with a 501 the UI
/// can explain — instead of 404ing on somebody's phone.
const Map<Feature, bool> _shippedOnRealServer = {
  Feature.customerBrowse: true, // #1, #2 — live
  Feature.customerBooking: true, // #3, #4 — live
  Feature.manageBooking: true, // #5, #6 — live
  Feature.reschedule: true, // #7, #8 — live
  Feature.waitlist: true, // #9 — live
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
  Feature.growth: true, // #42–#47 — live
};

bool isAvailable(Feature feature, ApiMode mode) => switch (mode) {
      ApiMode.fake => true,
      ApiMode.real => _shippedOnRealServer[feature] ?? false,
    };
