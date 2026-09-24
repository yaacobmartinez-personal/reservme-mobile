import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../auth/application/auth_controller.dart';
import 'widgets/delete_account_sheet.dart';

/// G7 · Your account. Who you are signed in as, which venues you work at,
/// and the two things you can do to the account itself: change your password,
/// or delete it.
///
/// Deletion is a store requirement now that sign-up happens in the app, and
/// it is the one screen where the refusal matters more than the action: a
/// venue whose only owner leaves has nobody who can pay for it or hand it on.
class OwnerAccountScreen extends ConsumerWidget {
  const OwnerAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final user = auth.userOrNull;
    final p = context.palette;

    if (user == null) {
      return const Scaffold(
        body: EmptyState(
          icon: Icons.person_outline_rounded,
          title: 'Not signed in',
          hint: 'Sign in to see your account.',
        ),
      );
    }

    final venues = auth.venuesOrEmpty;
    final soleOwnerOf = [
      for (final v in venues)
        if (v.role == VenueRole.owner) v.name,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Your account')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          Spacing.gutter,
          0,
          Spacing.gutter,
          Spacing.x8,
        ),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SIGNED IN AS',
                  style: AppType.captionStrong.copyWith(color: p.ink3),
                ),
                const SizedBox(height: Spacing.x2),
                Text(user.name ?? user.email, style: AppType.displayAt(24)),
                Text(
                  user.email,
                  style: AppType.bodyS.copyWith(color: p.ink3),
                ),
                if (!user.emailVerified) ...[
                  const SizedBox(height: Spacing.x3),
                  const AppBanner(
                    kind: BannerKind.warn,
                    title: 'Your email is not verified',
                    body: 'Verify it so we can reach you about bookings and '
                        'billing.',
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: Spacing.x3),

          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WHERE YOU WORK',
                  style: AppType.captionStrong.copyWith(color: p.ink3),
                ),
                const SizedBox(height: Spacing.x2),
                if (venues.isEmpty)
                  Text(
                    'You do not belong to a venue yet.',
                    style: AppType.bodyS.copyWith(color: p.ink3),
                  )
                else
                  for (final venue in venues)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              venue.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppType.bodyStrong,
                            ),
                          ),
                          Text(
                            venue.role.label,
                            style: AppType.bodyS.copyWith(color: p.ink3),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.x3),

          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.lock_outline_rounded),
                  title: const Text('Change your password'),
                  subtitle: const Text('We email you a code'),
                  onTap: () => _changePassword(context, ref, user.email),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('Sign out'),
                  onTap: () =>
                      ref.read(authControllerProvider.notifier).signOut(),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.x5),

          Text(
            'DANGER',
            style: AppType.captionStrong.copyWith(color: p.ink3),
          ),
          const SizedBox(height: Spacing.x2),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: p.danger,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () => _delete(context, ref, soleOwnerOf),
            child: const Text('Delete your account'),
          ),
          const SizedBox(height: Spacing.x2),
          Text(
            'Deleting removes you and the notes you wrote. Bookings belong to '
            'the venue and stay with it.',
            style: AppType.bodyS.copyWith(color: p.ink3),
          ),
          const SizedBox(height: Spacing.x5),
          Text(
            '${AppConfig.appName} ${AppConfig.appVersion}',
            style: AppType.bodyS.copyWith(color: p.ink3),
          ),
        ],
      ),
    );
  }

  /// Changing a password is the reset flow with the address already known —
  /// there is no second mechanism to keep working.
  Future<void> _changePassword(
    BuildContext context,
    WidgetRef ref,
    String email,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      await ref.read(authControllerProvider.notifier).requestPasswordReset(email);
      unawaited(router.push(Routes.resetPassword(email)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    List<String> ownerOf,
  ) async {
    final confirmed = await showDeleteAccountSheet(context, ownerOf: ownerOf);
    if (!confirmed || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(authControllerProvider.notifier).deleteAccount();
      messenger.showSnackBar(
        const SnackBar(content: Text('Your account is gone. Take care.')),
      );
    } catch (e) {
      // The sole-owner refusal is the whole point of this screen, so it gets
      // a dialog rather than a snackbar that slides away unread.
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('We cannot delete it yet'),
          content: Text(AsyncView.messageFor(e)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
