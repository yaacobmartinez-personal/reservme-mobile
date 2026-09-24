import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../domain/billing.dart';

/// In-memory [BillingRepository], ported from `src/lib/billing.ts` and
/// `src/app/app/billing-actions.ts`.
///
/// The band is derived on every read from the *active* space count, never
/// stored — pausing a space for the off-season drops a band with no write.
class FakeBillingRepository implements BillingRepository {
  FakeBillingRepository(
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

  /// Where the platform takes transfers. One setting for everybody, so it
  /// lives here rather than on the venue.
  static const _instapay = InstapayDetails(
    qrUrl: 'fake://platform/instapay.png',
    payee: 'ReservMe Technologies Inc.',
    account: '0917 000 0000',
  );

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  FakeVenue _venue(String slug) {
    final v = _store.venueBySlug(slug);
    if (v == null) throw ApiError(404, 'We could not find that venue.');
    return v;
  }

  /// `requireRole("owner", "admin")` — billing is never the front desk's job.
  void _requireManage(String slug) {
    final role = _roleFor(slug);
    if (role == null || !role.atLeast(VenueRole.admin)) {
      throw ApiError(403, 'Only an owner or admin can look after billing.');
    }
  }

  @override
  Future<Billing> get(String venueSlug) async {
    await _tick();
    _requireManage(venueSlug);
    return _view(_venue(venueSlug));
  }

  @override
  Future<Billing> submitProof(
    String venueSlug,
    PaymentProofInput input, {
    List<int>? receipt,
  }) async {
    await _tick();
    _requireManage(venueSlug);
    final venue = _venue(venueSlug);
    final refusal = input.validate();
    if (refusal != null) throw ApiError(400, refusal);

    final state = _view(venue);
    if (state.amountDueCents == null) {
      throw ApiError(400, 'Your plan is billed by quote — please contact us.');
    }
    if (state.pendingPayment != null) {
      throw ApiError(409, 'You already have a payment under review.');
    }
    if (receipt != null && receipt.length > _maxImageBytes) {
      throw ApiError(413, 'That screenshot is too large — keep it under 2 MB.');
    }

    // The amount comes from the band, never from the form: what a venue owes
    // is not something it gets to declare.
    _store.billingPayments.add(FakeBillingPayment(
      id: _store.nextId('pay'),
      venueId: venue.id,
      amountCents: state.amountDueCents!,
      reference: input.reference.trim(),
      paidAt: input.paidAt,
      createdAt: _clock(),
    ));

    return _view(venue);
  }

  static const _maxImageBytes = 2 * 1024 * 1024;

  Billing _view(FakeVenue venue) {
    final now = _clock();
    final sub = _store.subscriptionOf(venue.id);
    final status = sub?.status ?? BillingStatus.trialing;

    // A missing subscription row falls back to a month from the venue's own
    // creation, rather than writing on a read path.
    final trialEndsAt =
        sub?.trialEndsAt ?? venue.createdAt.add(const Duration(days: 30));
    final paidUntil = sub?.paidUntil;

    final activeSpaces =
        _store.spacesOf(venue.id, activeOnly: true).length;
    final band = PlanBand.forSpaces(activeSpaces);

    final dueNow = (status == BillingStatus.trialing && now.isAfter(trialEndsAt)) ||
        ((status == BillingStatus.active || status == BillingStatus.pastDue) &&
            paidUntil != null &&
            now.isAfter(paidUntil));

    final payments = [
      for (final p in _store.paymentsOf(venue.id))
        BillingPayment(
          id: p.id,
          amountCents: p.amountCents,
          reference: p.reference,
          paidAt: p.paidAt,
          status: _status(p.status),
          note: p.note,
          createdAt: p.createdAt,
        ),
    ];

    return Billing(
      status: status,
      band: band,
      activeSpaces: activeSpaces,
      trialEndsAt: trialEndsAt,
      paidUntil: paidUntil,
      // `GREATEST(0, CEIL(...))`, and only while trialing.
      daysLeftInTrial: status == BillingStatus.trialing
          ? _wholeDaysUntil(trialEndsAt, now)
          : null,
      dueNow: dueNow,
      // Only a suspension billing itself created counts here; a manual or
      // abuse suspension is not something paying will lift.
      suspended: venue.suspended && venue.suspendedReason == Billing.suspendReason,
      pendingPayment: payments
          .where((p) => p.status == PaymentStatus.submitted)
          .firstOrNull,
      history: payments,
      instapay: _instapay,
    );
  }

  static int _wholeDaysUntil(DateTime then, DateTime now) {
    final seconds = then.difference(now).inSeconds;
    if (seconds <= 0) return 0;
    return (seconds / 86400).ceil();
  }

  static PaymentStatus _status(String wire) => PaymentStatus.values
      .firstWhere((s) => s.wire == wire, orElse: () => PaymentStatus.submitted);
}

/// Formatting helper the screen leans on: the day a trial or paid period
/// runs out, in the venue's own zone.
String billingDayLabel(DateTime instant, String timezone) =>
    AppTime.formatLongDay(instant, timezone);
