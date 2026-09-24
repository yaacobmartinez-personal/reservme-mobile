import 'package:flutter/material.dart';

import '../model/opening_hours.dart';
import '../theme/palette.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';
import 'wall_clock_field.dart';

/// The weekly opening-hours grid, shared by onboarding (O5) and the space
/// editor (G1). Monday first on screen, because that is how a venue reads its
/// own week; the rows still carry 0 = Sunday, like the column.
///
/// Times are venue-local wall clock throughout — never instants.
class WeekHoursEditor extends StatelessWidget {
  const WeekHoursEditor({
    super.key,
    required this.hours,
    required this.onChanged,
    this.showShortcuts = true,
  });

  final HoursInput hours;
  final ValueChanged<HoursInput> onChanged;

  /// "Copy Mon to all" / "Same every day". Worth having on a seven-day form,
  /// noise on a sheet that is already short.
  final bool showShortcuts;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: Spacing.x2),
          decoration: BoxDecoration(
            color: p.card,
            borderRadius: BorderRadius.circular(Radii.card),
            border: Border.all(color: p.rule),
          ),
          child: Column(
            children: [
              for (final day in hours.weekOrder)
                _DayRow(
                  day: day,
                  onChanged: (next) => onChanged(hours.replacing(next)),
                ),
            ],
          ),
        ),
        if (showShortcuts) ...[
          const SizedBox(height: Spacing.x3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                // Monday is the week's first working day, so it is the one
                // worth copying from.
                onPressed: () => onChanged(hours.copyFrom(1)),
                child: const Text('Copy Mon to all'),
              ),
              TextButton(
                onPressed: () => onChanged(hours.everyDay(1)),
                child: const Text('Same every day'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({required this.day, required this.onChanged});

  final DayHours day;
  final ValueChanged<DayHours> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.x3,
        vertical: 6,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 42,
            child: Text(
              day.name,
              style: AppType.bodyStrong.copyWith(
                color: day.open ? p.ink : p.ink3,
              ),
            ),
          ),
          Switch(
            value: day.open,
            onChanged: (v) => onChanged(day.copyWith(open: v)),
          ),
          const SizedBox(width: Spacing.x2),
          if (!day.open)
            Expanded(
              child: Text(
                'Closed',
                style: AppType.bodyS.copyWith(color: p.ink3),
              ),
            )
          else ...[
            Expanded(
              child: TimeField(
                label: '',
                value: day.opensAt,
                onChanged: (v) => onChanged(day.copyWith(opensAt: v)),
              ),
            ),
            const SizedBox(width: Spacing.x2),
            Expanded(
              child: TimeField(
                label: '',
                value: day.closesAt,
                onChanged: (v) => onChanged(day.copyWith(closesAt: v)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
