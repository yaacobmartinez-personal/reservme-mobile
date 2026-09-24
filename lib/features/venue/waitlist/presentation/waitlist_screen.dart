import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/clock.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/venue_waitlist_controller.dart';
import '../domain/waitlist_entry.dart';

/// V13 · Waitlist — read-only. The venue watches the queue; the server sends
/// the claim link when a slot frees.
class WaitlistScreen extends ConsumerWidget {
  const WaitlistScreen({super.key});

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

    final entries = ref.watch(venueWaitlistProvider(venue.slug));
    final waiting = entries.value?.where((e) => !e.isNotified).length ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Waitlist'),
        bottom: entries.hasValue
            ? PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.x2),
                  child: Text(
                    '$waiting waiting · oldest first',
                    style: AppType.caption.copyWith(
                      color: context.palette.ink3,
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: AsyncView(
        value: entries,
        onRetry: () => ref.invalidate(venueWaitlistProvider(venue.slug)),
        data: (rows) => rows.isEmpty
            ? const EmptyState(
                icon: Icons.hourglass_empty_rounded,
                title: 'Nobody waiting',
                hint: 'When a slot is taken, customers can ask to be told if '
                    'it frees up. They appear here.',
              )
            : RefreshIndicator(
                onRefresh: () async =>
                    ref.refresh(venueWaitlistProvider(venue.slug).future),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    Spacing.gutter,
                    0,
                    Spacing.gutter,
                    Spacing.x8,
                  ),
                  children: [
                    const AppBanner(
                      kind: BannerKind.info,
                      title: 'Auto-fills on cancellation',
                      body: 'When a slot frees, the oldest match gets a '
                          '30-minute claim link by email.',
                    ),
                    const SizedBox(height: Spacing.x3),
                    for (final entry in rows) ...[
                      _EntryCard(entry: entry),
                      const SizedBox(height: Spacing.x3),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}

class _EntryCard extends ConsumerWidget {
  const _EntryCard({required this.entry});

  final WaitlistEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final now = ref.watch(clockProvider)();
    final left = entry.minutesLeft(now);

    return AppCard(
      color: entry.isNotified ? p.pineSoft : null,
      borderColor: entry.isNotified ? p.pineLine : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.customerName,
                  style: AppType.bodyStrong.copyWith(color: p.ink),
                ),
                const SizedBox(height: 2),
                Text(
                  '${entry.whenLabel} · ${entry.spaceName}',
                  style: AppType.bodyS.copyWith(color: p.ink2),
                ),
                const SizedBox(height: 2),
                Text(
                  'Joined ${_ago(now.difference(entry.createdAt))}',
                  style: AppType.caption.copyWith(color: p.ink3),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.x2),
          if (entry.isNotified && left != null)
            StatusChip('Notified · $left min left', tone: ChipTone.pine)
          else
            const StatusChip('Waiting', tone: ChipTone.warn),
        ],
      ),
    );
  }

  static String _ago(Duration d) {
    if (d.inMinutes < 1) return 'just now';
    if (d.inMinutes < 60) return '${d.inMinutes} min ago';
    if (d.inHours < 24) return '${d.inHours} h ago';
    if (d.inDays == 1) return 'yesterday';
    return '${d.inDays} days ago';
  }
}
