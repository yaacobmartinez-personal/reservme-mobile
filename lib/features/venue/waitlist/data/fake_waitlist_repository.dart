import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../domain/waitlist_entry.dart';

/// In-memory [VenueWaitlistRepository]. Soonest slot first, then join order
/// within a slot — the same ORDER BY `listWaitlist` uses on the server.
class FakeWaitlistRepository implements VenueWaitlistRepository {
  FakeWaitlistRepository(this._store, this._latency, this._offline);

  final FakeStore _store;
  final FakeLatency _latency;
  final bool Function() _offline;

  @override
  Future<List<WaitlistEntry>> entries(String venueSlug) async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();

    final venue = _store.venueBySlug(venueSlug);
    if (venue == null) throw ApiError(404, 'We could not find that venue.');
    final zone = venue.timezone;

    final rows = _store.waitlistOf(venue.id).toList()
      ..sort((a, b) {
        final slot = a.startsAt.compareTo(b.startsAt);
        return slot != 0 ? slot : a.createdAt.compareTo(b.createdAt);
      });

    return [
      for (final w in rows)
        if (_store.customerById(w.customerId) case final customer?)
          WaitlistEntry(
            id: w.id,
            customerName: customer.name,
            customerEmail: customer.email,
            customerPhone: customer.phone,
            spaceName: _store.spaceById(w.spaceId)?.name ?? 'Space',
            startsAt: w.startsAt,
            endsAt: w.endsAt,
            whenLabel: '${AppTime.formatDay(w.startsAt, zone)} · '
                '${AppTime.formatTime(w.startsAt, zone)}',
            status: w.status,
            createdAt: w.createdAt,
            notifiedAt: w.notifiedAt,
            // Always null on the real server, so the fake does not invent one.
            claimExpiresAt: null,
          ),
    ];
  }
}
