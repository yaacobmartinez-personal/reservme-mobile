import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/money/money.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/app_banner.dart';
import '../../../core/ui/primitives.dart';
import '../../../core/widgets/async_view.dart';
import '../application/admin_controllers.dart';
import '../domain/admin.dart';
import 'widgets/admin_widgets.dart';

/// The platform-admin console's front page (API-CONTRACT #35): the numbers,
/// the payments waiting on someone, the venues that need an eye, and the way
/// into everything else.
class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overview = ref.watch(adminOverviewProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Platform admin')),
      body: AsyncView(
        value: overview,
        onRetry: () => ref.invalidate(adminOverviewProvider),
        data: (data) => RefreshIndicator(
          onRefresh: () async => ref.refresh(adminOverviewProvider.future),
          child: _Body(data: data),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.data});

  final AdminOverview data;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final t = data.totals;
    final radar = data.radar;
    final thisMonth = data.growth.isEmpty ? null : data.growth.last;

    Widget nav(IconData icon, String title, String? subtitle, String route, {Widget? trailing}) =>
        ListTile(
          leading: Icon(icon, color: p.ink3),
          title: Text(title),
          subtitle: subtitle == null ? null : Text(subtitle),
          trailing: trailing ?? const Icon(Icons.chevron_right_rounded),
          onTap: () => context.push(route),
        );

    return ListView(
      padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x8),
      children: [
        if (data.pendingPayments > 0) ...[
          AppBanner(
            kind: BannerKind.warn,
            title: data.pendingPayments == 1
                ? '1 payment to review'
                : '${data.pendingPayments} payments to review',
            body: 'Venues are waiting on these to stay live.',
            actionLabel: 'Review',
            onAction: () => context.push(Routes.adminPayments),
          ),
          const SizedBox(height: Spacing.x3),
        ],
        KpiRows(
          tiles: [
            KpiTile(value: '${t.tenants}', label: 'Venues', dark: true),
            KpiTile(value: Money.compact(t.runRateCents), label: 'Run rate / mo'),
            KpiTile(value: '${t.suspended}', label: 'Suspended'),
            KpiTile(value: '${t.activeSpaces}', label: 'Active spaces'),
            KpiTile(value: '${t.bookingsLast30}', label: 'Bookings · 30d'),
            KpiTile(value: '${t.customers}', label: 'Customers'),
          ],
        ),
        if (thisMonth != null) ...[
          const SizedBox(height: Spacing.x2),
          Text(
            thisMonth.signups == 1
                ? '1 new venue this month · ${thisMonth.cumulative} in all'
                : '${thisMonth.signups} new venues this month · ${thisMonth.cumulative} in all',
            style: AppType.caption.copyWith(color: p.ink3),
          ),
        ],
        const AdminSection('NEEDS AN EYE'),
        if (radar.isQuiet)
          Text(
            'Nothing right now: no trials about to end, nobody overdue.',
            style: AppType.bodyS.copyWith(color: p.ink3),
          )
        else ...[
          if (radar.inGrace.isNotEmpty) _RadarGroup('Overdue, still live', radar.inGrace),
          if (radar.suspended.isNotEmpty) _RadarGroup('Switched off for non-payment', radar.suspended),
          if (radar.endingSoon.isNotEmpty) _RadarGroup('Trial ends within 5 days', radar.endingSoon),
        ],
        const AdminSection('CONSOLE'),
        AdminGroup(children: [
          nav(Icons.storefront_outlined, 'Venues', 'Every tenant, and what you can do to one',
              Routes.adminTenants),
          nav(
            Icons.receipt_long_outlined,
            'Payments to review',
            null,
            Routes.adminPayments,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (data.pendingPayments > 0)
                  Text('${data.pendingPayments}', style: AppType.bodyStrong.copyWith(color: p.clayInk)),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
          nav(Icons.qr_code_2_rounded, 'InstaPay details', 'Where venues send their transfers',
              Routes.adminInstapay),
          nav(Icons.history_rounded, 'Audit trail', 'Every admin action, and who took it',
              Routes.adminAudit),
          nav(Icons.admin_panel_settings_outlined, 'Admins', null, Routes.adminAdmins),
        ]),
      ],
    );
  }
}

class _RadarGroup extends StatelessWidget {
  const _RadarGroup(this.title, this.tenants);

  final String title;
  final List<TenantSummary> tenants;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppType.label.copyWith(color: p.ink2)),
          const SizedBox(height: Spacing.x1),
          AdminGroup(children: [
            for (final t in tenants)
              TenantTile(tenant: t, onTap: () => context.push(Routes.adminTenant(t.orgId))),
          ]),
        ],
      ),
    );
  }
}
