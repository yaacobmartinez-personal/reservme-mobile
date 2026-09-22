import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/model/enums.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/primitives.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../shell/application/app_mode_controller.dart';
import '../application/selected_venue_controller.dart';
import '../domain/venue_membership.dart';

/// V3 · Venue picker: shown when the signed-in user belongs to more than one
/// venue, and reachable from the venue switcher.
class VenuePickerScreen extends ConsumerWidget {
  const VenuePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final auth = ref.watch(authControllerProvider);
    final venues = auth.venuesOrEmpty;
    final selected = ref.watch(selectedVenueSlugProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BigHeader(
              eyebrow: 'Signed in as ${auth.userOrNull?.email ?? ''}',
              title: 'Your venues',
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x6),
                itemCount: venues.length + 1,
                separatorBuilder: (_, _) => const SizedBox(height: Spacing.x3),
                itemBuilder: (context, i) {
                  if (i == venues.length) {
                    return Column(
                      children: [
                        const SizedBox(height: Spacing.x2),
                        OutlinedButton.icon(
                          onPressed: () => context.push(Routes.createVenue),
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Add another venue'),
                        ),
                        const SizedBox(height: Spacing.x6),
                        TextButton.icon(
                          onPressed: () async {
                            await ref.read(authControllerProvider.notifier).signOut();
                            if (context.mounted) context.go(AppMode.customer.home);
                          },
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text('Sign out'),
                          style: TextButton.styleFrom(foregroundColor: p.ink2),
                        ),
                      ],
                    );
                  }
                  final v = venues[i];
                  return _VenueTile(
                    venue: v,
                    selected: v.slug == selected,
                    onTap: () {
                      ref.read(selectedVenueSlugProvider.notifier).set(v.slug);
                      ref.read(appModeControllerProvider.notifier).set(AppMode.venue);
                      context.go(AppMode.venue.home);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VenueTile extends StatelessWidget {
  const _VenueTile({required this.venue, required this.selected, required this.onTap});

  final VenueMembership venue;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final sub = venue.suspended
        ? 'Billing overdue'
        : '${venue.activeSpaces} ${venue.activeSpaces == 1 ? 'space' : 'spaces'} · ${venue.timezone}';
    return AppCard(
      onTap: onTap,
      borderColor: selected ? p.pine : null,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: p.pineInk,
              borderRadius: BorderRadius.circular(Spacing.x3),
            ),
            alignment: Alignment.center,
            child: Text(
              venue.name.characters.first.toUpperCase(),
              style: AppType.displayS.copyWith(color: p.pineLine, fontSize: 22),
            ),
          ),
          const SizedBox(width: Spacing.x3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(venue.name, style: AppType.bodyStrong.copyWith(color: p.ink, fontSize: 16)),
                const SizedBox(height: 3),
                Text(sub, style: AppType.bodyS.copyWith(color: p.ink2)),
              ],
            ),
          ),
          const SizedBox(width: Spacing.x2),
          if (venue.suspended)
            const StatusChip('Suspended', tone: ChipTone.danger)
          else
            StatusChip(
              venue.role.label,
              tone: venue.role == VenueRole.owner ? ChipTone.ink : ChipTone.neutral,
            ),
          const SizedBox(width: Spacing.x1),
          Icon(Icons.chevron_right_rounded, color: p.ink3),
        ],
      ),
    );
  }
}
