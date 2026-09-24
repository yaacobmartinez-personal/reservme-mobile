import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/money/money.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/async_view.dart';
import '../../../../../core/widgets/confirm_dialog.dart';
import '../../../today/application/today_controller.dart';
import '../../application/calendar_commands.dart';
import '../../domain/calendar_day.dart';
import 'move_booking_sheet.dart';

/// What the desk can do to something already on the grid: move it, cancel it,
/// or — for a block — lift it. Sessions are read-only in v1.
Future<void> showCalendarItemSheet(
  BuildContext context, {
  required String venueSlug,
  required String timezone,
  required String currency,
  required String date,
  required CalendarItem item,
  required List<CalendarLane> lanes,
  bool offline = false,
}) =>
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (_) => _ItemSheet(
        venueSlug: venueSlug,
        timezone: timezone,
        currency: currency,
        date: date,
        item: item,
        lanes: lanes,
        offline: offline,
      ),
    );

class _ItemSheet extends ConsumerWidget {
  const _ItemSheet({
    required this.venueSlug,
    required this.timezone,
    required this.currency,
    required this.date,
    required this.item,
    required this.lanes,
    required this.offline,
  });

  final String venueSlug;
  final String timezone;
  final String currency;
  final String date;
  final CalendarItem item;
  final List<CalendarLane> lanes;
  final bool offline;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;

    Future<void> run(Future<void> Function() action, String done) async {
      final messenger = ScaffoldMessenger.of(context);
      Navigator.of(context).pop();
      try {
        await action();
        messenger.showSnackBar(SnackBar(content: Text(done)));
      } catch (e) {
        messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
      }
    }

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Spacing.gutter,
              0,
              Spacing.gutter,
              Spacing.x3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppType.bodyStrong.copyWith(color: p.ink, fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(
                  [
                    item.label,
                    if (item.isBooking && item.amountCents > 0)
                      Money.format(item.amountCents, currency: currency),
                    if (item.reference != null) item.reference!,
                    if (item.subtitle != null && !item.isBooking) item.subtitle!,
                  ].join(' · '),
                  style: AppType.caption.copyWith(color: p.ink3),
                ),
              ],
            ),
          ),
          if (offline)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Spacing.gutter,
                0,
                Spacing.gutter,
                Spacing.x3,
              ),
              child: Text(
                "You're offline — these need a connection.",
                style: AppType.caption.copyWith(color: p.clayInk),
              ),
            ),
          const Divider(height: 1),

          if (item.isBooking) ...[
            ListTile(
              enabled: !offline,
              leading: Icon(Icons.swap_horiz_rounded, color: p.ink3),
              title: const Text('Move'),
              subtitle: const Text('Another space or time, same length'),
              onTap: () {
                Navigator.of(context).pop();
                showMoveBookingSheet(
                  context,
                  venueSlug: venueSlug,
                  timezone: timezone,
                  fromDate: date,
                  item: item,
                  lanes: lanes,
                );
              },
            ),
            ListTile(
              enabled: !offline,
              leading: Icon(Icons.delete_outline_rounded, color: p.danger),
              title: Text('Cancel booking', style: TextStyle(color: p.danger)),
              subtitle: const Text('Frees the slot straight away'),
              onTap: () async {
                final ok = await showConfirmDialog(
                  context,
                  title: 'Cancel this booking?',
                  message: '${item.title}, ${item.label}. The slot goes back on '
                      "sale immediately. This can't be undone.",
                  confirmLabel: 'Cancel booking',
                  cancelLabel: 'Keep it',
                  destructive: true,
                );
                if (!ok || !context.mounted) return;
                await run(
                  () => ref.read(todayProvider(venueSlug).notifier).cancel(item.id),
                  "${item.title}'s booking cancelled — the slot is free.",
                );
              },
            ),
          ] else if (item.isBlock) ...[
            ListTile(
              enabled: !offline,
              leading: Icon(Icons.lock_open_rounded, color: p.pine),
              title: const Text('Lift this block'),
              subtitle: const Text('The time goes back on sale'),
              onTap: () => run(
                () => ref
                    .read(calendarCommandsProvider.notifier)
                    .removeBlock(venueSlug, item.id, date),
                'Block lifted — ${item.label} is bookable again.',
              ),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.all(Spacing.gutter),
              child: Text(
                'Open play is managed from the space editor. Seats booked into '
                'it show on Today.',
                style: AppType.bodyS.copyWith(color: p.ink2),
              ),
            ),
          const SizedBox(height: Spacing.x3),
        ],
      ),
    );
  }
}
