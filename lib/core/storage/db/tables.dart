import 'package:drift/drift.dart';

/// Bookings kept on this phone. There is no customer account, so this table
/// *is* the customer's booking history: one row per manage token, written
/// when a booking is made in the app or imported from a manage link.
///
/// The token is the capability — the same secret that is in the confirmation
/// email. It lives in app-private storage with Android backup disabled.
@DataClassName('WalletRow')
class WalletBookings extends Table {
  TextColumn get venueSlug => text()();
  TextColumn get manageToken => text()();

  TextColumn get reference => text()();
  TextColumn get venueName => text()();
  TextColumn get venueTheme => text().withDefault(const Constant('pine'))();
  TextColumn get spaceName => text()();
  TextColumn get timezone => text().withDefault(const Constant('Asia/Manila'))();
  TextColumn get currency => text().withDefault(const Constant('PHP'))();
  DateTimeColumn get startsAt => dateTime()();
  DateTimeColumn get endsAt => dateTime()();
  IntColumn get amountCents => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('confirmed'))();

  /// The whole [Booking] as JSON, so the detail screen renders offline
  /// exactly as it did online.
  TextColumn get snapshot => text()();
  DateTimeColumn get lastSyncedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {venueSlug, manageToken};
}

/// Venues the customer has opened, newest first — the "Recent venues" list on
/// Find. Purely local; opening a venue page is not something the server sees.
@DataClassName('RecentVenueRow')
class RecentVenues extends Table {
  TextColumn get slug => text()();
  TextColumn get name => text()();
  TextColumn get theme => text().withDefault(const Constant('pine'))();
  TextColumn get tagline => text().nullable()();
  TextColumn get coverUrl => text().nullable()();
  DateTimeColumn get openedAt => dateTime()();

  /// Set when the customer has actually booked here, so the card can say so.
  DateTimeColumn get lastBookedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {slug};
}

/// A venue screen's last successful response, so staff still see the run
/// sheet when the desk's wifi drops. Disposable: wiped on sign-out and on a
/// venue switch, and dropped outright on a schema bump.
@DataClassName('VenueCacheRow')
class VenueCache extends Table {
  TextColumn get venueSlug => text()();

  /// Which screen: "today", later `calendar:<date>`, "customers".
  TextColumn get key => text()();

  /// The response as JSON, exactly as the screen would have rendered it.
  TextColumn get payload => text()();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {venueSlug, key};
}
