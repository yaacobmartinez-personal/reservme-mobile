import 'package:flutter/material.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/ui/app_banner.dart';

/// The chrome every space-editor sheet shares: a title, an optional subtitle,
/// the fields, an inline refusal, and one primary button.
///
/// Refusals show in place rather than as a snackbar, because the field that
/// caused them is still on screen and still editable.
class SheetShell extends StatelessWidget {
  const SheetShell({
    super.key,
    required this.title,
    required this.primaryLabel,
    required this.onPrimary,
    required this.children,
    this.subtitle,
    this.error,
    this.busy = false,
  });

  final String title;
  final String? subtitle;
  final String? error;
  final bool busy;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          Spacing.gutter,
          Spacing.x4,
          Spacing.gutter,
          Spacing.x4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: AppType.displayAt(26).copyWith(color: p.ink)),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(subtitle!, style: AppType.bodyS.copyWith(color: p.ink3)),
            ],
            const SizedBox(height: Spacing.x4),
            ...children,
            if (error != null) ...[
              const SizedBox(height: Spacing.x3),
              AppBanner(kind: BannerKind.error, title: error!),
            ],
            const SizedBox(height: Spacing.x4),
            FilledButton(
              onPressed: busy ? null : onPrimary,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text(primaryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
