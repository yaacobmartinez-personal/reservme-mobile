import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/api_mode.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/primitives.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../shell/application/app_mode_controller.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../../venues/presentation/venue_switcher_button.dart';
import '../../venues/presentation/widgets/venue_avatar.dart';

/// V12 · More: the venue card, the Manage entries, app settings, sign out.
/// Every destination is wired; the screens behind them fill in over
/// Phases 3–3c.
class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final venue = ref.watch(selectedVenueProvider);
    final apiMode = ref.watch(apiModeProvider);

    Widget group(List<Widget> tiles) => AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (final (i, t) in tiles.indexed) ...[if (i > 0) const Divider(), t],
            ],
          ),
        );

    Widget tile(IconData icon, String title, String? subtitle, String route, {Color? tone}) => ListTile(
          leading: Icon(icon, color: tone ?? p.ink3),
          title: Text(title),
          subtitle: subtitle == null ? null : Text(subtitle),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => context.push(route),
        );

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: Spacing.x6),
          children: [
            BigHeader(
              eyebrow: venue == null ? 'No venue selected' : '${venue.name} · ${venue.role.label}',
              title: 'More',
              trailing: const VenueSwitcherButton(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.gutter),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (venue != null)
                    AppCard(
                      child: Row(
                        children: [
                          VenueAvatar(name: venue.name, size: 48),
                          const SizedBox(width: Spacing.x3),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(venue.name, style: AppType.bodyStrong.copyWith(color: p.ink)),
                                Text(
                                  '${venue.activeSpaces} active spaces · ${venue.timezone}',
                                  style: AppType.caption.copyWith(color: p.ink3),
                                ),
                              ],
                            ),
                          ),
                          StatusChip(venue.role.label, tone: ChipTone.ink),
                        ],
                      ),
                    ),
                  const SizedBox(height: Spacing.x4),
                  group([
                    tile(Icons.insights_rounded, 'Insights', 'Booked value, utilisation, peak hours', Routes.venueInsights, tone: p.pineInk),
                    tile(Icons.format_list_bulleted_rounded, 'Waitlist', null, Routes.venueWaitlist),
                    tile(Icons.grid_view_rounded, 'Spaces', 'Hours, pricing, photos', Routes.venueSpaces),
                  ]),
                  const SizedBox(height: Spacing.x5),
                  const Eyebrow('Venue'),
                  const SizedBox(height: Spacing.x2),
                  group([
                    tile(Icons.tune_rounded, 'Venue settings', 'Policy, hours, branding, booking page', Routes.venueSettings),
                    tile(Icons.people_outline_rounded, 'Team', null, Routes.venueTeam),
                    tile(Icons.receipt_long_outlined, 'Billing', null, Routes.venueBilling, tone: p.clayInk),
                    tile(Icons.add_business_outlined, 'New venue', 'Add another location', Routes.createVenue),
                  ]),
                  const SizedBox(height: Spacing.x5),
                  const Eyebrow('App'),
                  const SizedBox(height: Spacing.x2),
                  group([
                    ListTile(
                      leading: Icon(Icons.swap_horiz_rounded, color: p.ink3),
                      title: const Text('Switch to customer mode'),
                      subtitle: const Text('Book as a customer'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        ref.read(appModeControllerProvider.notifier).set(AppMode.customer);
                        context.go(AppMode.customer.home);
                      },
                    ),
                    tile(Icons.person_outline_rounded, 'Your account', null, Routes.ownerAccount),
                  ]),
                  const SizedBox(height: Spacing.x4),
                  TextButton.icon(
                    onPressed: () async {
                      await ref.read(authControllerProvider.notifier).signOut();
                      if (context.mounted) context.go(AppMode.customer.home);
                    },
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Sign out'),
                    style: TextButton.styleFrom(foregroundColor: p.ink2),
                  ),
                  const SizedBox(height: Spacing.x4),
                  Center(
                    child: Text(
                      'ReservMe ${AppConfig.appVersion} · ${apiMode.name} API',
                      style: AppType.caption.copyWith(color: p.ink3),
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
