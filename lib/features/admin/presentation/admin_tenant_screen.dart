import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/model/enums.dart';
import '../../../core/money/money.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/status_chip.dart';
import '../../../core/theme/typography.dart';
import '../../../core/time/app_time.dart';
import '../../../core/ui/app_banner.dart';
import '../../../core/ui/primitives.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../application/admin_controllers.dart';
import '../domain/admin.dart';
import 'widgets/admin_prompts.dart';
import 'widgets/admin_widgets.dart';

/// One venue, as the console sees it (API-CONTRACT #36), and everything an
/// admin can do to it (#37, #38): suspend or reactivate, email the owner, and
/// the billing overrides.
class AdminTenantScreen extends ConsumerStatefulWidget {
  const AdminTenantScreen({super.key, required this.orgId});

  final String orgId;

  @override
  ConsumerState<AdminTenantScreen> createState() => _AdminTenantScreenState();
}

class _AdminTenantScreenState extends ConsumerState<AdminTenantScreen> {
  bool _busy = false;

  AdminCommands get _commands => ref.read(adminCommandsProvider.notifier);

  /// Runs one action with the buttons held, and says how it went.
  Future<void> _run(Future<void> Function() action, String done) async {
    if (_busy) return;
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
      messenger.showSnackBar(SnackBar(content: Text(done)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _suspend(TenantDetailSummary t) async {
    final reason = await showAdminTextPrompt(
      context,
      title: 'Suspend ${t.name}?',
      message: 'Their booking page stops taking bookings. Bookings already '
          'made stay, and the owner can still sign in.',
      label: 'Reason (kept in the audit trail)',
      confirmLabel: 'Suspend',
      destructive: true,
    );
    if (reason == null || !mounted) return;
    await _run(
      () => _commands.suspend(t.orgId, reason: reason.isEmpty ? null : reason),
      '${t.name} is suspended.',
    );
  }

  Future<void> _reactivate(TenantDetailSummary t) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Reactivate ${t.name}?',
      message: t.billingSuspended
          ? 'This was switched off for non-payment. Reactivating puts the page back '
              'without recording a payment — mark it paid or comp it if that is '
              'what happened.'
          : 'Their booking page takes bookings again.',
      confirmLabel: 'Reactivate',
      cancelLabel: 'Keep it off',
    );
    if (!ok || !mounted) return;
    await _run(() => _commands.reactivate(t.orgId), '${t.name} is live again.');
  }

  Future<void> _email(TenantDetailSummary t) async {
    final message = await showEmailOwnerSheet(context, venueName: t.name);
    if (message == null || !mounted) return;
    await _run(
      () => _commands.emailOwner(t.orgId, subject: message.subject, body: message.body),
      'Email sent.',
    );
  }

  Future<void> _markPaid(TenantDetailSummary t) async {
    // Offer a month past whichever is later — today, or the last day already
    // paid for — the same base an approved payment extends from. A month past
    // a lapsed date would mark an overdue venue paid for time already gone.
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastPaid = t.paidUntil?.toUtc().subtract(const Duration(seconds: 1));
    final lastPaidDay =
        lastPaid == null ? null : DateTime(lastPaid.year, lastPaid.month, lastPaid.day);
    final base = lastPaidDay != null && lastPaidDay.isAfter(today) ? lastPaidDay : today;
    final picked = await showDatePicker(
      context: context,
      helpText: 'Paid through',
      initialDate: DateTime(base.year, base.month + 1, base.day),
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
    );
    if (picked == null || !mounted) return;
    final day = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-'
        '${picked.day.toString().padLeft(2, '0')}';
    await _run(
      () => _commands.overrideBilling(t.orgId, MarkPaid(day)),
      'Paid through ${AppTime.formatDay(DateTime.utc(picked.year, picked.month, picked.day, 12), 'UTC')}.',
    );
  }

  Future<void> _comp(TenantDetailSummary t) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Comp ${t.name}?',
      message: 'They stop being billed, and a suspension for non-payment lifts. '
          'Undo it by marking them paid or cancelling.',
      confirmLabel: 'Comp',
    );
    if (!ok || !mounted) return;
    await _run(() => _commands.overrideBilling(t.orgId, const Comp()), '${t.name} is comped.');
  }

  Future<void> _cancel(TenantDetailSummary t) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Cancel their subscription?',
      message: 'Billing stops for ${t.name}. Their page stays up unless you '
          'suspend it too.',
      confirmLabel: 'Cancel subscription',
      cancelLabel: 'Keep it',
      destructive: true,
    );
    if (!ok || !mounted) return;
    await _run(
      () => _commands.overrideBilling(t.orgId, const CancelSubscription()),
      'Subscription cancelled.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = adminTenantProvider(widget.orgId);
    final detail = ref.watch(provider);
    return Scaffold(
      appBar: AppBar(title: Text(detail.value?.tenant.name ?? 'Venue')),
      body: AsyncView(
        value: detail,
        onRetry: () => ref.invalidate(provider),
        data: (data) => RefreshIndicator(
          onRefresh: () async => ref.refresh(provider.future),
          child: _content(context, data),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, TenantDetail data) {
    final p = context.palette;
    final t = data.tenant;
    final zone = t.timezone;
    String day(DateTime d) => AppTime.formatDay(d, zone);

    return ListView(
      padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x8),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'reservme.pro/${t.slug}',
                style: AppType.bodyS.copyWith(color: p.ink3),
              ),
            ),
            TenantStatusChip(
              suspended: t.suspended,
              billingSuspended: t.billingSuspended,
              subscription: t.subscription,
            ),
          ],
        ),
        if (t.suspended) ...[
          const SizedBox(height: Spacing.x3),
          AppBanner(
            kind: BannerKind.error,
            title: t.billingSuspended ? 'Switched off for non-payment' : 'Suspended',
            body: [
              if (t.suspendedAt != null) 'Since ${day(t.suspendedAt!)}.',
              if (!t.billingSuspended && t.suspendedReason != null) '"${t.suspendedReason}"',
              if (t.billingSuspended) 'An approved payment, marking paid, or a comp brings it back.',
            ].join(' '),
          ),
        ],
        const SizedBox(height: Spacing.x3),
        KpiRows(
          tiles: [
            KpiTile(value: '${t.activeSpaces}', label: 'Active spaces'),
            KpiTile(value: '${t.bookingsLast30}', label: 'Bookings · 30d'),
            KpiTile(
              value: Money.compact(t.revenueLast30Cents, currency: t.currency),
              label: 'Value · 30d',
            ),
          ],
        ),

        const AdminSection('BILLING'),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _line(context, 'Plan', bandLine(t.band)),
              _line(context, 'Status', billingStatusLabel(t.subscription.status)),
              if (t.subscription.status == BillingStatus.trialing && t.trialEndsAt != null)
                _line(context, 'Trial ends', day(t.trialEndsAt!)),
              // Stored as the instant it runs out — midnight UTC after the last
              // paid day when marked by hand — so the day before, read in UTC,
              // is the one that was paid for.
              if (t.paidUntil != null)
                _line(
                  context,
                  'Paid through',
                  AppTime.formatDay(t.paidUntil!.subtract(const Duration(seconds: 1)), 'UTC'),
                ),
              const SizedBox(height: Spacing.x2),
              Wrap(
                spacing: Spacing.x2,
                runSpacing: Spacing.x2,
                children: [
                  OutlinedButton(
                    onPressed: _busy ? null : () => _markPaid(t),
                    child: const Text('Mark paid'),
                  ),
                  if (t.subscription.status != BillingStatus.comped)
                    OutlinedButton(
                      onPressed: _busy ? null : () => _comp(t),
                      child: const Text('Comp'),
                    ),
                  if (t.subscription.status != BillingStatus.cancelled)
                    TextButton(
                      onPressed: _busy ? null : () => _cancel(t),
                      style: TextButton.styleFrom(foregroundColor: p.danger),
                      child: const Text('Cancel subscription'),
                    ),
                ],
              ),
            ],
          ),
        ),

        const AdminSection('ACCESS'),
        AdminGroup(children: [
          if (t.suspended)
            ListTile(
              leading: Icon(Icons.play_circle_outline_rounded, color: p.pineInk),
              title: const Text('Reactivate'),
              subtitle: const Text('Put their booking page back'),
              enabled: !_busy,
              onTap: () => _reactivate(t),
            )
          else
            ListTile(
              leading: Icon(Icons.block_rounded, color: p.danger),
              title: Text('Suspend', style: AppType.bodyStrong.copyWith(color: p.danger)),
              subtitle: const Text('Stop new bookings; existing ones stay'),
              enabled: !_busy,
              onTap: () => _suspend(t),
            ),
          ListTile(
            leading: Icon(Icons.mail_outline_rounded, color: p.ink3),
            title: const Text('Email the owner'),
            enabled: !_busy,
            onTap: () => _email(t),
          ),
        ]),

        if (data.payments.isNotEmpty) ...[
          const AdminSection('PAYMENTS'),
          AdminGroup(children: [
            for (final pay in data.payments)
              ListTile(
                title: Text(Money.format(pay.amountCents, currency: t.currency)),
                subtitle: Text(
                  [
                    'Ref ${pay.reference}',
                    'paid ${AppTime.formatDay(pay.paidAt, 'UTC')}',
                    if (pay.note != null) '"${pay.note}"',
                  ].join(' · '),
                ),
                trailing: StatusChip(
                  switch (pay.status) {
                    'approved' => 'Approved',
                    'rejected' => 'Rejected',
                    _ => 'To review',
                  },
                  tone: switch (pay.status) {
                    'approved' => ChipTone.pine,
                    'rejected' => ChipTone.danger,
                    _ => ChipTone.warn,
                  },
                ),
              ),
          ]),
        ],

        const AdminSection('PEOPLE'),
        if (data.members.isEmpty)
          Text('Nobody — this venue has no members.', style: AppType.bodyS.copyWith(color: p.ink3))
        else
          AdminGroup(children: [
            for (final m in data.members)
              ListTile(
                title: Text(m.name ?? m.email),
                subtitle: Text(m.name == null ? 'Joined ${day(m.joinedAt)}' : m.email),
                trailing: StatusChip(switch (m.role) {
                  'owner' => 'Owner',
                  'admin' => 'Admin',
                  _ => 'Staff',
                }),
              ),
          ]),

        const AdminSection('SPACES'),
        if (data.spaces.isEmpty)
          Text('No spaces yet.', style: AppType.bodyS.copyWith(color: p.ink3))
        else
          AdminGroup(children: [
            for (final s in data.spaces)
              ListTile(
                title: Text(s.name),
                subtitle: Text(Money.format(s.priceCents, currency: t.currency)),
                trailing: s.active ? null : const StatusChip('Paused'),
              ),
          ]),

        if (data.recentBookings.isNotEmpty) ...[
          const AdminSection('RECENT BOOKINGS'),
          AdminGroup(children: [
            for (final b in data.recentBookings)
              ListTile(
                dense: true,
                title: Text('${b.label} · ${b.spaceName}'),
                subtitle: Text([b.reference, if (b.customerName != null) b.customerName!].join(' · ')),
                trailing: Text(
                  Money.format(b.amountCents, currency: t.currency),
                  style: AppType.label,
                ),
              ),
          ]),
        ],
        const SizedBox(height: Spacing.x3),
        Text(
          'On ReservMe since ${day(t.createdAt)} · ${t.timezone}',
          style: AppType.caption.copyWith(color: p.ink3),
        ),
      ],
    );
  }

  Widget _line(BuildContext context, String label, String value) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: AppType.bodyS.copyWith(color: p.ink3)),
          ),
          Expanded(child: Text(value, style: AppType.body)),
        ],
      ),
    );
  }
}
