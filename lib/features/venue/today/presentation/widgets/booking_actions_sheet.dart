import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/money/money.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/time/app_time.dart';
import '../../../../../core/widgets/confirm_dialog.dart';
import '../../domain/run_sheet.dart';
import 'run_sheet_row.dart';

/// V6 · Booking actions. Everything the desk can do to one booking, with the
/// two that cannot be undone behind a confirmation.
Future<void> showBookingActionsSheet(
  BuildContext context, {
  required RunSheetEntry entry,
  required String timezone,
  required String currency,
  required ValueChanged<DeskAction> onAction,
  bool offline = false,
}) =>
    showModalBottomSheet<void>(
      context: context,
      // On the root navigator, or the shell's bottom nav sits on top of it.
      useRootNavigator: true,
      builder: (_) => _ActionsSheet(
        entry: entry,
        timezone: timezone,
        currency: currency,
        offline: offline,
        onAction: onAction,
      ),
    );

class _ActionsSheet extends StatelessWidget {
  const _ActionsSheet({
    required this.entry,
    required this.timezone,
    required this.currency,
    required this.offline,
    required this.onAction,
  });

  final RunSheetEntry entry;
  final String timezone;
  final String currency;
  final bool offline;
  final ValueChanged<DeskAction> onAction;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final name = entry.customerName ?? 'Walk-in';

    // An explicit colour would override ListTile's own disabled styling, so
    // the danger actions dim themselves.
    Color tone(Color c) => offline ? c.withValues(alpha: 0.38) : c;

    void run(DeskAction action) {
      Navigator.of(context).pop();
      onAction(action);
    }

    Future<void> confirm(
      DeskAction action,
      String title,
      String message,
      String label, {
      String keep = 'Keep it',
    }) async {
      final ok = await showConfirmDialog(
        context,
        title: title,
        message: message,
        confirmLabel: label,
        // Never "Cancel" next to "Cancel booking" — two different cancels.
        cancelLabel: keep,
        destructive: true,
      );
      if (!ok) return;
      if (context.mounted) run(action);
    }

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x3),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppType.bodyStrong.copyWith(color: p.ink, fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${entry.spaceName} · ${entry.label} · '
                        '${Money.format(entry.amountCents, currency: currency)} · '
                        '${entry.reference}',
                        style: AppType.caption.copyWith(color: p.ink3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (offline)
            Padding(
              padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x3),
              child: Text(
                "You're offline — these need a connection.",
                style: AppType.caption.copyWith(color: p.clayInk),
              ),
            ),
          const Divider(height: 1),
          if (entry.isCheckedIn)
            ListTile(
              enabled: !offline,
              leading: Icon(Icons.undo_rounded, color: p.ink3),
              title: const Text('Undo check-in'),
              subtitle: Text(
                'Arrived ${AppTime.formatTime(entry.checkedInAt!, timezone)}',
              ),
              onTap: () => run(DeskAction.undoCheckIn),
            )
          else
            ListTile(
              enabled: !offline,
              leading: Icon(Icons.check_rounded, color: tone(p.pine)),
              title: const Text('Check in'),
              onTap: () => run(DeskAction.checkIn),
            ),
          if (entry.customerPhone != null)
            ListTile(
              leading: Icon(Icons.phone_outlined, color: p.ink3),
              title: Text('Call ${entry.customerPhone}'),
              onTap: () {
                Navigator.of(context).pop();
                launchUrl(Uri(scheme: 'tel', path: entry.customerPhone));
              },
            ),
          const Divider(height: 1),
          ListTile(
            enabled: !offline,
            leading: Icon(Icons.person_off_outlined, color: tone(p.clayInk)),
            title: Text('Mark no-show', style: TextStyle(color: tone(p.clayInk))),
            subtitle: const Text('Counts against this customer'),
            onTap: () => confirm(
              DeskAction.noShow,
              'Mark $name as a no-show?',
              'This counts against them the next time they book. The slot is '
                  'not released.',
              'Mark no-show',
            ),
          ),
          ListTile(
            enabled: !offline,
            leading: Icon(Icons.delete_outline_rounded, color: tone(p.danger)),
            title: Text('Cancel booking', style: TextStyle(color: tone(p.danger))),
            subtitle: const Text('Frees the slot straight away'),
            onTap: () => confirm(
              DeskAction.cancel,
              'Cancel this booking?',
              '$name, ${entry.label}. The slot goes back on sale immediately. '
                  "This can't be undone.",
              'Cancel booking',
            ),
          ),
          const SizedBox(height: Spacing.x3),
        ],
      ),
    );
  }
}
