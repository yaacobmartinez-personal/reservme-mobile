import 'package:flutter/material.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/typography.dart';

/// The three shapes G5 needs, drawn by hand. A chart library would be more
/// code than this, and would need theming twice over for light and dark.

/// A KPI tile's trend line. Flat when everything is equal, rather than a
/// misleading zig-zag scaled to noise.
class Sparkline extends StatelessWidget {
  const Sparkline({super.key, required this.values, required this.colour});

  final List<num> values;
  final Color colour;

  @override
  Widget build(BuildContext context) => CustomPaint(
        size: Size.infinite,
        painter: _SparklinePainter(values: values, colour: colour),
      );
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.values, required this.colour});

  final List<num> values;
  final Color colour;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2 || size.width <= 0) return;

    final highest = values.reduce((a, b) => a > b ? a : b);
    final lowest = values.reduce((a, b) => a < b ? a : b);
    final span = (highest - lowest).toDouble();

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);
      // A flat series sits in the middle rather than on the floor, which
      // would read as "zero" when it is simply "unchanged".
      final t = span == 0 ? 0.5 : (values[i] - lowest) / span;
      final y = size.height - t * size.height;
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = colour
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.values != values || old.colour != colour;
}

/// Booked value per day. Labels are thinned so a 90-day window does not turn
/// its axis into a smear.
class BarChart extends StatelessWidget {
  const BarChart({super.key, required this.values, required this.labels});

  final List<int> values;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    if (values.isEmpty) return const SizedBox.shrink();
    final highest = values.reduce((a, b) => a > b ? a : b);

    // At most six labels, whatever the window.
    final every = (values.length / 6).ceil().clamp(1, values.length);

    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var i = 0; i < values.length; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      // A day with nothing still draws a sliver, so the gap
                      // reads as "no bookings" and not "no data".
                      heightFactor: highest == 0
                          ? 0.02
                          : (values[i] / highest).clamp(0.02, 1).toDouble(),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: values[i] == 0 ? p.rule : p.pine,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            for (var i = 0; i < values.length; i++)
              Expanded(
                child: i % every == 0
                    ? Text(
                        _dayLabel(labels[i]),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: AppType.caption.copyWith(color: p.ink3),
                      )
                    : const SizedBox.shrink(),
              ),
          ],
        ),
      ],
    );
  }

  /// "2026-09-24" → "24/9".
  static String _dayLabel(String isoDate) {
    final parts = isoDate.split('-');
    if (parts.length != 3) return isoDate;
    return '${int.parse(parts[2])}/${int.parse(parts[1])}';
  }
}

/// Bookings by weekday and hour. Only the hours a venue actually trades are
/// drawn — a full 24 columns on a phone is unreadable and mostly empty.
class Heatmap extends StatelessWidget {
  const Heatmap({super.key, required this.grid, required this.max});

  final List<List<int>> grid;
  final int max;

  static const _firstHour = 6;
  static const _lastHour = 23;

  /// Monday first on screen, stored 0 = Sunday like the column.
  static const _order = [1, 2, 3, 4, 5, 6, 0];
  static const _names = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    if (grid.length < 7) return const SizedBox.shrink();

    return Column(
      children: [
        for (final weekday in _order)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Text(
                    _names[weekday],
                    style: AppType.caption.copyWith(color: p.ink3),
                  ),
                ),
                for (var hour = _firstHour; hour <= _lastHour; hour++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.5),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: _shade(context, grid[weekday][hour]),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Color _shade(BuildContext context, int n) {
    final p = context.palette;
    if (n == 0 || max == 0) return p.rule;
    // Four steps is enough to read a pattern and stays legible in dark mode.
    final step = (n / max * 4).ceil().clamp(1, 4);
    return Color.lerp(p.pineSoft, p.pine, (step - 1) / 3)!;
  }
}
