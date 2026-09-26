import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/money/money.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/time/app_time.dart';
import '../../../core/ui/primitives.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../application/admin_controllers.dart';
import '../domain/admin.dart';
import 'widgets/admin_prompts.dart';
import 'widgets/admin_widgets.dart';

/// The verification queue (API-CONTRACT #39): transfers venues say they made,
/// oldest first, to match against the bank statement by hand.
class AdminPaymentsScreen extends ConsumerWidget {
  const AdminPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queue = ref.watch(adminPaymentQueueProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Payments to review')),
      body: AsyncView(
        value: queue,
        onRetry: () => ref.invalidate(adminPaymentQueueProvider),
        data: (payments) => payments.isEmpty
            ? const EmptyState(
                icon: Icons.task_alt_rounded,
                title: 'Nothing to review',
                hint: 'When a venue submits a transfer, it lands here.',
              )
            : RefreshIndicator(
                onRefresh: () async => ref.refresh(adminPaymentQueueProvider.future),
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x8),
                  itemCount: payments.length,
                  separatorBuilder: (_, _) => const SizedBox(height: Spacing.x3),
                  itemBuilder: (_, i) => _PaymentCard(payment: payments[i]),
                ),
              ),
      ),
    );
  }
}

class _PaymentCard extends ConsumerStatefulWidget {
  const _PaymentCard({required this.payment});

  final AdminPayment payment;

  @override
  ConsumerState<_PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends ConsumerState<_PaymentCard> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() action, String done) async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
      messenger.showSnackBar(SnackBar(content: Text(done)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
      if (mounted) setState(() => _busy = false);
    }
    // On success the card leaves the queue; nothing to reset.
  }

  Future<void> _approve() async {
    final pay = widget.payment;
    final ok = await showConfirmDialog(
      context,
      title: 'Approve ${Money.format(pay.amountCents)}?',
      message: 'Only once you have found reference ${pay.reference} on the '
          'statement. ${pay.venueName ?? 'The venue'} is paid up a month from '
          'whichever is later: today, or what they had already paid for.',
      confirmLabel: 'Approve',
      cancelLabel: 'Not yet',
    );
    if (!ok || !mounted) return;
    await _run(
      () => ref.read(adminCommandsProvider.notifier).approvePayment(pay),
      'Approved. ${pay.venueName ?? 'The venue'} is paid up.',
    );
  }

  Future<void> _reject() async {
    final pay = widget.payment;
    final note = await showAdminTextPrompt(
      context,
      title: 'Reject this payment?',
      message: 'The owner sees your note on their billing screen, so say what '
          'to do next.',
      label: 'Note to the owner',
      confirmLabel: 'Reject',
      destructive: true,
      maxLength: 500,
    );
    if (note == null || !mounted) return;
    await _run(
      () => ref
          .read(adminCommandsProvider.notifier)
          .rejectPayment(pay, note: note.isEmpty ? null : note),
      'Rejected.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final pay = widget.payment;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: pay.orgId == null ? null : () => context.push(Routes.adminTenant(pay.orgId!)),
                  child: Text(pay.venueName ?? 'Unknown venue', style: AppType.bodyStrong),
                ),
              ),
              Text(Money.format(pay.amountCents), style: AppType.numeral),
            ],
          ),
          const SizedBox(height: Spacing.x1),
          Text(
            'Ref ${pay.reference} · paid ${AppTime.formatDay(pay.paidAt, 'UTC')} · '
            'sent ${AppTime.formatDay(pay.createdAt, AppTime.deviceZone)}',
            style: AppType.bodyS.copyWith(color: p.ink3),
          ),
          if (pay.receiptUrl != null) ...[
            const SizedBox(height: Spacing.x3),
            AdminImage(url: pay.receiptUrl!, height: 220),
          ] else ...[
            const SizedBox(height: Spacing.x2),
            Text('No screenshot attached.', style: AppType.caption.copyWith(color: p.ink3)),
          ],
          const SizedBox(height: Spacing.x3),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _busy ? null : _reject,
                  style: OutlinedButton.styleFrom(foregroundColor: p.danger),
                  child: const Text('Reject'),
                ),
              ),
              const SizedBox(width: Spacing.x2),
              Expanded(
                child: FilledButton(
                  onPressed: _busy ? null : _approve,
                  child: const Text('Approve'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
