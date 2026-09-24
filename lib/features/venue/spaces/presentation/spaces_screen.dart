import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/money/money.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/kind_placeholder.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/spaces_controller.dart';
import '../domain/space_summary.dart';

/// V14 · Spaces. The toggle takes a space off sale immediately — and active
/// spaces set the billing band, which is why the screen says so out loud.
class SpacesScreen extends ConsumerWidget {
  const SpacesScreen({super.key});

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

    final spaces = ref.watch(spacesProvider(venue.slug));

    return Scaffold(
      appBar: AppBar(title: const Text('Spaces')),
      body: AsyncView(
        value: spaces,
        onRetry: () => ref.invalidate(spacesProvider(venue.slug)),
        data: (rows) => RefreshIndicator(
          onRefresh: () async => ref.refresh(spacesProvider(venue.slug).future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              Spacing.gutter,
              0,
              Spacing.gutter,
              Spacing.x8,
            ),
            children: [
              Text(
                'Active spaces set your billing band',
                style: AppType.bodyS.copyWith(color: context.palette.ink3),
              ),
              const SizedBox(height: Spacing.x3),
              for (final space in rows) ...[
                _SpaceCard(
                  space: space,
                  currency: venue.currency,
                  onOpen: () => context.push(Routes.spaceEdit(space.id)),
                  onToggle: (active) => _toggle(context, ref, venue.slug, space, active),
                ),
                const SizedBox(height: Spacing.x3),
              ],
              const SizedBox(height: Spacing.x2),
              const AppBanner(
                kind: BannerKind.info,
                title: 'Pausing takes a space off sale immediately',
                body: 'Bookings already made are kept — pause only stops new '
                    'ones. Tap a space to edit its hours, pricing and photo.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggle(
    BuildContext context,
    WidgetRef ref,
    String slug,
    SpaceSummary space,
    bool active,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(spacesProvider(slug).notifier).setActive(space.id, active);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            active
                ? '${space.name} is back on sale.'
                : '${space.name} is paused — no new bookings.',
          ),
        ),
      );
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }
}

class _SpaceCard extends StatelessWidget {
  const _SpaceCard({
    required this.space,
    required this.currency,
    required this.onOpen,
    required this.onToggle,
  });

  final SpaceSummary space;
  final String currency;
  final VoidCallback onOpen;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    final facts = space.isActive
        ? [
            '${space.slotMinutes} min',
            Money.format(space.priceCents, currency: currency),
            if (space.hasPeak)
              'peak ${Money.format(space.peakPriceCents!, currency: currency)}',
            if (space.sessionSummary != null) space.sessionSummary!,
          ].join(' · ')
        : 'Paused · not bookable';

    return AppCard(
      onTap: onOpen,
      child: Row(
        children: [
          // A space with a photo shows it; without one, the kind glyph —
          // never a grey box.
          ClipRRect(
            borderRadius: BorderRadius.circular(Radii.sm),
            child: space.imageUrl == null
                ? KindPlaceholder(kind: space.kind, width: 56, height: 56)
                : Image.network(
                    space.imageUrl!,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        KindPlaceholder(kind: space.kind, width: 56, height: 56),
                  ),
          ),
          const SizedBox(width: Spacing.x3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  space.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.bodyStrong.copyWith(
                    color: space.isActive ? p.ink : p.ink2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  facts,
                  style: AppType.bodyS.copyWith(color: p.ink3),
                ),
              ],
            ),
          ),
          Switch(value: space.isActive, onChanged: onToggle),
        ],
      ),
    );
  }
}
