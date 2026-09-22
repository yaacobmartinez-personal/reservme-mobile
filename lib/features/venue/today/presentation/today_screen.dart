import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/money/money.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../../venues/presentation/venue_switcher_button.dart';
import '../application/today_controller.dart';
import '../domain/run_sheet.dart';
import 'widgets/booking_actions_sheet.dart';
import 'widgets/run_sheet_row.dart';

/// V4 · Today — the screen a venue opens every morning: who is coming, who
/// has arrived, and the four things the desk does about it.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(selectedVenueProvider);
    if (venue == null) {
      return const Scaffold(
        body: EmptyState(
          icon: Icons.storefront_outlined,
          title: 'No venue selected',
          hint: 'Pick a venue to see its run sheet.',
        ),
      );
    }

    final today = ref.watch(todayProvider(venue.slug));
    final now = ref.watch(clockProvider)();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BigHeader(
              eyebrow: AppTime.formatLongDay(now, venue.timezone),
              title: 'Today',
              trailing: const VenueSwitcherButton(),
            ),
            Expanded(
              child: AsyncView(
                value: today,
                onRetry: () => ref.invalidate(todayProvider(venue.slug)),
                data: (state) => _Body(
                  state: state,
                  venueSlug: venue.slug,
                  timezone: venue.timezone,
                  currency: venue.currency,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    required this.state,
    required this.venueSlug,
    required this.timezone,
    required this.currency,
  });

  final TodayState state;
  final String venueSlug;
  final String timezone;
  final String currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final now = ref.watch(clockProvider)();
    final stats = state.view.stats;
    final rows = state.view.runSheet;

    // The booking the desk is dealing with right now gets the emphasis.
    final dueIndex = rows.indexWhere((r) => r.isDue(now));

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(todayProvider(venueSlug).future),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          Spacing.gutter,
          0,
          Spacing.gutter,
          Spacing.x8,
        ),
        children: [
          Row(
            children: [
              Expanded(child: KpiTile(value: '${stats.todayCount}', label: 'Bookings')),
              const SizedBox(width: Spacing.x2),
              Expanded(child: KpiTile(value: '${stats.checkedIn}', label: 'Checked in')),
              const SizedBox(width: Spacing.x2),
              Expanded(
                child: KpiTile(
                  value: '${stats.activeSpaces}/${stats.totalSpaces}',
                  label: 'Spaces live',
                ),
              ),
              const SizedBox(width: Spacing.x2),
              Expanded(
                child: KpiTile(
                  value: Money.compact(stats.todayRevenueCents, currency: currency),
                  label: 'Booked',
                  dark: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.x4),
          Row(
            children: [
              const Expanded(child: Eyebrow('Run sheet')),
              if (state.stale)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wifi_off_rounded, size: 14, color: p.ink3),
                    const SizedBox(width: 6),
                    Text(
                      state.fetchedAt == null
                          ? 'Saved copy'
                          : 'Updated ${_ago(now.difference(state.fetchedAt!))}',
                      style: AppType.captionStrong.copyWith(
                        color: p.ink3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(color: p.pine, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text('Live', style: AppType.captionStrong.copyWith(color: p.pine)),
                  ],
                ),
            ],
          ),
          const SizedBox(height: Spacing.x3),
          if (state.stale) ...[
            const AppBanner(
              kind: BannerKind.offline,
              title: "You're offline",
              body: 'Showing the last run sheet. Check-in needs a connection.',
            ),
            const SizedBox(height: Spacing.x3),
          ],
          if (rows.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: Spacing.x8),
              child: EmptyState(
                icon: Icons.event_available_outlined,
                title: 'Nothing booked today',
                hint: 'Bookings made on your page show up here as they come in.',
              ),
            )
          else
            for (final (i, row) in rows.indexed) ...[
              RunSheetRow(
                entry: row,
                timezone: timezone,
                currency: currency,
                highlighted: i == dueIndex,
                offline: state.stale,
                onAction: (action) => _run(context, ref, row, action),
                onMore: () => showBookingActionsSheet(
                  context,
                  entry: row,
                  timezone: timezone,
                  currency: currency,
                  offline: state.stale,
                  onAction: (action) => _run(context, ref, row, action),
                ),
                onCall: row.customerPhone == null
                    ? null
                    : () => launchUrl(Uri(scheme: 'tel', path: row.customerPhone)),
              ),
              const SizedBox(height: Spacing.x3),
            ],
        ],
      ),
    );
  }

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    RunSheetEntry entry,
    DeskAction action,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final controller = ref.read(todayProvider(venueSlug).notifier);
    final name = entry.customerName ?? entry.reference;
    try {
      switch (action) {
        case DeskAction.checkIn:
          await controller.checkIn(entry.id);
          messenger.showSnackBar(SnackBar(content: Text('Checked in $name.')));
        case DeskAction.undoCheckIn:
          await controller.undoCheckIn(entry.id);
          messenger.showSnackBar(SnackBar(content: Text('Check-in undone for $name.')));
        case DeskAction.noShow:
          await controller.noShow(entry.id);
          messenger.showSnackBar(SnackBar(content: Text('$name marked as a no-show.')));
        case DeskAction.cancel:
          await controller.cancel(entry.id);
          messenger.showSnackBar(
            SnackBar(content: Text("$name's booking cancelled — the slot is free.")),
          );
      }
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }

  static String _ago(Duration d) {
    if (d.inMinutes < 1) return 'just now';
    if (d.inMinutes < 60) return '${d.inMinutes} min ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    return '${d.inDays}d ago';
  }
}
