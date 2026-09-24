import 'package:flutter/material.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';

/// The venue's initial on a pine tile — the stand-in until venue logos are
/// uploadable (Phase 3c).
///
/// It uses the accent pair (`pine` / `onPine`) rather than `pineInk` /
/// `pineLine`: those two swap roles between the themes, so a strong tile with
/// a pale letter in light mode became a pale tile with a dark letter in dark
/// mode. The accent pair is defined to contrast in both.
class VenueAvatar extends StatelessWidget {
  const VenueAvatar({super.key, required this.name, this.size = 56});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final initial = name.trim().isEmpty ? '?' : name.trim().characters.first;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: p.pine,
        borderRadius: BorderRadius.circular(Spacing.x3),
      ),
      alignment: Alignment.center,
      child: Text(
        initial.toUpperCase(),
        style: AppType.displayAt(size * 0.4).copyWith(color: p.onPine),
      ),
    );
  }
}
