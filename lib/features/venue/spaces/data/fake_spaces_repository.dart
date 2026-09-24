import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/clock.dart';
import '../domain/space_summary.dart';

/// In-memory [SpacesRepository], including the web's `setSpaceActive`
/// permission check: day-to-day staff run the desk, but taking a space off
/// sale changes what the venue is billed for, so it is owner/admin only.
class FakeSpacesRepository implements SpacesRepository {
  FakeSpacesRepository(
    this._store,
    this._latency,
    this._clock,
    this._offline,
    this._roleFor,
  );

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;

  /// The signed-in user's role at this venue, or null when they have none.
  final VenueRole? Function(String venueSlug) _roleFor;

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  FakeVenue _venue(String slug) {
    final v = _store.venueBySlug(slug);
    if (v == null) throw ApiError(404, 'We could not find that venue.');
    return v;
  }

  @override
  Future<List<SpaceSummary>> list(String venueSlug) async {
    await _tick();
    final venue = _venue(venueSlug);
    final now = _clock();

    return [
      for (final s in _store.spacesOf(venue.id))
        SpaceSummary(
          id: s.id,
          name: s.name,
          kind: s.kind,
          slotMinutes: s.slotMinutes,
          priceCents: s.priceCents,
          peakPriceCents: _store
              .rulesOf(s.id)
              .map((r) => r.priceCents)
              .fold<int?>(null, (a, b) => a == null || b > a ? b : a),
          isActive: s.isActive,
          imageUrl: s.imageUrl,
          sessionSummary: _sessions(venue, s),
          upcomingBookings: _store
              .reservationsOf(venue.id)
              .where((r) =>
                  r.spaceId == s.id && r.status.isLive && r.startsAt.isAfter(now))
              .length,
        ),
    ];
  }

  @override
  Future<SpaceSummary> setActive(
    String venueSlug,
    String spaceId,
    bool active,
  ) async {
    await _tick();
    final venue = _venue(venueSlug);
    final role = _roleFor(venueSlug);
    if (role == null || !role.atLeast(VenueRole.admin)) {
      throw ApiError(403, 'Only an owner or admin can change what is on sale.');
    }

    final space = _store.spaceById(spaceId);
    if (space == null || space.venueId != venue.id) {
      throw ApiError(404, 'That space no longer exists.');
    }
    space.isActive = active;
    return (await list(venueSlug)).firstWhere((s) => s.id == spaceId);
  }

  /// "open play Tue/Thu", built from the sessions this space runs.
  String? _sessions(FakeVenue venue, FakeSpace space) {
    const names = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final days = <int>{};
    for (final s in _store.sessionsOf(venue.id)) {
      if (s.spaceId != space.id) continue;
      days.add(s.startsAt.weekday % 7);
    }
    if (days.isEmpty) return null;
    final sorted = days.toList()..sort();
    return 'open play ${sorted.map((d) => names[d]).join('/')}';
  }
}
