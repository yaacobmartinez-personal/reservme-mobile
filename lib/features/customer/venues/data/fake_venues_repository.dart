import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../../booking/data/fake_availability.dart';
import '../domain/public_venue.dart';
import '../domain/venues_repository.dart';

/// In-memory [VenuesRepository] over the shared [FakeStore]. Mirrors the web
/// `getVenueBySlug` + `getVenueSpaces`: only active spaces, and a suspended
/// venue still resolves (its page says it is not taking bookings).
class FakeVenuesRepository implements VenuesRepository {
  FakeVenuesRepository(this._store, this._latency, this._clock);

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;

  @override
  Future<PublicVenue> bySlug(String slug) async {
    await _latency.wait();
    final v = _store.venueBySlug(slug);
    if (v == null) throw ApiError(404, 'We could not find that venue.');
    final now = _clock();
    final today = AppTime.today(now, v.timezone);

    final spaces = [
      for (final s in _store.spacesOf(v.id, activeOnly: true))
        VenueSpace(
          id: s.id,
          name: s.name,
          slug: s.slug,
          kind: s.kind,
          capacity: s.capacity,
          slotMinutes: s.slotMinutes,
          bufferMinutes: s.bufferMinutes,
          priceCents: s.priceCents,
          sortOrder: s.sortOrder,
          imageUrl: s.imageUrl,
          peakPriceCents: _peak(s),
          openToday: v.suspended
              ? 0
              : FakeAvailability(_store, _clock)
                  .forDate(venue: v, space: s, date: today)
                  .openSlots
                  .length,
        ),
    ];

    return PublicVenue(
      id: v.id,
      slug: v.slug,
      name: v.name,
      tagline: v.tagline,
      address: v.address,
      timezone: v.timezone,
      currency: v.currency,
      theme: v.theme,
      logoUrl: v.logoUrl,
      coverUrl: v.coverUrl,
      minNoticeMinutes: v.minNoticeMinutes,
      maxHorizonDays: v.maxHorizonDays,
      cancellationMode: v.cancellationMode,
      cancellationGraceHours: v.cancellationGraceHours,
      refundTerms: v.refundTerms,
      gcashName: v.gcashName,
      suspended: v.suspended,
      spaces: spaces,
    );
  }

  /// The highest pricing-rule price, so the card can say "₱450 peak".
  int? _peak(FakeSpace s) {
    final rules = _store.rulesOf(s.id).toList();
    if (rules.isEmpty) return null;
    final max = rules.map((r) => r.priceCents).reduce((a, b) => a > b ? a : b);
    return max > s.priceCents ? max : null;
  }
}
