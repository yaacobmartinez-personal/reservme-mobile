import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/status_chip.dart';
import '../../../core/theme/typography.dart';
import '../../../core/time/app_time.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/confirm_dialog.dart';
import '../application/admin_controllers.dart';
import '../domain/admin.dart';
import 'widgets/admin_widgets.dart';

/// Who can open this console (API-CONTRACT #41). Revoking happens here;
/// granting does not — making someone a platform admin should take database
/// access (`scripts/grant-admin.ts`), not a phone.
class AdminAdminsScreen extends ConsumerWidget {
  const AdminAdminsScreen({super.key});

  Future<void> _revoke(BuildContext context, WidgetRef ref, PlatformAdminEntry admin) async {
    final ok = await showConfirmDialog(
      context,
      title: admin.isSelf ? 'Remove yourself as an admin?' : 'Revoke ${admin.name ?? admin.email}?',
      message: admin.isSelf
          ? 'You lose this console the next time the app checks — there is no '
              'way back in from here.'
          : 'They lose this console straight away. Their own venues are not affected.',
      confirmLabel: 'Revoke',
      cancelLabel: 'Keep',
      destructive: true,
    );
    if (!ok || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(adminCommandsProvider.notifier).revokeAdmin(admin.userId);
      messenger.showSnackBar(const SnackBar(content: Text('Revoked.')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admins = ref.watch(adminAdminsProvider);
    final p = context.palette;
    return Scaffold(
      appBar: AppBar(title: const Text('Admins')),
      body: AsyncView(
        value: admins,
        onRetry: () => ref.invalidate(adminAdminsProvider),
        data: (list) => ListView(
          padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x8),
          children: [
            AdminGroup(children: [
              for (final a in list)
                ListTile(
                  title: Row(
                    children: [
                      Flexible(child: Text(a.name ?? a.email, overflow: TextOverflow.ellipsis)),
                      if (a.isSelf) ...[
                        const SizedBox(width: Spacing.x2),
                        const StatusChip('You', tone: ChipTone.pine),
                      ],
                    ],
                  ),
                  subtitle: Text(
                    '${a.email} · since ${AppTime.formatDay(a.grantedAt, AppTime.deviceZone)}',
                  ),
                  trailing: list.length > 1
                      ? IconButton(
                          tooltip: 'Revoke',
                          icon: Icon(Icons.person_remove_outlined, color: p.danger),
                          onPressed: () => _revoke(context, ref, a),
                        )
                      : null,
                ),
            ]),
            const SizedBox(height: Spacing.x3),
            Text(
              list.length == 1
                  ? 'The last admin cannot be revoked — that would lock everyone '
                      'out. To add someone, run scripts/grant-admin.ts against the database.'
                  : 'To add someone, run scripts/grant-admin.ts against the database.',
              style: AppType.bodyS.copyWith(color: p.ink3),
            ),
          ],
        ),
      ),
    );
  }
}
