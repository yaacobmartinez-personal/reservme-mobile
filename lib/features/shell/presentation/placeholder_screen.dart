import 'package:flutter/material.dart';

import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/empty_state.dart';

/// Stand-in for a screen that a later phase builds. Names the design board it
/// will implement so the router can be wired end-to-end now.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.board,
    this.subtitle,
    this.showBack = false,
  });

  final String title;

  /// The design-canvas board id, e.g. "C3 · Venue page".
  final String board;
  final String? subtitle;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      appBar: showBack ? AppBar(title: Text(title)) : null,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!showBack)
              Padding(
                padding: const EdgeInsets.fromLTRB(Spacing.gutter, Spacing.x2, Spacing.gutter, 0),
                child: Text(title, style: AppType.displayL.copyWith(color: p.ink, fontSize: 28)),
              ),
            Expanded(
              child: EmptyState(
                icon: Icons.construction_rounded,
                title: board,
                hint: subtitle ?? 'Built in a later phase — see docs/PLAN.md.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
