import 'package:flutter/material.dart';

import '../model/enums.dart';
import '../theme/palette.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// What a space shows when the owner has not uploaded a photo (design canvas,
/// Molecules · Cards): the kind's glyph on pine-soft with faint diagonal
/// lines. Used everywhere a space image would go — customer cards, the space
/// editor hero, the onboarding preview — so there is never a grey box.
class KindPlaceholder extends StatelessWidget {
  const KindPlaceholder({
    super.key,
    required this.kind,
    this.width = 72,
    this.height = 72,
    this.radius = Radii.sm,
    this.label,
  });

  final SpaceKind kind;
  final double width;
  final double height;
  final double radius;

  /// Optional caption, e.g. "No photo yet" on the large editor hero.
  final String? label;

  static IconData iconFor(SpaceKind kind) => switch (kind) {
        SpaceKind.court => Icons.grid_view_rounded,
        SpaceKind.room => Icons.meeting_room_outlined,
        SpaceKind.studio => Icons.star_border_rounded,
        SpaceKind.table => Icons.groups_outlined,
        SpaceKind.tour => Icons.place_outlined,
        SpaceKind.other => Icons.more_horiz_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final large = width >= 60;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
          painter: _HatchPainter(background: p.pineSoft, line: p.pineLine),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconFor(kind), size: large ? 26 : 18, color: p.pineInk),
              if (label != null) ...[
                const SizedBox(height: 6),
                Text(
                  label!.toUpperCase(),
                  style: AppType.eyebrow.copyWith(color: p.pineInk, fontSize: 10),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HatchPainter extends CustomPainter {
  const _HatchPainter({required this.background, required this.line});

  final Color background;
  final Color line;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = background);
    final paint = Paint()
      ..color = line.withValues(alpha: 0.33)
      ..strokeWidth = 2;
    // 135° lines every 12 px, drawn across the whole box.
    final span = size.width + size.height;
    for (var d = -size.height; d < span; d += 12) {
      canvas.drawLine(Offset(d, 0), Offset(d + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(_HatchPainter old) => old.background != background || old.line != line;
}
