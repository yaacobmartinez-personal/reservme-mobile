import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/customer/booking/domain/booking.dart';
import '../../features/customer/venues/domain/recent_venue.dart';
import '../model/enums.dart';
import 'db/app_database.dart';

part 'local_store.g.dart';

/// Everything this phone remembers for the customer side: the booking wallet
/// and the venues they have opened.
///
/// It is an interface rather than the drift database directly for two
/// reasons: no feature should import drift types (the layering rule in
/// docs/ARCHITECTURE.md), and tests get an in-memory implementation without
/// needing a real SQLite library on the host.
abstract class LocalStore {
  // ---- wallet -------------------------------------------------------------

  Stream<List<Booking>> watchWallet();
  Stream<Booking?> watchBooking(String venueSlug, String token);
  Future<Booking?> readBooking(String venueSlug, String token);

  /// Insert or refresh. A booking without a `manageToken` is not saved —
  /// without it there is no way back to the booking.
  Future<void> saveBooking(Booking booking, {required DateTime now});
  Future<void> removeBooking(String venueSlug, String token);

  /// When the row was last refreshed from the server, for the stale hint.
  Future<DateTime?> lastSyncedAt(String venueSlug, String token);

  // ---- recent venues ------------------------------------------------------

  Stream<List<RecentVenue>> watchRecentVenues();
  Future<void> touchVenue(RecentVenue venue);
  Future<void> markVenueBooked(String slug, DateTime at);

  // ---- venue read cache ---------------------------------------------------

  /// The last successful response for a venue screen, with the time it was
  /// fetched, or null when there is nothing cached.
  Future<CachedPayload?> readVenueCache(String venueSlug, String key);

  Future<void> saveVenueCache(
    String venueSlug,
    String key,
    Map<String, dynamic> payload, {
    required DateTime now,
  });

  /// Dropped on sign-out and on a venue switch: it is someone's customer data.
  Future<void> clearVenueCache([String? venueSlug]);

  /// "Delete everything on this phone".
  Future<void> wipe();
}

/// A cached response plus when it was taken, so a screen can say how stale it is.
class CachedPayload {
  const CachedPayload({required this.payload, required this.fetchedAt});

  final Map<String, dynamic> payload;
  final DateTime fetchedAt;
}

/// The drift-backed implementation used by the app.
class DriftLocalStore implements LocalStore {
  const DriftLocalStore(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Booking>> watchWallet() =>
      _db.watchWallet().map((rows) => rows.map(_decode).nonNulls.toList(growable: false));

  @override
  Stream<Booking?> watchBooking(String venueSlug, String token) => _db
      .watchWalletEntry(venueSlug, token)
      .map((row) => row == null ? null : _decode(row));

  @override
  Future<Booking?> readBooking(String venueSlug, String token) async {
    final row = await _db.walletEntry(venueSlug, token);
    return row == null ? null : _decode(row);
  }

  @override
  Future<void> saveBooking(Booking booking, {required DateTime now}) async {
    final token = booking.manageToken;
    if (token == null || token.isEmpty) return;
    await _db.saveWalletEntry(
      WalletBookingsCompanion.insert(
        venueSlug: booking.venue.slug,
        manageToken: token,
        reference: booking.reference,
        venueName: booking.venue.name,
        venueTheme: Value(booking.venue.theme.wire),
        spaceName: booking.space.name,
        timezone: Value(booking.venue.timezone),
        currency: Value(booking.venue.currency),
        startsAt: booking.startsAt,
        endsAt: booking.endsAt,
        amountCents: Value(booking.amountCents),
        status: Value(booking.status.wire),
        snapshot: jsonEncode(booking.toJson()),
        lastSyncedAt: now,
      ),
    );
  }

  @override
  Future<void> removeBooking(String venueSlug, String token) =>
      _db.removeWalletEntry(venueSlug, token);

  @override
  Future<DateTime?> lastSyncedAt(String venueSlug, String token) async =>
      (await _db.walletEntry(venueSlug, token))?.lastSyncedAt;

  @override
  Stream<List<RecentVenue>> watchRecentVenues() =>
      _db.watchRecentVenues().map((rows) => [
            for (final r in rows)
              RecentVenue(
                slug: r.slug,
                name: r.name,
                theme: VenueTheme.fromWire(r.theme),
                openedAt: r.openedAt,
                tagline: r.tagline,
                coverUrl: r.coverUrl,
                lastBookedAt: r.lastBookedAt,
              ),
          ]);

  @override
  Future<void> touchVenue(RecentVenue venue) => _db.touchVenue(
        RecentVenuesCompanion.insert(
          slug: venue.slug,
          name: venue.name,
          theme: Value(venue.theme.wire),
          tagline: Value(venue.tagline),
          coverUrl: Value(venue.coverUrl),
          openedAt: venue.openedAt,
        ),
      );

  @override
  Future<void> markVenueBooked(String slug, DateTime at) =>
      _db.markVenueBooked(slug, at);

  @override
  Future<CachedPayload?> readVenueCache(String venueSlug, String key) async {
    final row = await _db.readVenueCache(venueSlug, key);
    if (row == null) return null;
    try {
      final json = jsonDecode(row.payload);
      if (json is! Map<String, dynamic>) return null;
      return CachedPayload(payload: json, fetchedAt: row.fetchedAt);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveVenueCache(
    String venueSlug,
    String key,
    Map<String, dynamic> payload, {
    required DateTime now,
  }) =>
      _db.saveVenueCache(
        VenueCacheCompanion.insert(
          venueSlug: venueSlug,
          key: key,
          payload: jsonEncode(payload),
          fetchedAt: now,
        ),
      );

  @override
  Future<void> clearVenueCache([String? venueSlug]) => _db.clearVenueCache(venueSlug);

  @override
  Future<void> wipe() => _db.wipe();

  /// The snapshot is the source of truth; the columns are a fallback for a
  /// row written by an older build.
  Booking? _decode(WalletRow row) {
    try {
      final json = jsonDecode(row.snapshot);
      if (json is! Map<String, dynamic>) return null;
      return Booking.fromJson(json);
    } catch (_) {
      return Booking(
        reference: row.reference,
        venue: BookingVenue(
          slug: row.venueSlug,
          name: row.venueName,
          theme: VenueTheme.fromWire(row.venueTheme),
          timezone: row.timezone,
          currency: row.currency,
        ),
        space: BookingSpace(id: '', name: row.spaceName),
        startsAt: row.startsAt,
        endsAt: row.endsAt,
        whenLabel: '',
        amountCents: row.amountCents,
        status: ReservationStatus.fromWire(row.status),
        manageToken: row.manageToken,
      );
    }
  }
}

@Riverpod(keepAlive: true)
LocalStore localStore(Ref ref) => DriftLocalStore(ref.watch(appDatabaseProvider));
