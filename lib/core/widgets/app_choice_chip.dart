import 'package:flutter/material.dart';

import '../theme/palette.dart';
import '../theme/typography.dart';

/// A pick-one chip in the app's own colours.
///
/// Material's default paints a selected chip's label from the colour scheme
/// rather than from these tokens, and against this theme that came out the
/// same shade as the selected background — so a chosen day, or a chosen venue
/// theme, showed as a filled pill with nothing written on it. Every chip goes
/// through here so that cannot come back one screen at a time.
class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
      selectedColor: p.ink,
      labelStyle: AppType.buttonS.copyWith(color: selected ? p.paper : p.ink2),
    );
  }
}
