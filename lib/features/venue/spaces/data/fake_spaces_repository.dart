import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/model/opening_hours.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../domain/space_detail.dart';
import '../domain/space_input.dart';
import '../domain/space_summary.dart';

/// In-memory [SpacesRepository], including the web's `setSpaceActive`
/// permission check: day-to-day staff run the desk, but taking a space off
/// sale changes what the venue is billed for, so it is owner/admin only.
///
/// Every structural write in `src/app/app/actions.ts` goes through
/// `requireRole("owner", "admin")`, so the editor's writes do too.
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

  /// The web's `MANAGE` guard. The message is the one the app already uses for
  /// the active toggle, because it is the same refusal.
  FakeVenue _manageable(String slug) {
    final venue = _venue(slug);
    final role = _roleFor(slug);
    if (role == null || !role.atLeast(VenueRole.admin)) {
      throw ApiError(403, 'Only an owner or admin can change what is on sale.');
    }
    return venue;
  }

  FakeSpace _space(FakeVenue venue, String spaceId) {
    final space = _store.spaceById(spaceId);
    if (space == null || space.venueId != venue.id) {
      throw ApiError(404, 'That space no longer exists.');
    }
    return space;
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
          upcomingBookings: _upcoming(venue, s.id, now),
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
    final venue = _manageable(venueSlug);
    _space(venue, spaceId).isActive = active;
    return (await list(venueSlug)).firstWhere((s) => s.id == spaceId);
  }

  @override
  Future<SpaceDetail> detail(String venueSlug, String spaceId) async {
    await _tick();
    final venue = _venue(venueSlug);
    return _detail(venue, _space(venue, spaceId));
  }

  @override
  Future<SpaceDetail> create(String venueSlug, SpaceInput input) async {
    await _tick();
    final venue = _manageable(venueSlug);
    final refusal = input.validate();
    if (refusal != null) throw ApiError(400, refusal);

    final space = FakeSpace(
      id: _store.nextId('spc'),
      venueId: venue.id,
      name: input.name.trim(),
      slug: _uniqueSlug(venue.id, input.name),
      kind: input.kind,
      capacity: input.capacity,
      slotMinutes: input.slotMinutes,
      bufferMinutes: input.bufferMinutes,
      priceCents: input.priceCents,
      sortOrder: _store.spacesOf(venue.id).length,
      createdAt: _clock(),
    );
    _store.spaces.add(space);

    // A space with no opening hours is unbookable, which would defeat the
    // point of adding one: the web seeds 08:00–22:00 on all seven days and
    // lets the owner refine it.
    for (var weekday = 0; weekday < 7; weekday++) {
      _store.openingHours.add(FakeOpeningHours(
        spaceId: space.id,
        weekday: weekday,
        opensAt: '08:00',
        closesAt: '22:00',
      ));
    }

    return _detail(venue, space);
  }

  @override
  Future<SpaceDetail> update(
    String venueSlug,
    String spaceId,
    SpaceInput input,
  ) async {
    await _tick();
    final venue = _manageable(venueSlug);
    final refusal = input.validate();
    if (refusal != null) throw ApiError(400, refusal);

    final space = _space(venue, spaceId)
      ..name = input.name.trim()
      ..kind = input.kind
      ..capacity = input.capacity
      ..slotMinutes = input.slotMinutes
      ..bufferMinutes = input.bufferMinutes
      ..priceCents = input.priceCents;
    return _detail(venue, space);
  }

  @override
  Future<void> remove(String venueSlug, String spaceId) async {
    await _tick();
    final venue = _manageable(venueSlug);
    final space = _space(venue, spaceId);

    // Deleting a space with bookings still ahead of it would strand the
    // customers holding them. Pausing is the reversible answer, and the
    // screen offers it instead.
    final ahead = _upcoming(venue, spaceId, _clock());
    if (ahead > 0) {
      throw ApiError(
        409,
        ahead == 1
            ? 'One booking is still ahead on this space. Pause it instead.'
            : '$ahead bookings are still ahead on this space. Pause it instead.',
      );
    }

    _store.spaces.remove(space);
    _store.openingHours.removeWhere((h) => h.spaceId == spaceId);
    _store.pricingRules.removeWhere((r) => r.spaceId == spaceId);
    _store.closures.removeWhere((c) => c.spaceId == spaceId);
  }

  @override
  Future<SpaceDetail> setHours(
    String venueSlug,
    String spaceId,
    HoursInput hours,
  ) async {
    await _tick();
    final venue = _manageable(venueSlug);
    final space = _space(venue, spaceId);
    final refusal = hours.validate();
    if (refusal != null) throw ApiError(400, refusal);

    // `setOpeningHours` replaces the week wholesale: the delete comes first,
    // and only usable days are written back, so unchecking a day closes it.
    _store.openingHours.removeWhere((h) => h.spaceId == spaceId);
    for (final day in hours.days.where((d) => d.isUsable)) {
      _store.openingHours.add(FakeOpeningHours(
        spaceId: spaceId,
        weekday: day.weekday,
        opensAt: day.opensAt,
        closesAt: day.closesAt,
      ));
    }
    return _detail(venue, space);
  }

  @override
  Future<SpaceDetail> setImage(
    String venueSlug,
    String spaceId,
    List<int>? image,
  ) async {
    await _tick();
    final venue = _manageable(venueSlug);
    final space = _space(venue, spaceId);

    if (image != null && image.length > _maxImageBytes) {
      throw ApiError(413, 'That photo is too large — keep it under 2 MB.');
    }
    // Nothing is uploaded in fake mode; the URL stands in for the R2 key so
    // every surface downstream behaves as if a photo exists.
    space.imageUrl = image == null
        ? null
        : 'fake://spaces/${space.id}/${_clock().millisecondsSinceEpoch}.jpg';
    return _detail(venue, space);
  }

  static const _maxImageBytes = 2 * 1024 * 1024;

  @override
  Future<SpaceDetail> addPricingRule(
    String venueSlug,
    String spaceId,
    PricingRuleInput input,
  ) async {
    await _tick();
    final venue = _manageable(venueSlug);
    final space = _space(venue, spaceId);
    final refusal = input.validate();
    if (refusal != null) throw ApiError(400, refusal);

    _store.pricingRules.add(FakePricingRule(
      id: _store.nextId('rul'),
      spaceId: spaceId,
      weekdays: [...input.weekdays]..sort(),
      startsAt: input.startsAt,
      endsAt: input.endsAt,
      priceCents: input.priceCents,
      label: input.label.trim().isEmpty ? null : input.label.trim(),
    ));
    return _detail(venue, space);
  }

  @override
  Future<SpaceDetail> removePricingRule(
    String venueSlug,
    String spaceId,
    String ruleId,
  ) async {
    await _tick();
    final venue = _manageable(venueSlug);
    final space = _space(venue, spaceId);
    _store.pricingRules
        .removeWhere((r) => r.id == ruleId && r.spaceId == spaceId);
    return _detail(venue, space);
  }

  @override
  Future<SpaceDetail> addClosure(
    String venueSlug,
    String spaceId,
    ClosureInput input,
  ) async {
    await _tick();
    final venue = _manageable(venueSlug);
    final refusal = input.validate();
    if (refusal != null) throw ApiError(400, refusal);

    final starts = AppTime.fromLocal(input.fromDate, input.fromTime, venue.timezone);
    final ends = AppTime.fromLocal(input.toDate, input.toTime, venue.timezone);
    if (starts == null || ends == null || !ends.isAfter(starts)) {
      throw ApiError(400, 'Please give a valid start and end.');
    }
    if (input.spaceId != null) _space(venue, input.spaceId!);

    _store.closures.add(FakeClosure(
      id: _store.nextId('clo'),
      venueId: venue.id,
      spaceId: input.spaceId,
      startsAt: starts,
      endsAt: ends,
      reason: input.reason.trim().isEmpty ? null : input.reason.trim(),
    ));

    // A closure stops *new* bookings; it never cancels the ones already
    // inside it, exactly as the calendar's block sheet warns.
    return _detail(venue, _space(venue, spaceId));
  }

  @override
  Future<SpaceDetail> removeClosure(
    String venueSlug,
    String spaceId,
    String closureId,
  ) async {
    await _tick();
    final venue = _manageable(venueSlug);
    final space = _space(venue, spaceId);
    _store.closures.removeWhere((c) => c.id == closureId && c.venueId == venue.id);
    return _detail(venue, space);
  }

  /// `uniqueSpaceSlug`: the slugified name, then `-2`, `-3`, … until free.
  String _uniqueSlug(String venueId, String name) {
    final base = _slugify(name);
    final taken = _store.spacesOf(venueId).map((s) => s.slug).toSet();
    if (!taken.contains(base)) return base;
    for (var n = 2; n < 999; n++) {
      if (!taken.contains('$base-$n')) return '$base-$n';
    }
    return '$base-${_clock().microsecondsSinceEpoch}';
  }

  static String _slugify(String input) {
    final slug = input
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    return slug.isEmpty ? 'space' : slug;
  }

  int _upcoming(FakeVenue venue, String spaceId, DateTime now) => _store
      .reservationsOf(venue.id)
      .where((r) =>
          r.spaceId == spaceId && r.status.isLive && r.startsAt.isAfter(now))
      .length;

  SpaceDetail _detail(FakeVenue venue, FakeSpace space) {
    final now = _clock();
    return SpaceDetail(
      id: space.id,
      name: space.name,
      slug: space.slug,
      kind: space.kind,
      capacity: space.capacity,
      slotMinutes: space.slotMinutes,
      bufferMinutes: space.bufferMinutes,
      priceCents: space.priceCents,
      isActive: space.isActive,
      imageUrl: space.imageUrl,
      hours: [
        for (final h in _store.hoursOf(space.id))
          DayHoursView(
            weekday: h.weekday,
            opensAt: h.opensAt,
            closesAt: h.closesAt,
          ),
      ]..sort((a, b) => a.weekday.compareTo(b.weekday)),
      pricingRules: [
        for (final r in _store.rulesOf(space.id))
          PricingRuleView(
            id: r.id,
            label: r.label,
            weekdays: [...r.weekdays],
            startsAt: r.startsAt,
            endsAt: r.endsAt,
            priceCents: r.priceCents,
          ),
      ]..sort((a, b) => a.startsAt.compareTo(b.startsAt)),
      // Closures on this space, plus the venue-wide ones that shut it too.
      closures: [
        for (final c in _store.closuresOf(venue.id))
          if ((c.spaceId == null || c.spaceId == space.id) &&
              c.endsAt.isAfter(now))
            ClosureView(
              id: c.id,
              spaceId: c.spaceId,
              spaceName: c.spaceId == null ? null : space.name,
              startsAt: c.startsAt,
              endsAt: c.endsAt,
              reason: c.reason,
            ),
      ]..sort((a, b) => a.startsAt.compareTo(b.startsAt)),
      sessions: [
        for (final s in _store.sessionsOf(venue.id))
          if (s.spaceId == space.id && s.endsAt.isAfter(now))
            SpaceSessionView(
              id: s.id,
              title: s.title,
              startsAt: s.startsAt,
              endsAt: s.endsAt,
              capacity: s.capacity,
              bookedSpots: s.bookedSpots,
              cancelled: s.cancelled,
            ),
      ]..sort((a, b) => a.startsAt.compareTo(b.startsAt)),
      upcomingBookings: _upcoming(venue, space.id, now),
    );
  }

  /// "open play Tue/Thu", built from the sessions this space runs.
  String? _sessions(FakeVenue venue, FakeSpace space) {
    final days = <int>{};
    for (final s in _store.sessionsOf(venue.id)) {
      if (s.spaceId != space.id) continue;
      days.add(s.startsAt.weekday % 7);
    }
    if (days.isEmpty) return null;
    final sorted = days.toList()..sort();
    return 'open play ${sorted.map((d) => DayHours.names[d]).join('/')}';
  }
}
