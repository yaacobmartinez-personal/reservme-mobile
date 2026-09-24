import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../domain/customer.dart';
import '../domain/customers_repository.dart';

/// In-memory [CustomersRepository], ported from `src/lib/customers.ts` and
/// `src/app/app/customer-actions.ts`.
class FakeCustomersRepository implements CustomersRepository {
  FakeCustomersRepository(this._store, this._latency, this._clock, this._offline);

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  FakeVenue _venue(String slug) {
    final v = _store.venueBySlug(slug);
    if (v == null) throw ApiError(404, 'We could not find that venue.');
    return v;
  }

  FakeCustomer _customer(FakeVenue venue, String id) {
    final c = _store.customerById(id);
    if (c == null || c.venueId != venue.id) {
      throw ApiError(404, 'Customer not found.');
    }
    return c;
  }

  @override
  Future<CustomerPage> list(
    String venueSlug, {
    String? search,
    CustomerSegment segment = CustomerSegment.all,
  }) async {
    await _tick();
    final venue = _venue(venueSlug);
    final now = _clock();
    final q = (search ?? '').trim().toLowerCase();

    final all = <CustomerSummary>[];
    for (final c in _store.customersOf(venue.id)) {
      if (q.isNotEmpty) {
        final hit = c.name.toLowerCase().contains(q) ||
            c.email.toLowerCase().contains(q) ||
            (c.phone ?? '').toLowerCase().contains(q);
        if (!hit) continue;
      }
      all.add(_summary(venue, c, now));
    }

    final rows = all.where((c) => _inSegment(c, segment, now)).toList()
      // "Recent" in the web is created_at DESC; newest customer first.
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return CustomerPage(rows: rows, total: all.length);
  }

  bool _inSegment(CustomerSummary c, CustomerSegment segment, DateTime now) =>
      switch (segment) {
        CustomerSegment.all => true,
        // A regular has been back: more than a couple of confirmed bookings.
        CustomerSegment.regulars => c.bookings >= 3,
        CustomerSegment.noShows => c.noShowCount > 0,
        CustomerSegment.newThisMonth =>
          now.difference(c.createdAt).inDays <= 30,
      };

  @override
  Future<CustomerProfile> detail(String venueSlug, String customerId) async {
    await _tick();
    final venue = _venue(venueSlug);
    final c = _customer(venue, customerId);
    final now = _clock();
    final zone = venue.timezone;

    final mine = _store
        .reservationsOf(venue.id)
        .where((r) =>
            r.customerId == c.id &&
            r.kind != ReservationKind.sessionBlock &&
            r.status != ReservationStatus.held)
        .toList()
      ..sort((a, b) => b.startsAt.compareTo(a.startsAt));

    CustomerBooking map(FakeReservation r) => CustomerBooking(
          id: r.id,
          spaceName: _store.spaceById(r.spaceId)?.name ?? 'Space',
          whenLabel: '${AppTime.formatDay(r.startsAt, zone)} · '
              '${AppTime.formatTime(r.startsAt, zone)}',
          startsAt: r.startsAt,
          status: r.status,
          kind: r.kind,
          amountCents: r.amountCents,
          reference: r.reference,
          checkedInAt: r.checkedInAt,
        );

    final upcoming = mine.where((r) => r.startsAt.isAfter(now)).toList();
    final past = mine.where((r) => !r.startsAt.isAfter(now)).toList();

    final notes = _store.customerNotes
        .where((n) => n.customerId == c.id)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return CustomerProfile(
      customer: _summary(venue, c, now),
      // Newest-first from the sort; flip so the next booking reads top-down.
      upcoming: upcoming.reversed.map(map).toList(),
      past: past.map(map).toList(),
      notes: [
        for (final n in notes)
          CustomerNote(
            id: n.id,
            body: n.body,
            authorName: _store.userById(n.authorUserId)?.name,
            createdAt: n.createdAt,
          ),
      ],
      lastVisit: past
          .where((r) => r.status == ReservationStatus.confirmed)
          .map((r) => r.startsAt)
          .firstOrNull,
    );
  }

  @override
  Future<CustomerNote> addNote(
    String venueSlug,
    String customerId,
    String body,
  ) async {
    await _tick();
    final venue = _venue(venueSlug);
    final c = _customer(venue, customerId);
    final message = NoteRules.validate(body);
    if (message != null) throw ApiError(400, message);

    // The author is whoever is signed in; fake mode has one desk.
    final author = _store.membersOf(venue.id).firstOrNull;
    final note = FakeCustomerNote(
      id: _store.nextId('n'),
      customerId: c.id,
      authorUserId: author?.userId ?? '',
      body: body.trim(),
      createdAt: _clock(),
    );
    _store.customerNotes.add(note);
    return CustomerNote(
      id: note.id,
      body: note.body,
      authorName: _store.userById(note.authorUserId)?.name,
      createdAt: note.createdAt,
    );
  }

  @override
  Future<void> deleteNote(
    String venueSlug,
    String customerId,
    String noteId,
  ) async {
    await _tick();
    final venue = _venue(venueSlug);
    _customer(venue, customerId);
    _store.customerNotes.removeWhere(
      (n) => n.id == noteId && n.customerId == customerId,
    );
  }

  @override
  Future<CustomerSummary> setTags(
    String venueSlug,
    String customerId,
    List<String> tags,
  ) async {
    await _tick();
    final venue = _venue(venueSlug);
    final c = _customer(venue, customerId);

    final clean = <String>[];
    for (final raw in tags) {
      final t = raw.trim();
      final message = TagRules.validate(t, clean);
      if (message != null) throw ApiError(400, message);
      clean.add(t);
    }
    c.tags = clean;
    return _summary(venue, c, _clock());
  }

  @override
  Future<CustomerSummary> updateContact(
    String venueSlug,
    String customerId, {
    required String name,
    String? phone,
  }) async {
    await _tick();
    final venue = _venue(venueSlug);
    final c = _customer(venue, customerId);
    final message = ContactRules.validate(name: name, phone: phone);
    if (message != null) throw ApiError(400, message);

    c.name = name.trim();
    c.phone = (phone ?? '').trim().isEmpty ? null : phone!.trim();
    return _summary(venue, c, _clock());
  }

  CustomerSummary _summary(FakeVenue venue, FakeCustomer c, DateTime now) {
    final mine = _store
        .reservationsOf(venue.id)
        .where((r) => r.customerId == c.id && r.kind != ReservationKind.sessionBlock);

    final confirmed = mine.where((r) => r.status == ReservationStatus.confirmed);
    final lastVisit = confirmed
        .where((r) => !r.startsAt.isAfter(now))
        .map((r) => r.startsAt)
        .fold<DateTime?>(null, (a, b) => a == null || b.isAfter(a) ? b : a);

    return CustomerSummary(
      id: c.id,
      name: c.name,
      email: c.email,
      phone: c.phone,
      tags: List.of(c.tags),
      bookings: confirmed.length,
      lifetimeValueCents: confirmed.fold(0, (sum, r) => sum + r.amountCents),
      noShowCount: c.noShowCount,
      lastVisitDays: lastVisit == null ? null : now.difference(lastVisit).inDays,
      createdAt: c.createdAt,
    );
  }
}
