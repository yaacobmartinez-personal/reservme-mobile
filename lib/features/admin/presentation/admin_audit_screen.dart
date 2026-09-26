import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/status_chip.dart';
import '../../../core/theme/typography.dart';
import '../../../core/time/app_time.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/empty_state.dart';
import '../application/admin_controllers.dart';
import 'widgets/admin_widgets.dart';

/// Every privileged action, newest first, attributed to the real person
/// (API-CONTRACT #41). Read-only: an audit trail you can edit is not one.
class AdminAuditScreen extends ConsumerWidget {
  const AdminAuditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audit = ref.watch(adminAuditProvider);
    final p = context.palette;
    return Scaffold(
      appBar: AppBar(title: const Text('Audit trail')),
      body: AsyncView(
        value: audit,
        onRetry: () => ref.invalidate(adminAuditProvider),
        data: (entries) => entries.isEmpty
            ? const EmptyState(
                icon: Icons.history_rounded,
                title: 'Nothing yet',
                hint: 'Approvals, suspensions and the rest appear here as they happen.',
              )
            : RefreshIndicator(
                onRefresh: () async => ref.refresh(adminAuditProvider.future),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x8),
                  children: [
                    AdminGroup(children: [
                      for (final e in entries)
                        ListTile(
                          title: Text(
                            e.organizationName == null ? e.label : '${e.label} · ${e.organizationName}',
                          ),
                          subtitle: Text(
                            [
                              e.actorName.isEmpty ? e.actorEmail : e.actorName,
                              '${AppTime.formatDay(e.createdAt, AppTime.deviceZone)} '
                                  '${AppTime.formatTime(e.createdAt, AppTime.deviceZone)}',
                              ?e.summary,
                            ].join(' · '),
                            style: AppType.bodyS.copyWith(color: p.ink3),
                          ),
                          trailing: e.impersonating
                              ? const StatusChip('As venue', tone: ChipTone.warn)
                              : null,
                        ),
                    ]),
                  ],
                ),
              ),
      ),
    );
  }
}
