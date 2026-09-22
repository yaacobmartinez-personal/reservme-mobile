import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// The on-device database: the customer's booking wallet and recent venues.
///
/// Everything here is disposable in the sense that it belongs to this phone —
/// there is no account to sync it to. Losing it loses the shortcut, not the
/// bookings themselves (the venue still has them, and the confirmation email
/// still carries the manage link).
@DriftDatabase(tables: [WalletBookings, RecentVenues])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  /// The app's persistent database under the platform's app-data directory.
  AppDatabase.open() : super(driftDatabase(name: 'reservme'));

  @override
  int get schemaVersion => 1;

  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);

  // ---- wallet -------------------------------------------------------------

  /// Every saved booking, soonest upcoming first, past ones after.
  Stream<List<WalletRow>> watchWallet() =>
      (select(walletBookings)..orderBy([(t) => OrderingTerm.asc(t.startsAt)])).watch();

  Future<WalletRow?> walletEntry(String venueSlug, String token) =>
      (select(walletBookings)
            ..where((t) => t.venueSlug.equals(venueSlug) & t.manageToken.equals(token)))
          .getSingleOrNull();

  Stream<WalletRow?> watchWalletEntry(String venueSlug, String token) =>
      (select(walletBookings)
            ..where((t) => t.venueSlug.equals(venueSlug) & t.manageToken.equals(token)))
          .watchSingleOrNull();

  Future<void> saveWalletEntry(WalletBookingsCompanion entry) =>
      into(walletBookings).insertOnConflictUpdate(entry);

  Future<void> removeWalletEntry(String venueSlug, String token) =>
      (delete(walletBookings)
            ..where((t) => t.venueSlug.equals(venueSlug) & t.manageToken.equals(token)))
          .go();

  // ---- recent venues ------------------------------------------------------

  Stream<List<RecentVenueRow>> watchRecentVenues({int limit = 6}) =>
      (select(recentVenues)
            ..orderBy([(t) => OrderingTerm.desc(t.openedAt)])
            ..limit(limit))
          .watch();

  Future<void> touchVenue(RecentVenuesCompanion venue) =>
      into(recentVenues).insertOnConflictUpdate(venue);

  Future<void> markVenueBooked(String slug, DateTime at) =>
      (update(recentVenues)..where((t) => t.slug.equals(slug)))
          .write(RecentVenuesCompanion(lastBookedAt: Value(at)));

  Future<void> removeRecentVenue(String slug) =>
      (delete(recentVenues)..where((t) => t.slug.equals(slug))).go();

  /// "Delete everything on this phone" on the Account screen.
  Future<void> wipe() async {
    await delete(walletBookings).go();
    await delete(recentVenues).go();
  }
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase.open();
  ref.onDispose(db.close);
  return db;
}
