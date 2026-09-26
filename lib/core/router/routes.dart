/// Route paths. Kept as constants so screens, guards, and the deep-link
/// handler never disagree about where things live. Mirrors the design canvas:
/// customer boards C1–C12 under `/c`, venue boards V1–V14 + Manage under `/v`,
/// onboarding O0–O7 under `/onboarding`.
abstract final class Routes {
  // ---- auth ----------------------------------------------------------------
  static const login = '/auth/login';
  static const forgot = '/auth/forgot';

  /// The reset screen's path on its own, for the redirect rules.
  static const resetPasswordPath = '/auth/reset';

  /// The address travels with the code: a reset for an address you did not
  /// type is not a reset.
  static String resetPassword(String email) =>
      '$resetPasswordPath?email=${Uri.encodeQueryComponent(email)}';

  // ---- onboarding (venue owners) ------------------------------------------
  static const welcome = '/onboarding';
  static const signup = '/onboarding/signup';
  static const verify = '/onboarding/verify';
  static const createVenue = '/onboarding/venue';
  static const firstSpace = '/onboarding/space';
  static const hours = '/onboarding/hours';
  static const policy = '/onboarding/policy';
  static const live = '/onboarding/live';

  // ---- customer shell ------------------------------------------------------
  static const customerFind = '/c/find';
  static const customerBookings = '/c/bookings';
  static const customerAccount = '/c/account';

  /// Public venue pages nest under Find so a declarative `go` (deep links)
  /// builds the full back stack.
  static const scan = '/c/find/scan';
  static String venue(String slug) => '$customerFind/venues/$slug';
  static String space(String slug, String spaceId, {String? date}) =>
      '$customerFind/venues/$slug/spaces/$spaceId${date == null ? '' : '?date=$date'}';
  static String book(String slug) => '$customerFind/venues/$slug/book';
  static String booking(String slug, String token) => '$customerBookings/$slug/$token';
  static String reschedule(String slug, String token) =>
      '$customerBookings/$slug/$token/reschedule';
  static String importBooking(String slug, String token) =>
      '$customerBookings/import?slug=$slug&token=$token';

  // ---- venue shell ---------------------------------------------------------
  static const venueToday = '/v/today';
  static const venueCalendar = '/v/calendar';
  static const venueCustomers = '/v/customers';
  static const venueMore = '/v/more';

  static const venuePicker = '/v/venues';
  static String customer(String id) => '$venueCustomers/$id';
  static const venueWaitlist = '/v/more/waitlist';
  static const venueSpaces = '/v/more/spaces';
  static String spaceEdit(String id) => '/v/more/spaces/$id';
  static const venueSettings = '/v/more/settings';
  static const venueTeam = '/v/more/team';
  static const venueBilling = '/v/more/billing';
  static const venueInsights = '/v/more/insights';
  static const ownerAccount = '/v/more/account';
  static const venueMemberships = '/v/more/memberships';
  static const venueMarketing = '/v/more/marketing';
  static const venueIntegrations = '/v/more/integrations';
  static const venueExport = '/v/more/export';

  // ---- platform admin (outside both shells) -------------------------------
  /// Its own stack rather than a venue tab: a platform admin need not belong
  /// to any venue, and the console is about all of them.
  static const admin = '/admin';
  static const adminTenants = '/admin/tenants';
  static String adminTenant(String orgId) => '/admin/tenants/$orgId';
  static const adminPayments = '/admin/payments';
  static const adminAudit = '/admin/audit';
  static const adminAdmins = '/admin/admins';
  static const adminInstapay = '/admin/instapay';
}
