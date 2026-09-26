import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/model/enums.dart';
import '../../../../core/money/money.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/billing_controller.dart';
import '../domain/billing.dart';
import 'widgets/payment_proof_sheet.dart';

/// G4 · Billing. What this venue owes ReservMe, and how to pay it.
///
/// The band is derived from active spaces on every read, so the screen says
/// which band you are in *and why* — pausing a court to save money is a real
/// decision an owner should be able to make deliberately.
class BillingScreen extends ConsumerWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(selectedVenueProvider);
    if (venue == null) {
      return const Scaffold(
        body: EmptyState(
          icon: Icons.storefront_outlined,
          title: 'No venue selected',
          hint: 'Pick a venue first.',
        ),
      );
    }

    final provider = billingControllerProvider(venue.slug);
    final billing = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(title: const Text('Billing')),
      body: AsyncView(
        value: billing,
        onRetry: () => ref.invalidate(provider),
        data: (data) => RefreshIndicator(
          onRefresh: () async => ref.refresh(provider.future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              Spacing.gutter,
              0,
              Spacing.gutter,
              Spacing.x8,
            ),
            children: [
              _Status(billing: data, timezone: venue.timezone),
              const SizedBox(height: Spacing.x3),
              _Band(billing: data, currency: venue.currency),
              const SizedBox(height: Spacing.x3),
              _Pay(billing: data, venueSlug: venue.slug, venue: venue.timezone),
              if (data.history.isNotEmpty) ...[
                const SizedBox(height: Spacing.x3),
                _History(
                  billing: data,
                  currency: venue.currency,
                  timezone: venue.timezone,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({required this.billing, required this.timezone});

  final Billing billing;
  final String timezone;

  @override
  Widget build(BuildContext context) {
    if (billing.suspended) {
      return const AppBanner(
        kind: BannerKind.error,
        title: 'Your booking page is switched off',
        body: 'Nobody can book until a payment is approved. Existing bookings '
            'are untouched.',
      );
    }
    if (billing.pendingPayment != null) {
      return const AppBanner(
        kind: BannerKind.info,
        title: 'Payment under review',
        body: 'We usually confirm within a working day. Nothing to do.',
      );
    }
    if (billing.dueNow) {
      return AppBanner(
        kind: BannerKind.warn,
        title: 'Payment is due',
        body: 'Your booking page stays live for ${Billing.graceDays} days, '
            'then it is switched off until you pay.',
      );
    }
    if (billing.status == BillingStatus.comped) {
      return const AppBanner(
        kind: BannerKind.success,
        title: 'On the house',
        body: 'Nothing to pay. Enjoy.',
      );
    }
    if (billing.daysLeftInTrial case final days?) {
      return AppBanner(
        kind: days <= 5 ? BannerKind.warn : BannerKind.success,
        title: days == 0
            ? 'Your free month ends today'
            : days == 1
                ? 'One day left of your free month'
                : '$days days left of your free month',
        body: 'Free until '
            '${AppTime.formatLongDay(billing.trialEndsAt, timezone)}.',
      );
    }
    if (billing.paidUntil case final until?) {
      return AppBanner(
        kind: BannerKind.success,
        title: 'Paid up',
        body: 'Covered until ${AppTime.formatLongDay(until, timezone)}.',
      );
    }
    return const SizedBox.shrink();
  }
}

class _Band extends StatelessWidget {
  const _Band({required this.billing, required this.currency});

  final Billing billing;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final band = billing.band;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YOUR PLAN',
            style: AppType.captionStrong.copyWith(color: p.ink3),
          ),
          const SizedBox(height: Spacing.x2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(band.name, style: AppType.displayAt(30)),
                    Text(
                      band.blurb,
                      style: AppType.bodyS.copyWith(color: p.ink3),
                    ),
                  ],
                ),
              ),
              Text(
                billing.isQuoted
                    ? 'By quote'
                    : '${Money.format(billing.amountDueCents!, currency: currency)}/mo',
                style: AppType.bodyStrong,
              ),
            ],
          ),
          const SizedBox(height: Spacing.x3),
          // The one genuinely surprising rule on this screen.
          Container(
            padding: const EdgeInsets.all(Spacing.x3),
            decoration: BoxDecoration(
              color: p.paper2,
              borderRadius: BorderRadius.circular(Radii.sm),
            ),
            child: Text(
              billing.activeSpaces == 1
                  ? 'You have 1 space on sale, which puts you in ${band.name} '
                      '(${band.spread}). Pausing a space drops your band from '
                      'the next read — you are billed for what is bookable, '
                      'not what you own.'
                  : 'You have ${billing.activeSpaces} spaces on sale, which '
                      'puts you in ${band.name} (${band.spread}). Pausing a '
                      'space drops your band from the next read — you are '
                      'billed for what is bookable, not what you own.',
              style: AppType.bodyS.copyWith(color: p.ink2),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pay extends ConsumerWidget {
  const _Pay({
    required this.billing,
    required this.venueSlug,
    required this.venue,
  });

  final Billing billing;
  final String venueSlug;
  final String venue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;

    if (billing.isQuoted) {
      return AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('HOW TO PAY',
                style: AppType.captionStrong.copyWith(color: p.ink3)),
            const SizedBox(height: Spacing.x2),
            Text(
              'Multi-site venues are quoted rather than banded. Get in touch '
              'and we will sort out a price.',
              style: AppType.bodyS.copyWith(color: p.ink2),
            ),
          ],
        ),
      );
    }

    final instapay = billing.instapay;
    final pending = billing.pendingPayment != null;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('HOW TO PAY',
              style: AppType.captionStrong.copyWith(color: p.ink3)),
          const SizedBox(height: Spacing.x2),
          if (instapay?.configured ?? false) ...[
            Text(
              'Transfer '
              '${Money.format(billing.amountDueCents!, currency: 'PHP')} by '
              'InstaPay to ${instapay!.payee}'
              '${instapay.account == null ? '' : ' (${instapay.account})'}, '
              'then tell us the reference so we can match it.',
              style: AppType.bodyS.copyWith(color: p.ink2),
            ),
          ] else
            Text(
              'Payment details are being set up. Nothing is switched off in '
              'the meantime.',
              style: AppType.bodyS.copyWith(color: p.ink2),
            ),
          const SizedBox(height: Spacing.x3),
          FilledButton(
            onPressed: pending ? null : () => _submit(context, ref),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: Text(
              pending ? 'Payment under review' : "I've paid — tell us",
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context, WidgetRef ref) async {
    final submission = await showPaymentProofSheet(
      context,
      amountCents: billing.amountDueCents!,
      timezone: venue,
    );
    if (submission == null || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(billingControllerProvider(venueSlug).notifier)
          .submitProof(submission.input, receipt: submission.receipt);
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Thanks — we will confirm within a working day.'),
        ),
      );
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }
}

class _History extends StatelessWidget {
  const _History({
    required this.billing,
    required this.currency,
    required this.timezone,
  });

  final Billing billing;
  final String currency;
  final String timezone;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('WHAT YOU HAVE SENT',
              style: AppType.captionStrong.copyWith(color: p.ink3)),
          const SizedBox(height: Spacing.x2),
          for (final payment in billing.history)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Money.format(payment.amountCents, currency: currency),
                          style: AppType.bodyStrong,
                        ),
                        Text(
                          'Ref ${payment.reference} · paid ${payment.paidAt}',
                          style: AppType.bodyS.copyWith(color: p.ink3),
                        ),
                        if (payment.note case final note?)
                          Text(
                            note,
                            style: AppType.bodyS.copyWith(color: p.danger),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    payment.status.label,
                    style: AppType.bodyS.copyWith(
                      color: switch (payment.status) {
                        PaymentStatus.approved => p.pineInk,
                        PaymentStatus.rejected => p.danger,
                        PaymentStatus.submitted => p.ink3,
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
