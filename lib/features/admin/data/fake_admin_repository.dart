import '../../../core/fake/fake_latency.dart';
import '../../../core/fake/fake_store.dart';
import '../../../core/model/enums.dart';
import '../../../core/network/api_error.dart';
import '../../../core/time/clock.dart';
import '../../venue/billing/domain/billing.dart';
import '../domain/admin.dart';

/// In-memory [AdminRepository], ported from `src/lib/admin/operations.ts` and
/// `src/lib/admin/queries.ts`.
///
/// The rules that matter are the server's: a non-admin gets 404, approving
/// extends a month from the later of now and the paid-through date, approving
/// twice is refused, a payment lifts a *billing* suspension and never a manual
/// one, the last admin cannot be revoked, and every decision leaves an audit
/// row attributed to the real person.
class FakeAdminRepository implements AdminRepository {
  FakeAdminRepository(
    this._store,
    this._latency,
    this._clock,
    this._offline,
    this._currentUserId,
  );

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;
  final String? Function() _currentUserId;

  DateTime get _now => _clock().toUtc();

  /// Signed in and a current admin — or, as the server answers anyone else,
  /// not found.
  Future<String> _admin() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
    final id = _currentUserId();
    if (id == null) throw ApiError(401, 'Sign in again to continue.');
    if (!_store.platformAdmins.contains(id)) throw ApiError(404, 'Not found.');
    return id;
  }

  FakeVenue _venue(String orgId) {
    final v = _store.venueById(orgId);
    if (v == null) throw ApiError(404, 'No such venue.');
    return v;
  }

  void _audit(
    String actor,
    String action, {
    String? venueId,
    String? target,
    Map<String, Object?>? detail,
  }) {
    _store.adminAudit.add(FakeAdminAudit(
      id: _store.nextId('audit'),
      actorUserId: actor,
      action: action,
      venueId: venueId,
      target: target,
      detail: detail,
      createdAt: _now,
    ));
  }

  // ---- reads ---------------------------------------------------------------

  DateTime _trialEnds(FakeVenue v) =>
      _store.subscriptionOf(v.id)?.trialEndsAt ?? v.createdAt.add(const Duration(days: 30));

  bool _dueNow(FakeVenue v) {
    final sub = _store.subscriptionOf(v.id);
    final status = sub?.status ?? BillingStatus.trialing;
    if (status == BillingStatus.trialing) return _now.isAfter(_trialEnds(v));
    if (status == BillingStatus.active || status == BillingStatus.pastDue) {
      final paid = sub?.paidUntil;
      return paid != null && _now.isAfter(paid);
    }
    return false;
  }

  TenantSummary _summary(FakeVenue v) {
    final sub = _store.subscriptionOf(v.id);
    final spaces = _store.spaces.where((s) => s.venueId == v.id);
    final active = spaces.where((s) => s.isActive).length;
    final booked = _store.reservations.where((r) =>
        r.venueId == v.id &&
        (r.kind == ReservationKind.rental || r.kind == ReservationKind.sessionSeat));
    final since = _now.subtract(const Duration(days: 30));
    final band = PlanBand.forSpaces(active);
    final trialLeft = _trialEnds(v).difference(_now);

    return TenantSummary(
      orgId: v.id,
      name: v.name,
      slug: v.slug,
      timezone: v.timezone,
      currency: v.currency,
      createdAt: v.createdAt,
      suspendedAt: v.suspendedAt,
      suspendedReason: v.suspendedReason,
      billingSuspended: v.suspended && v.suspendedReason == BillingPolicy.suspendReason,
      activeSpaces: active,
      memberCount: _store.memberships.where((m) => m.venueId == v.id).length,
      upcomingBookings: booked
          .where((r) =>
              (r.status == ReservationStatus.held || r.status == ReservationStatus.confirmed) &&
              r.startsAt.isAfter(_now))
          .length,
      bookingsLast30: booked.where((r) => r.createdAt.isAfter(since)).length,
      revenueLast30Cents: booked
          .where((r) => r.status == ReservationStatus.confirmed && r.createdAt.isAfter(since))
          .fold(0, (sum, r) => sum + r.amountCents),
      subscription: TenantSubscription(
        status: sub?.status ?? BillingStatus.trialing,
        trialDaysLeft: trialLeft.isNegative ? 0 : (trialLeft.inHours / 24).ceil(),
        dueNow: _dueNow(v),
      ),
      band: TenantBand(
        name: band.name,
        priceCents: band.pricePesos == null ? null : band.pricePesos! * 100,
      ),
    );
  }

  /// Suspended first, then newest — the web table's order.
  List<TenantSummary> _allTenants() {
    final rows = [for (final v in _store.venues) _summary(v)];
    rows.sort((a, b) {
      if (a.suspended != b.suspended) return a.suspended ? 1 : -1;
      return b.createdAt.compareTo(a.createdAt);
    });
    return rows;
  }

  AdminPayment _payment(FakeBillingPayment p) => AdminPayment(
        id: p.id,
        orgId: p.venueId,
        venueName: _store.venueById(p.venueId)?.name,
        amountCents: p.amountCents,
        reference: p.reference,
        paidAt: DateTime.parse(p.paidAt),
        status: p.status,
        note: p.note,
        receiptUrl: p.receiptUrl,
        createdAt: p.createdAt,
      );

  @override
  Future<AdminOverview> overview() async {
    await _admin();
    final tenants = _allTenants();
    final since = _now.subtract(const Duration(days: 30));

    final growth = <GrowthPoint>[];
    final firstMonth = DateTime.utc(_now.year, _now.month - 11);
    var cumulative = _store.venues.where((v) => v.createdAt.isBefore(firstMonth)).length;
    for (var i = 11; i >= 0; i--) {
      final month = DateTime.utc(_now.year, _now.month - i);
      final next = DateTime.utc(month.year, month.month + 1);
      final signups = _store.venues
          .where((v) => !v.createdAt.isBefore(month) && v.createdAt.isBefore(next))
          .length;
      cumulative += signups;
      growth.add(GrowthPoint(
        month: '${month.year}-${month.month.toString().padLeft(2, '0')}',
        signups: signups,
        cumulative: cumulative,
      ));
    }

    return AdminOverview(
      totals: AdminTotals(
        tenants: tenants.length,
        suspended: tenants.where((t) => t.suspended).length,
        activeSpaces: _store.spaces.where((s) => s.isActive).length,
        bookingsLast30: _store.reservations
            .where((r) =>
                r.createdAt.isAfter(since) &&
                (r.kind == ReservationKind.rental || r.kind == ReservationKind.sessionSeat))
            .length,
        customers: _store.customers.length,
        runRateCents: tenants
            .where((t) => !t.suspended)
            .fold(0, (sum, t) => sum + (t.band.priceCents ?? 0)),
      ),
      radar: AdminRadar(
        endingSoon: [
          for (final t in tenants)
            if (t.subscription.status == BillingStatus.trialing &&
                !t.subscription.dueNow &&
                t.subscription.trialDaysLeft <= 5)
              t,
        ],
        inGrace: [
          for (final t in tenants)
            if (t.subscription.dueNow && !t.billingSuspended) t,
        ],
        suspended: [for (final t in tenants) if (t.billingSuspended) t],
      ),
      pendingPayments: _store.billingPayments.where((p) => p.status == 'submitted').length,
      growth: growth,
    );
  }

  @override
  Future<List<TenantSummary>> tenants({String? query}) async {
    await _admin();
    final needle = query?.trim().toLowerCase() ?? '';
    return [
      for (final t in _allTenants())
        if (needle.isEmpty || t.name.toLowerCase().contains(needle) || t.slug.contains(needle))
          t,
    ];
  }

  @override
  Future<TenantDetail> tenant(String orgId) async {
    await _admin();
    final v = _venue(orgId);
    final s = _summary(v);
    final sub = _store.subscriptionOf(v.id);

    final spaces = _store.spaces.where((sp) => sp.venueId == v.id).toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    final members = _store.memberships.where((m) => m.venueId == v.id).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    final bookings = _store.reservations
        .where((r) =>
            r.venueId == v.id &&
            (r.kind == ReservationKind.rental || r.kind == ReservationKind.sessionSeat))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return TenantDetail(
      tenant: TenantDetailSummary(
        orgId: s.orgId,
        name: s.name,
        slug: s.slug,
        timezone: s.timezone,
        currency: s.currency,
        createdAt: s.createdAt,
        suspendedAt: s.suspendedAt,
        suspendedReason: s.suspendedReason,
        billingSuspended: s.billingSuspended,
        activeSpaces: s.activeSpaces,
        memberCount: s.memberCount,
        upcomingBookings: s.upcomingBookings,
        bookingsLast30: s.bookingsLast30,
        revenueLast30Cents: s.revenueLast30Cents,
        subscription: s.subscription,
        band: s.band,
        paidUntil: sub?.paidUntil,
        trialEndsAt: _trialEnds(v),
      ),
      spaces: [
        for (final sp in spaces)
          TenantSpace(
            id: sp.id,
            name: sp.name,
            kind: sp.kind.wire,
            priceCents: sp.priceCents,
            active: sp.isActive,
          ),
      ],
      members: [
        for (final m in members)
          if (_store.userById(m.userId) case final u?)
            TenantMember(
              name: u.name,
              email: u.email,
              role: m.role.wire,
              joinedAt: m.createdAt,
            ),
      ],
      recentBookings: [
        for (final r in bookings.take(15))
          TenantBooking(
            reference: r.reference,
            status: r.status.wire,
            spaceName: _store.spaces.where((sp) => sp.id == r.spaceId).firstOrNull?.name ?? '',
            customerName: _store.customers.where((c) => c.id == r.customerId).firstOrNull?.name,
            label: _label(r.startsAt),
            amountCents: r.amountCents,
          ),
      ],
      payments: [
        for (final p in _store.paymentsOf(v.id).take(10)) _payment(p),
      ],
    );
  }

  /// "26 Sep 18:00" — the server formats this in the venue's zone; the fake's
  /// world is close enough in UTC.
  static String _label(DateTime t) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(t.day)} ${months[t.month - 1]} ${two(t.hour)}:${two(t.minute)}';
  }

  // ---- venue access --------------------------------------------------------

  @override
  Future<void> suspend(String orgId, {String? reason}) async {
    final actor = await _admin();
    final v = _venue(orgId);
    final why = reason?.trim();
    v
      ..suspendedAt = _now
      ..suspendedReason = why == null || why.isEmpty ? null : why;
    _audit(actor, 'admin.suspended_venue',
        venueId: v.id, detail: v.suspendedReason == null ? null : {'reason': v.suspendedReason});
  }

  @override
  Future<void> reactivate(String orgId) async {
    final actor = await _admin();
    final v = _venue(orgId)
      ..suspendedAt = null
      ..suspendedReason = null;
    _audit(actor, 'admin.reactivated_venue', venueId: v.id);
  }

  @override
  Future<void> emailOwner(String orgId, {required String subject, required String body}) async {
    final actor = await _admin();
    final v = _venue(orgId);
    if (subject.trim().length < 2 || body.trim().length < 2) {
      throw ApiError(400, 'Add a subject and a message.');
    }
    final owner = (_store.memberships
            .where((m) => m.venueId == v.id && m.role == VenueRole.owner)
            .toList()
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt)))
        .map((m) => _store.userById(m.userId))
        .firstOrNull;
    if (owner == null) {
      throw ApiError(409, 'This venue has no owner email on file.', reason: 'no_owner_email');
    }
    _store.outbox.add(FakeEmail(
      to: owner.email,
      kind: FakeEmailKind.adminMessage,
      body: '${subject.trim()}\n\n${body.trim()}',
      sentAt: _now,
    ));
    _audit(actor, 'admin.emailed_tenant', venueId: v.id, detail: {'subject': subject.trim()});
  }

  // ---- money ---------------------------------------------------------------

  FakeSubscription _subscription(String orgId) {
    final sub = _store.subscriptionOf(orgId);
    if (sub == null) throw ApiError(404, 'This venue has no subscription.');
    return sub;
  }

  /// A billing suspension lifts; a manual one (abuse, a dispute) stays.
  void _liftBillingSuspension(String orgId) {
    final v = _store.venueById(orgId);
    if (v != null && v.suspendedReason == BillingPolicy.suspendReason) {
      v
        ..suspendedAt = null
        ..suspendedReason = null;
    }
  }

  @override
  Future<void> overrideBilling(String orgId, BillingOverride change) async {
    final actor = await _admin();
    _venue(orgId);
    final sub = _subscription(orgId);
    switch (change) {
      case MarkPaid(:final through):
        final day = DateTime.tryParse(through);
        if (day == null) throw ApiError(400, 'Pick a date.');
        // Inclusive: paid *through* that day, so it runs out as the next begins.
        sub
          ..status = BillingStatus.active
          ..paidUntil = DateTime.utc(day.year, day.month, day.day + 1);
        _liftBillingSuspension(orgId);
        _audit(actor, 'admin.marked_paid', venueId: orgId, detail: {'paidUntil': through});
      case Comp():
        sub.status = BillingStatus.comped;
        _liftBillingSuspension(orgId);
        _audit(actor, 'admin.comped', venueId: orgId);
      case CancelSubscription():
        sub.status = BillingStatus.cancelled;
        _audit(actor, 'admin.cancelled_subscription', venueId: orgId);
    }
  }

  @override
  Future<List<AdminPayment>> paymentQueue() async {
    await _admin();
    final queue = _store.billingPayments.where((p) => p.status == 'submitted').toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return [for (final p in queue) _payment(p)];
  }

  FakeBillingPayment _submitted(String paymentId) {
    final p = _store.billingPayments.where((p) => p.id == paymentId).firstOrNull;
    if (p == null) throw ApiError(404, 'No such payment.');
    if (p.status != 'submitted') {
      throw ApiError(409, 'That payment has already been reviewed.', reason: 'not_submitted');
    }
    return p;
  }

  @override
  Future<void> approvePayment(String paymentId) async {
    final actor = await _admin();
    final p = _submitted(paymentId)..status = 'approved';
    final sub = _store.subscriptionOf(p.venueId);
    if (sub != null) {
      // From the later of now and what was already paid for (or the trial
      // end), so paying early never costs the venue days.
      final base = [_now, sub.paidUntil ?? sub.trialEndsAt].reduce((a, b) => a.isAfter(b) ? a : b);
      sub
        ..status = BillingStatus.active
        ..paidUntil = DateTime.utc(base.year, base.month + 1, base.day, base.hour, base.minute);
    }
    _liftBillingSuspension(p.venueId);
    _audit(actor, 'admin.approved_payment',
        venueId: p.venueId, detail: {'reference': p.reference, 'amountCents': p.amountCents});
  }

  @override
  Future<void> rejectPayment(String paymentId, {String? note}) async {
    final actor = await _admin();
    final trimmed = note?.trim();
    final p = _submitted(paymentId)
      ..status = 'rejected'
      ..note = trimmed == null || trimmed.isEmpty ? null : trimmed;
    _audit(actor, 'admin.rejected_payment', venueId: p.venueId, detail: {
      'reference': p.reference,
      if (p.note != null) 'note': p.note,
    });
  }

  // ---- platform settings ---------------------------------------------------

  InstapaySettings _instapay() {
    final qr = _store.platformSettings['instapay_qr_url'];
    final payee = _store.platformSettings['instapay_payee'];
    return InstapaySettings(
      qrUrl: qr,
      payee: payee,
      account: _store.platformSettings['instapay_account'],
      configured: qr != null && payee != null,
    );
  }

  @override
  Future<InstapaySettings> instapay() async {
    await _admin();
    return _instapay();
  }

  @override
  Future<InstapaySettings> saveInstapay({
    required String payee,
    required String account,
    List<int>? qrImage,
    bool clearQr = false,
  }) async {
    final actor = await _admin();
    void put(String key, String value) {
      final v = value.trim();
      if (v.isEmpty) {
        _store.platformSettings.remove(key);
      } else {
        _store.platformSettings[key] = v;
      }
    }

    put('instapay_payee', payee);
    put('instapay_account', account);
    if (qrImage != null) {
      put('instapay_qr_url', 'fake://platform/instapay-${_store.nextId('qr')}.png');
    } else if (clearQr) {
      put('instapay_qr_url', '');
    }
    _audit(actor, 'admin.updated_billing_config');
    return _instapay();
  }

  // ---- audit and admins ----------------------------------------------------

  @override
  Future<List<AuditEntry>> audit({int limit = 100}) async {
    await _admin();
    final rows = _store.adminAudit.reversed.take(limit.clamp(1, 200));
    return [
      for (final a in rows)
        AuditEntry(
          id: a.id,
          actorName: _store.userById(a.actorUserId)?.name ?? '',
          actorEmail: _store.userById(a.actorUserId)?.email ?? '',
          action: a.action,
          organizationName: a.venueId == null ? null : _store.venueById(a.venueId!)?.name,
          target: a.target,
          detail: a.detail,
          createdAt: a.createdAt,
        ),
    ];
  }

  @override
  Future<List<PlatformAdminEntry>> admins() async {
    final self = await _admin();
    return [
      for (final id in _store.platformAdmins)
        if (_store.userById(id) case final u?)
          PlatformAdminEntry(
            userId: u.id,
            name: u.name,
            email: u.email,
            grantedAt: u.createdAt,
            isSelf: u.id == self,
          ),
    ];
  }

  @override
  Future<void> revokeAdmin(String userId) async {
    final actor = await _admin();
    if (_store.platformAdmins.where((id) => id != userId).isEmpty) {
      throw ApiError(
        409,
        "That's the last platform admin. Grant someone else first.",
        reason: 'last_admin',
      );
    }
    if (!_store.platformAdmins.remove(userId)) {
      throw ApiError(404, "That person isn't an admin.");
    }
    _audit(actor, 'admin.revoked_admin', target: userId);
  }
}
