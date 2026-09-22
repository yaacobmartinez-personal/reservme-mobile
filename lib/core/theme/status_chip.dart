import 'package:flutter/material.dart';

import '../model/enums.dart';
import 'palette.dart';
import 'spacing.dart';
import 'typography.dart';

/// Colour families for chips (design canvas, Atoms · Chips & badges).
enum ChipTone { pine, clay, neutral, danger, warn, band, ink }

/// A soft pill label: booking statuses, counts, "6 open today". Reads the
/// palette so it follows dark mode and venue accents. [dot] adds a leading
/// status dot; [large] is the 28 px variant for card corners.
class StatusChip extends StatelessWidget {
  const StatusChip(
    this.label, {
    super.key,
    this.tone = ChipTone.neutral,
    this.dot = false,
    this.large = false,
  });

  /// The chip for a booking status, with the canvas colours.
  factory StatusChip.status(ReservationStatus status, {DateTime? checkedInAt, String? checkedInLabel}) {
    if (checkedInAt != null) {
      return StatusChip(checkedInLabel ?? 'Checked in', tone: ChipTone.pine);
    }
    return switch (status) {
      ReservationStatus.confirmed => const StatusChip('Confirmed'),
      ReservationStatus.held => const StatusChip('Held', tone: ChipTone.warn),
      ReservationStatus.noShow => const StatusChip('No-show', tone: ChipTone.clay),
      ReservationStatus.cancelled => const StatusChip('Cancelled', tone: ChipTone.danger),
    };
  }

  final String label;
  final ChipTone tone;
  final bool dot;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (bg, fg) = switch (tone) {
      ChipTone.pine => (p.pineSoft, p.pineInk),
      ChipTone.clay => (p.claySoft, p.clayInk),
      ChipTone.neutral => (p.paper2, p.ink2),
      ChipTone.danger => (p.dangerSoft, p.danger),
      ChipTone.warn => (p.warnSoft, p.warn),
      ChipTone.band => (p.bandInk.withValues(alpha: 0.16), p.bandInk),
      ChipTone.ink => (p.ink, p.paper),
    };
    return Container(
      height: large ? 28 : 22,
      padding: EdgeInsets.symmetric(horizontal: large ? Spacing.x3 : Spacing.x2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(Radii.pill)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: (large ? AppType.buttonS : AppType.captionStrong).copyWith(color: fg),
            ),
          ),
        ],
      ),
    );
  }
}
