import 'package:flutter/material.dart';

import '../../../../../core/model/enums.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/time/app_time.dart';
import '../../domain/calendar_day.dart';

/// V7 · one space's column. Rows are the day's grid steps; an item occupies
/// the row it starts on and stretches over the ones it covers, so a two-hour
/// block reads as one thing rather than two.
class SpaceLane extends StatelessWidget {
  const SpaceLane({
    super.key,
    required this.lane,
    required this.rows,
    required this.timezone,
    required this.onItem,
    required this.onEmpty,
    this.width = 150,
    this.rowHeight = 74,
  });

  final CalendarLane lane;

  /// Local "HH:MM" for each grid row, shared by every lane.
  final List<String> rows;
  final String timezone;
  final ValueChanged<CalendarItem> onItem;

  /// Tapping empty air starts a booking at that space and time.
  final void Function(String spaceId, String time) onEmpty;
  final double width;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    // Which item, if any, starts on each row — and which rows are swallowed
    // by an item that started earlier.
    final startsOn = <int, CalendarItem>{};
    final covered = <int>{};
    for (final item in lane.items) {
      final at = AppTime.formatTime(item.startsAt, timezone);
      final index = rows.indexOf(at);
      if (index < 0) continue;
      startsOn[index] = item;
      final span = item.rowSpan(_stepMinutes);
      for (var i = 1; i < span && index + i < rows.length; i++) {
        covered.add(index + i);
      }
    }

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.x2),
            child: Text(
              lane.spaceName,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppType.bodyStrong.copyWith(
                color: lane.isActive ? p.ink : p.ink3,
                fontSize: 14,
              ),
            ),
          ),
          for (var i = 0; i < rows.length; i++)
            if (covered.contains(i))
              const SizedBox.shrink()
            else
              SizedBox(
                height: rowHeight * (startsOn[i]?.rowSpan(_stepMinutes) ?? 1),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.x2, right: Spacing.x2),
                  child: startsOn[i] == null
                      ? _Empty(onTap: () => onEmpty(lane.spaceId, rows[i]))
                      : _Cell(
                          item: startsOn[i]!,
                          onTap: () => onItem(startsOn[i]!),
                        ),
                ),
              ),
        ],
      ),
    );
  }

  /// The grid step in minutes, taken from the first two rows so lanes with
  /// different slot lengths still line up on a shared ruler.
  int get _stepMinutes {
    if (rows.length < 2) return lane.slotMinutes;
    final a = AppTime.minutesOfDay(rows[0]);
    final b = AppTime.minutesOfDay(rows[1]);
    if (a == null || b == null || b <= a) return lane.slotMinutes;
    return b - a;
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Radii.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Radii.md),
          border: Border.all(color: p.rule, style: BorderStyle.solid, width: 1),
          color: Colors.transparent,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({required this.item, required this.onTap});

  final CalendarItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    final (bg, border, ink) = switch (item.kind) {
      CalendarItemKind.block => (p.paper3, p.rule, p.ink2),
      CalendarItemKind.session => (p.claySoft, p.clayLine, p.clayInk),
      CalendarItemKind.booking when item.isCheckedIn => (p.pineSoft, p.pineLine, p.pineInk),
      CalendarItemKind.booking => (p.card, p.rule, p.ink),
    };

    final subtitle = switch (item.kind) {
      CalendarItemKind.block => item.subtitle ?? 'Blocked',
      CalendarItemKind.session => item.subtitle ?? '',
      _ when item.isCheckedIn => 'Checked in',
      _ when item.status == ReservationStatus.noShow => 'No-show',
      _ when item.noShowCount > 0 =>
        item.noShowCount == 1 ? '1 no-show' : '${item.noShowCount} no-shows',
      _ => 'Confirmed',
    };

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(Radii.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.md),
        child: Ink(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.md),
            border: Border.all(color: border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppType.bodyStrong.copyWith(color: ink, fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppType.caption.copyWith(
                  color: item.noShowCount > 0 && item.isBooking && !item.isCheckedIn
                      ? p.clayInk
                      : p.ink3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
