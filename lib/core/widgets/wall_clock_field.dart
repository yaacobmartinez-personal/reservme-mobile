import 'package:flutter/material.dart';

import '../theme/palette.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';
import '../time/app_time.dart';

/// A field that opens the platform picker instead of asking someone to type
/// "18:00" correctly at a busy counter.
///
/// Both of these deal in **wall clock** — a venue-local `YYYY-MM-DD` or
/// `HH:MM`, never an instant. The venue's timezone turns them into a moment,
/// server-side, exactly as the web's `wallClock` + `make_timestamptz` does.
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.timezone,
    required this.onChanged,
  });

  final String label;

  /// "YYYY-MM-DD", venue-local.
  final String value;
  final String timezone;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final start = AppTime.startOfLocalDay(value, timezone);
    final shown = start == null ? value : AppTime.formatDay(start, timezone);

    return _PickerField(
      label: label,
      text: shown,
      icon: Icons.calendar_today_outlined,
      onTap: () async {
        final parts = value.split('-').map(int.tryParse).toList();
        final initial = parts.length == 3 && !parts.contains(null)
            ? DateTime(parts[0]!, parts[1]!, parts[2]!)
            : DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: initial,
          // A venue books a year out at most; two years of range is plenty
          // either side of that without turning the picker into a scroll.
          firstDate: DateTime(initial.year - 1),
          lastDate: DateTime(initial.year + 2),
        );
        if (picked == null) return;
        onChanged(
          '${picked.year.toString().padLeft(4, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.day.toString().padLeft(2, '0')}',
        );
      },
    );
  }
}

class TimeField extends StatelessWidget {
  const TimeField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.minuteStep = 5,
  });

  final String label;

  /// "HH:MM", venue-local.
  final String value;
  final ValueChanged<String> onChanged;

  /// Times are rounded to this many minutes, because a grid step is never 37.
  final int minuteStep;

  @override
  Widget build(BuildContext context) => _PickerField(
        label: label,
        text: value,
        icon: Icons.schedule_rounded,
        onTap: () async {
          final minutes = AppTime.minutesOfDay(value) ?? 18 * 60;
          final picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60),
          );
          if (picked == null) return;
          final rounded =
              (picked.minute / minuteStep).round() * minuteStep % 60;
          final carry = (picked.minute / minuteStep).round() * minuteStep ~/ 60;
          final hour = (picked.hour + carry) % 24;
          onChanged(
            '${hour.toString().padLeft(2, '0')}:'
            '${rounded.toString().padLeft(2, '0')}',
          );
        },
      );
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String text;
  final IconData icon;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppType.caption.copyWith(color: p.ink3)),
        const SizedBox(height: 6),
        Material(
          color: p.card,
          borderRadius: BorderRadius.circular(Radii.md),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(Radii.md),
            child: Ink(
              height: 54,
              padding: const EdgeInsets.symmetric(horizontal: Spacing.x3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Radii.md),
                border: Border.all(color: p.rule),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppType.body.copyWith(color: p.ink),
                    ),
                  ),
                  Icon(icon, size: 18, color: p.ink3),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
