import 'package:flutter/material.dart';

import '../../../../../core/model/enums.dart';
import '../../../../../core/money/money.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/status_chip.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/time/app_time.dart';
import '../../domain/run_sheet.dart';

/// What the desk can do to a booking. Named as actions rather than statuses
/// because that is how the person at the counter thinks about them.
enum DeskAction { checkIn, undoCheckIn, noShow, cancel }

/// One line of the run sheet (design canvas, Molecules · Rows). The row the
/// desk is dealing with right now expands to show its actions inline; the
/// rest keep them behind the overflow button.
class RunSheetRow extends StatelessWidget {
  const RunSheetRow({
    super.key,
    required this.entry,
    required this.timezone,
    required this.currency,
    required this.onAction,
    required this.onMore,
    this.highlighted = false,
    this.offline = false,
    this.onCall,
  });

  final RunSheetEntry entry;
  final String timezone;
  final String currency;
  final ValueChanged<DeskAction> onAction;
  final VoidCallback onMore;
  final bool highlighted;

  /// Writes need a connection; offline the actions are visible but disabled.
  final bool offline;
  final VoidCallback? onCall;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final times = entry.label.split('–');

    return Material(
      color: p.card,
      borderRadius: BorderRadius.circular(Radii.card),
      child: InkWell(
        // Every actionable row opens the sheet on tap; the due one also
        // carries its actions inline, so the desk never has to hunt.
        onTap: _canAct ? onMore : null,
        borderRadius: BorderRadius.circular(Radii.card),
        child: Ink(
          padding: const EdgeInsets.all(Spacing.x3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.card),
            border: Border.all(
              color: highlighted ? p.pine : p.rule,
              width: highlighted ? 2 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      times.first,
                      style: AppType.bodyStrong.copyWith(
                        color: highlighted ? p.pineInk : p.ink,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      times.length > 1 ? times[1] : '',
                      style: AppType.captionStrong.copyWith(
                        color: p.ink3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 44, color: p.rule),
              const SizedBox(width: Spacing.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            entry.customerName ?? 'Walk-in',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppType.bodyStrong.copyWith(color: p.ink),
                          ),
                        ),
                        const SizedBox(width: Spacing.x2),
                        _chip(context),
                      ],
                    ),
                    const SizedBox(height: 3),
                    _subtitle(context),
                    if (entry.reference.isNotEmpty && !entry.isSession) ...[
                      const SizedBox(height: 3),
                      Text(
                        entry.firstVisit
                            ? '${entry.reference} · first visit'
                            : entry.reference,
                        style: AppType.reference.copyWith(
                          color: p.ink3,
                          fontSize: 11,
                        ),
                      ),
                    ],
                    if (highlighted && _canAct) ...[
                      const SizedBox(height: Spacing.x3),
                      _actions(context),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// A session line is a roll-up, not a person: nothing to check in.
  bool get _canAct => !entry.isSession && entry.status.isLive;

  Widget _chip(BuildContext context) {
    if (entry.isSession && entry.sessionCapacity != null) {
      return StatusChip(
        '${entry.sessionBooked ?? 0} of ${entry.sessionCapacity}',
      );
    }
    if (entry.isCheckedIn) {
      return StatusChip(
        'In · ${AppTime.formatTime(entry.checkedInAt!, timezone)}',
        tone: ChipTone.pine,
      );
    }
    return switch (entry.status) {
      ReservationStatus.noShow => const StatusChip(
        'No-show',
        tone: ChipTone.clay,
      ),
      ReservationStatus.cancelled => const StatusChip(
        'Cancelled',
        tone: ChipTone.danger,
      ),
      _ when entry.noShowCount > 0 => StatusChip(
        entry.noShowCount == 1 ? '1 no-show' : '${entry.noShowCount} no-shows',
        tone: ChipTone.clay,
      ),
      _ when highlighted => const StatusChip('Due now'),
      _ => const StatusChip('Confirmed'),
    };
  }

  Widget _subtitle(BuildContext context) {
    final p = context.palette;
    final money = entry.amountCents > 0
        ? ' · ${Money.format(entry.amountCents, currency: currency)}'
        : '';
    final party = entry.partySize > 1 ? ' · ${entry.partySize} players' : '';

    if (entry.customerPhone != null && onCall != null) {
      return Row(
        children: [
          Flexible(
            child: Text(
              '${entry.spaceName} · ',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppType.bodyS.copyWith(color: p.ink2),
            ),
          ),
          InkWell(
            onTap: onCall,
            child: Text(
              entry.customerPhone!,
              style: AppType.bodyS.copyWith(
                color: p.pineInk,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Text(
              money,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppType.bodyS.copyWith(color: p.ink2),
            ),
          ),
        ],
      );
    }
    return Text(
      '${entry.spaceName}$party$money',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppType.bodyS.copyWith(color: p.ink2),
    );
  }

  Widget _actions(BuildContext context) {
    final p = context.palette;
    final checkedIn = entry.isCheckedIn;
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: offline
                ? null
                : () => onAction(
                    checkedIn ? DeskAction.undoCheckIn : DeskAction.checkIn,
                  ),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Radii.md),
              ),
              textStyle: AppType.buttonS,
              backgroundColor: checkedIn ? p.paper3 : p.pine,
              foregroundColor: checkedIn ? p.ink2 : p.onPine,
            ),
            child: Text(checkedIn ? 'Undo check-in' : 'Check in'),
          ),
        ),
        const SizedBox(width: Spacing.x2),
        OutlinedButton(
          onPressed: offline ? null : () => onAction(DeskAction.noShow),
          style: OutlinedButton.styleFrom(
            foregroundColor: p.clayInk,
            minimumSize: const Size(0, 40),
            padding: const EdgeInsets.symmetric(horizontal: Spacing.x3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            textStyle: AppType.buttonS,
          ),
          child: const Text('No-show'),
        ),
        const SizedBox(width: Spacing.x2),
        SizedBox(
          width: 40,
          height: 40,
          child: OutlinedButton(
            onPressed: onMore,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Radii.md),
              ),
            ),
            child: Icon(Icons.more_horiz_rounded, size: 18, color: p.ink),
          ),
        ),
      ],
    );
  }
}
