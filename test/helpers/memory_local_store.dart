import 'dart:async';

import 'package:reservme/core/storage/local_store.dart';
import 'package:reservme/features/customer/booking/domain/booking.dart';
import 'package:reservme/features/customer/venues/domain/recent_venue.dart';

/// [LocalStore] without SQLite, so widget and controller tests never touch
/// the platform database. Behaves like the drift one: keyed by
/// `(venueSlug, manageToken)`, wallet sorted by start time, recents newest
/// first.
class MemoryLocalStore implements LocalStore {
  final _bookings = <String, Booking>{};
  final _syncedAt = <String, DateTime>{};
  final _venues = <String, RecentVenue>{};

  final _walletChanges = StreamController<void>.broadcast();
  final _venueChanges = StreamController<void>.broadcast();

  String _key(String slug, String token) => '$slug/$token';

  List<Booking> get _sortedWallet {
    final all = _bookings.values.toList()
      ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    return List.unmodifiable(all);
  }

  List<RecentVenue> get _sortedVenues {
    final all = _venues.values.toList()
      ..sort((a, b) => b.openedAt.compareTo(a.openedAt));
    return List.unmodifiable(all);
  }

  @override
  Stream<List<Booking>> watchWallet() async* {
    yield _sortedWallet;
    yield* _walletChanges.stream.map((_) => _sortedWallet);
  }

  @override
  Stream<Booking?> watchBooking(String venueSlug, String token) async* {
    yield _bookings[_key(venueSlug, token)];
    yield* _walletChanges.stream.map((_) => _bookings[_key(venueSlug, token)]);
  }

  @override
  Future<Booking?> readBooking(String venueSlug, String token) async =>
      _bookings[_key(venueSlug, token)];

  @override
  Future<void> saveBooking(Booking booking, {required DateTime now}) async {
    final token = booking.manageToken;
    if (token == null || token.isEmpty) return;
    final key = _key(booking.venue.slug, token);
    _bookings[key] = booking;
    _syncedAt[key] = now;
    _walletChanges.add(null);
  }

  @override
  Future<void> removeBooking(String venueSlug, String token) async {
    _bookings.remove(_key(venueSlug, token));
    _syncedAt.remove(_key(venueSlug, token));
    _walletChanges.add(null);
  }

  @override
  Future<DateTime?> lastSyncedAt(String venueSlug, String token) async =>
      _syncedAt[_key(venueSlug, token)];

  @override
  Stream<List<RecentVenue>> watchRecentVenues() async* {
    yield _sortedVenues;
    yield* _venueChanges.stream.map((_) => _sortedVenues);
  }

  @override
  Future<void> touchVenue(RecentVenue venue) async {
    final existing = _venues[venue.slug];
    _venues[venue.slug] = RecentVenue(
      slug: venue.slug,
      name: venue.name,
      theme: venue.theme,
      openedAt: venue.openedAt,
      tagline: venue.tagline,
      coverUrl: venue.coverUrl,
      lastBookedAt: venue.lastBookedAt ?? existing?.lastBookedAt,
    );
    _venueChanges.add(null);
  }

  @override
  Future<void> markVenueBooked(String slug, DateTime at) async {
    final existing = _venues[slug];
    if (existing == null) return;
    _venues[slug] = RecentVenue(
      slug: existing.slug,
      name: existing.name,
      theme: existing.theme,
      openedAt: existing.openedAt,
      tagline: existing.tagline,
      coverUrl: existing.coverUrl,
      lastBookedAt: at,
    );
    _venueChanges.add(null);
  }

  @override
  Future<void> wipe() async {
    _bookings.clear();
    _syncedAt.clear();
    _venues.clear();
    _walletChanges.add(null);
    _venueChanges.add(null);
  }

  Future<void> dispose() async {
    await _walletChanges.close();
    await _venueChanges.close();
  }
}
