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
@DriftDatabase(tables: [WalletBookings, RecentVenues, VenueCache])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  /// The app's persistent database under the platform's app-data directory.
  AppDatabase.open() : super(driftDatabase(name: 'reservme'));

  @override
  int get schemaVersion => 2;

  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);

  /// 1 → 2 added `venue_cache`. The cache is a copy of something the server
  /// still has, so an upgrade recreates it empty rather than migrating it;
  /// the wallet, which is not recoverable from anywhere else, is left alone.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.deleteTable(venueCache.actualTableName);
            await m.createTable(venueCache);
          }
        },
      );

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

  // ---- venue cache --------------------------------------------------------

  Future<VenueCacheRow?> readVenueCache(String venueSlug, String key) =>
      (select(venueCache)
            ..where((t) => t.venueSlug.equals(venueSlug) & t.key.equals(key)))
          .getSingleOrNull();

  Future<void> saveVenueCache(VenueCacheCompanion entry) =>
      into(venueCache).insertOnConflictUpdate(entry);

  /// Sign-out and venue switches drop it: it is someone's customer data.
  Future<void> clearVenueCache([String? venueSlug]) => venueSlug == null
      ? delete(venueCache).go()
      : (delete(venueCache)..where((t) => t.venueSlug.equals(venueSlug))).go();

  /// "Delete everything on this phone" on the Account screen.
  Future<void> wipe() async {
    await delete(walletBookings).go();
    await delete(recentVenues).go();
    await delete(venueCache).go();
  }
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase.open();
  ref.onDispose(db.close);
  return db;
}
