import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../domain/growth.dart';

/// In-memory [GrowthRepository], ported from `src/lib/{memberships,promo,
/// engagement,ical,webhooks,api-keys,export}.ts`.
///
/// The rules kept: writes and everything under integrations are owner/admin;
/// a plan needs credits or a discount and its kind decides its period; a code
/// is upper-cased and unique per venue, a peso amount is centavos, and its
/// expiry is the end of that day in the **venue's** zone; a granted plan seeds
/// its credits and expiry; an API key is shown once.
class FakeGrowthRepository implements GrowthRepository {
  FakeGrowthRepository(
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
  final VenueRole? Function(String venueSlug) _roleFor;

  DateTime get _now => _clock().toUtc();

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  FakeVenue _venue(String slug) {
    final v = _store.venueBySlug(slug);
    if (v == null || _roleFor(slug) == null) {
      throw ApiError(404, "We couldn't find that venue.");
    }
    return v;
  }

  FakeVenue _manage(String slug) {
    final v = _venue(slug);
    if (!_roleFor(slug)!.atLeast(VenueRole.admin)) {
      throw ApiError(403, 'Only an owner or admin can change this.');
    }
    return v;
  }

  // ---- plans ---------------------------------------------------------------

  MembershipPlan _plan(FakePlan p) => MembershipPlan(
        id: p.id,
        name: p.name,
        kind: p.kind == 'membership' ? PlanKind.membership : PlanKind.pass,
        priceCents: p.priceCents,
        credits: p.credits,
        period: p.period,
        discountPct: p.discountPct,
        validDays: p.validDays,
        active: p.active,
        holders: _store.holdings.where((h) => h.planId == p.id && h.status == 'active').length,
      );

  @override
  Future<List<MembershipPlan>> plans(String venueSlug) async {
    await _tick();
    final v = _venue(venueSlug);
    final rows = _store.plans.where((p) => p.venueId == v.id).toList()
      ..sort((a, b) {
        if (a.active != b.active) return a.active ? -1 : 1;
        return b.createdAt.compareTo(a.createdAt);
      });
    return rows.map(_plan).toList();
  }

  @override
  Future<MembershipPlan> createPlan(String venueSlug, PlanInput input) async {
    await _tick();
    final v = _manage(venueSlug);
    final errors = input.validate();
    if (errors.isNotEmpty) {
      throw ApiError(400, errors.values.first, fieldErrors: errors);
    }
    final name = input.name.trim();
    if (_store.plans.any((p) => p.venueId == v.id && p.name == name)) {
      throw ApiError(400, 'You already have a plan named $name.', fieldErrors: {
        'name': 'You already have a plan named $name.',
      });
    }
    int? n(String s) => s.trim().isEmpty ? null : int.parse(s.trim());
    final plan = FakePlan(
      id: _store.nextId('plan'),
      venueId: v.id,
      name: name,
      kind: input.kind.name,
      priceCents: (double.parse(input.price.trim()) * 100).round(),
      credits: n(input.credits),
      discountPct: n(input.discountPct),
      validDays: n(input.validDays),
      createdAt: _now,
    );
    _store.plans.add(plan);
    return _plan(plan);
  }

  @override
  Future<MembershipPlan> setPlanActive(String venueSlug, String planId, bool active) async {
    await _tick();
    final v = _manage(venueSlug);
    final plan = _store.plans.where((p) => p.id == planId && p.venueId == v.id).firstOrNull;
    if (plan == null) throw ApiError(404, "We couldn't find that plan.");
    plan.active = active;
    return _plan(plan);
  }

  List<Holding> _holdings(String venueId, String customerId) =>
      fakeHoldings(_store, venueId, customerId);

  @override
  Future<List<Holding>> grantPlan(String venueSlug, String customerId, String planId) async {
    await _tick();
    final v = _manage(venueSlug);
    final customer =
        _store.customers.where((c) => c.id == customerId && c.venueId == v.id).firstOrNull;
    if (customer == null) throw ApiError(404, "We couldn't find that customer.");
    final plan =
        _store.plans.where((p) => p.id == planId && p.venueId == v.id && p.active).firstOrNull;
    if (plan == null) {
      throw ApiError(409, "That plan isn't available.", reason: 'plan_unavailable');
    }
    _store.holdings.add(FakeHolding(
      id: _store.nextId('hold'),
      venueId: v.id,
      customerId: customer.id,
      planId: plan.id,
      creditsRemaining: plan.credits ?? 0,
      expiresAt: plan.validDays == null ? null : _now.add(Duration(days: plan.validDays!)),
      createdAt: _now,
    ));
    return _holdings(v.id, customer.id);
  }

  // ---- promo codes ---------------------------------------------------------

  PromoCode _promo(FakePromo p) => PromoCode(
        id: p.id,
        code: p.code,
        kind: p.kind == 'amount' ? PromoKind.amount : PromoKind.percent,
        percent: p.kind == 'percent' ? p.value : null,
        amountCents: p.kind == 'amount' ? p.value : null,
        maxUses: p.maxUses,
        uses: p.uses,
        expiresAt: p.expiresAt,
        active: p.active,
      );

  @override
  Future<List<PromoCode>> promoCodes(String venueSlug) async {
    await _tick();
    final v = _venue(venueSlug);
    final rows = _store.promos.where((p) => p.venueId == v.id).toList()
      ..sort((a, b) {
        if (a.active != b.active) return a.active ? -1 : 1;
        return b.createdAt.compareTo(a.createdAt);
      });
    return rows.map(_promo).toList();
  }

  @override
  Future<PromoCode> createPromo(String venueSlug, PromoInput input) async {
    await _tick();
    final v = _manage(venueSlug);
    final errors = input.validate();
    if (errors.isNotEmpty) throw ApiError(400, errors.values.first, fieldErrors: errors);
    final code = input.code.trim().toUpperCase();
    if (_store.promos.any((p) => p.venueId == v.id && p.code == code)) {
      final message = 'You already have a code named $code.';
      throw ApiError(400, message, fieldErrors: {'code': message});
    }
    final value = int.parse(input.value.trim());
    DateTime? expires;
    if (input.expiresAt case final day?) {
      // 23:59:59 that day in the venue's zone, as make_timestamptz does.
      expires = AppTime.fromLocal(day, '23:59', v.timezone)?.add(const Duration(seconds: 59));
      if (expires == null) throw ApiError(400, 'Pick a date.', fieldErrors: {'expiresAt': 'Pick a date.'});
    }
    final promo = FakePromo(
      id: _store.nextId('promo'),
      venueId: v.id,
      code: code,
      kind: input.kind.name,
      value: input.kind == PromoKind.amount ? value * 100 : value,
      maxUses: input.maxUses.trim().isEmpty ? null : int.parse(input.maxUses.trim()),
      expiresAt: expires,
      createdAt: _now,
    );
    _store.promos.add(promo);
    return _promo(promo);
  }

  @override
  Future<PromoCode> setPromoActive(String venueSlug, String promoId, bool active) async {
    await _tick();
    final v = _manage(venueSlug);
    final promo = _store.promos.where((p) => p.id == promoId && p.venueId == v.id).firstOrNull;
    if (promo == null) throw ApiError(404, "We couldn't find that code.");
    promo.active = active;
    return _promo(promo);
  }

  // ---- marketing -----------------------------------------------------------

  @override
  Future<MarketingSettings> marketing(String venueSlug) async {
    await _tick();
    return MarketingSettings(reviewUrl: _venue(venueSlug).reviewUrl);
  }

  @override
  Future<MarketingSettings> setReviewUrl(String venueSlug, String? url) async {
    await _tick();
    final v = _manage(venueSlug);
    final value = url?.trim() ?? '';
    if (reviewUrlProblem(value) case final problem?) {
      throw ApiError(400, problem, fieldErrors: {'reviewUrl': problem});
    }
    v.reviewUrl = value.isEmpty ? null : value;
    return MarketingSettings(reviewUrl: v.reviewUrl);
  }

  // ---- integrations --------------------------------------------------------

  Integrations _integrations(FakeVenue v) => Integrations(
        icalUrl: 'https://app.reservme.test/api/calendar/${v.icalToken}',
        webhooks: [
          for (final w in _store.webhooks.where((w) => w.venueId == v.id).toList().reversed)
            Webhook(
              id: w.id,
              url: w.url,
              secret: w.secret,
              events: w.events,
              createdAt: w.createdAt,
            ),
        ],
        apiKeys: [
          for (final k in (_store.apiKeys.where((k) => k.venueId == v.id).toList()
            ..sort((a, b) {
              if (a.revokedAt == null && b.revokedAt != null) return -1;
              if (a.revokedAt != null && b.revokedAt == null) return 1;
              return b.createdAt.compareTo(a.createdAt);
            })))
            ApiKeyInfo(
              id: k.id,
              name: k.name,
              prefix: k.prefix,
              lastUsedAt: k.lastUsedAt,
              createdAt: k.createdAt,
              revokedAt: k.revokedAt,
            ),
        ],
      );

  @override
  Future<Integrations> integrations(String venueSlug) async {
    await _tick();
    return _integrations(_manage(venueSlug));
  }

  @override
  Future<Integrations> rotateCalendarFeed(String venueSlug) async {
    await _tick();
    final v = _manage(venueSlug)..icalToken = _store.nextId('ical');
    return _integrations(v);
  }

  @override
  Future<Integrations> addWebhook(
    String venueSlug, {
    required String url,
    required List<String> events,
  }) async {
    await _tick();
    final v = _manage(venueSlug);
    final uri = Uri.tryParse(url.trim());
    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      throw ApiError(400, 'Enter a valid https URL.', fieldErrors: {'url': 'Enter a valid https URL.'});
    }
    if (events.isEmpty) {
      throw ApiError(400, 'Pick at least one event.', fieldErrors: {'events': 'Pick at least one event.'});
    }
    _store.webhooks.add(FakeWebhook(
      id: _store.nextId('wh'),
      venueId: v.id,
      url: url.trim(),
      secret: 'whsec_fake_${_store.nextId('s')}',
      events: List.of(events),
      createdAt: _now,
    ));
    return _integrations(v);
  }

  @override
  Future<Integrations> deleteWebhook(String venueSlug, String webhookId) async {
    await _tick();
    final v = _manage(venueSlug);
    _store.webhooks.removeWhere((w) => w.id == webhookId && w.venueId == v.id);
    return _integrations(v);
  }

  @override
  Future<CreatedApiKey> createApiKey(String venueSlug, String name) async {
    await _tick();
    final v = _manage(venueSlug);
    final trimmed = name.trim();
    if (trimmed.isEmpty) throw ApiError(400, 'Name the key.', fieldErrors: {'name': 'Name the key.'});
    final key = 'rk_live_fake${_store.nextId('k')}xxxxxxxxxxxxxxxxxxxx';
    _store.apiKeys.add(FakeApiKey(
      id: _store.nextId('key'),
      venueId: v.id,
      name: trimmed,
      prefix: key.substring(0, 14),
      createdAt: _now,
    ));
    return CreatedApiKey(key: key, integrations: _integrations(v));
  }

  @override
  Future<Integrations> revokeApiKey(String venueSlug, String keyId) async {
    await _tick();
    final v = _manage(venueSlug);
    final key = _store.apiKeys.where((k) => k.id == keyId && k.venueId == v.id).firstOrNull;
    if (key != null) key.revokedAt ??= _now;
    return _integrations(v);
  }

  // ---- export --------------------------------------------------------------

  static String _csv(List<String> header, List<List<Object?>> rows) {
    String esc(Object? v) {
      final s = v?.toString() ?? '';
      return RegExp(r'[",\r\n]').hasMatch(s) ? '"${s.replaceAll('"', '""')}"' : s;
    }

    final lines = [
      header.map(esc).join(','),
      for (final r in rows) r.map(esc).join(','),
    ];
    // CRLF with a trailing newline: what spreadsheets expect.
    return '${lines.join('\r\n')}\r\n';
  }

  @override
  Future<String> export(String venueSlug, ExportKind kind) async {
    await _tick();
    final v = _venue(venueSlug);
    final zone = v.timezone;
    final bookings = _store
        .reservationsOf(v.id)
        .where((r) => r.kind != ReservationKind.sessionBlock)
        .toList()
      ..sort((a, b) => b.startsAt.compareTo(a.startsAt));
    String customerName(String? id) =>
        _store.customers.where((c) => c.id == id).firstOrNull?.name ?? 'Walk-in';
    String space(String id) => _store.spaceById(id)?.name ?? '';
    String pesos(int cents) => (cents / 100).toStringAsFixed(2);

    return switch (kind) {
      ExportKind.bookings => _csv(
          ['Date', 'Time', 'Reference', 'Customer', 'Space', 'Status', 'Amount'],
          [
            for (final r in bookings)
              [
                AppTime.today(r.startsAt, zone),
                AppTime.formatTime(r.startsAt, zone),
                r.reference,
                customerName(r.customerId),
                space(r.spaceId),
                r.status.wire,
                pesos(r.amountCents),
              ],
          ],
        ),
      ExportKind.customers => _csv(
          ['Name', 'Email', 'Phone', 'Bookings', 'Loyalty points'],
          [
            for (final c in _store.customers.where((c) => c.venueId == v.id))
              [
                c.name,
                c.email,
                c.phone,
                bookings.where((r) => r.customerId == c.id).length,
                c.loyaltyPoints,
              ],
          ],
        ),
      ExportKind.transactions => _csv(
          ['Date', 'Reference', 'Customer', 'Space', 'Status', 'Gross', 'Discount', 'Net'],
          [
            for (final r in bookings)
              [
                AppTime.today(r.startsAt, zone),
                r.reference,
                customerName(r.customerId),
                space(r.spaceId),
                r.status.wire,
                pesos(r.amountCents),
                pesos(0),
                pesos(r.amountCents),
              ],
          ],
        ),
    };
  }
}

/// What a customer holds at a venue, active first — shared with the fake
/// customers repository, whose profile shows the same list.
List<Holding> fakeHoldings(FakeStore store, String venueId, String customerId) {
  final rows = store.holdings
      .where((h) => h.venueId == venueId && h.customerId == customerId)
      .toList()
    ..sort((a, b) {
      final aActive = a.status == 'active', bActive = b.status == 'active';
      if (aActive != bActive) return aActive ? -1 : 1;
      return b.createdAt.compareTo(a.createdAt);
    });
  return [
    for (final h in rows)
      if (store.plans.where((p) => p.id == h.planId).firstOrNull case final plan?)
        Holding(
          id: h.id,
          planId: plan.id,
          planName: plan.name,
          kind: plan.kind == 'membership' ? PlanKind.membership : PlanKind.pass,
          creditsRemaining: h.creditsRemaining,
          discountPct: plan.discountPct,
          status: h.status,
          expiresAt: h.expiresAt,
        ),
  ];
}
