import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/api_mode.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/primitives.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../settings/application/appearance_controller.dart';
import '../../../shell/application/app_mode_controller.dart';

/// C12 · Account. Phase 0 ships appearance, the venue-mode hand-off and the
/// fake-mode demo sign-in; saved contact details and data deletion arrive
/// with Phase 1.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final auth = ref.watch(authControllerProvider);
    final appearance = ref.watch(appearanceControllerProvider);
    final apiMode = ref.watch(apiModeProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: Spacing.x6),
          children: [
            const BigHeader(eyebrow: 'No account needed', title: 'You'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.gutter),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Eyebrow('Preferences'),
                  const SizedBox(height: Spacing.x2),
                  AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.dark_mode_outlined),
                          title: const Text('Appearance'),
                          trailing: SegmentedButton<ThemeMode>(
                            showSelectedIcon: false,
                            style: SegmentedButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              textStyle: AppType.buttonS,
                            ),
                            segments: const [
                              ButtonSegment(value: ThemeMode.system, label: Text('Auto')),
                              ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                              ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                            ],
                            selected: {appearance},
                            onSelectionChanged: (s) =>
                                ref.read(appearanceControllerProvider.notifier).set(s.first),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.public_rounded),
                          title: const Text('Server'),
                          subtitle: Text(Uri.parse(AppConfig.defaultServerUrl).host),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.x5),
                  const Eyebrow('Venue staff'),
                  const SizedBox(height: Spacing.x2),
                  AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        if (auth.hasVenueAccess)
                          ListTile(
                            leading: Icon(Icons.swap_horiz_rounded, color: p.pineInk),
                            title: const Text('Switch to venue mode'),
                            subtitle: Text('Signed in as ${auth.userOrNull?.email ?? ''}'),
                            trailing: const Icon(Icons.chevron_right_rounded),
                            onTap: () {
                              ref.read(appModeControllerProvider.notifier).set(AppMode.venue);
                              context.go(AppMode.venue.home);
                            },
                          )
                        else
                          ListTile(
                            leading: Icon(Icons.login_rounded, color: p.pineInk),
                            title: const Text('Sign in to venue mode'),
                            subtitle: const Text('Run sheet, calendar, customers'),
                            trailing: const Icon(Icons.chevron_right_rounded),
                            onTap: () => context.push(Routes.login),
                          ),
                        if (apiMode == ApiMode.fake && !auth.hasVenueAccess) ...[
                          const Divider(),
                          ListTile(
                            leading: Icon(Icons.science_outlined, color: p.clayInk),
                            title: const Text('Demo: sign in as the venue owner'),
                            subtitle: const Text('Fake mode only — Katipunan Courts'),
                            onTap: () async {
                              await ref.read(authControllerProvider.notifier).devSignInAsDemo();
                              ref.read(appModeControllerProvider.notifier).set(AppMode.venue);
                              if (context.mounted) context.go(AppMode.venue.home);
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.x8),
                  Center(
                    child: Text(
                      'ReservMe ${AppConfig.appVersion} · ${apiMode.name} API',
                      style: AppType.captionStrong.copyWith(color: p.ink3, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
