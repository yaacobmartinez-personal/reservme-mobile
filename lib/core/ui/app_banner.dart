import 'package:flutter/material.dart';

import '../theme/palette.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Inline notice (design canvas, Molecules · Feedback): info, success, warn,
/// error, offline. Sits above content rather than replacing it.
enum BannerKind { info, success, warn, error, offline }

class AppBanner extends StatelessWidget {
  const AppBanner({
    super.key,
    required this.kind,
    required this.title,
    this.body,
    this.actionLabel,
    this.onAction,
  });

  final BannerKind kind;
  final String title;
  final String? body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (bg, fg, icon, iconColor) = switch (kind) {
      BannerKind.info => (p.paper2, p.ink2, Icons.info_outline_rounded, p.ink3),
      BannerKind.success => (p.pineSoft, p.pineInk, Icons.check_rounded, p.pine),
      BannerKind.warn => (p.warnSoft, p.warn, Icons.warning_amber_rounded, p.warn),
      BannerKind.error => (p.dangerSoft, p.danger, Icons.cancel_outlined, p.danger),
      BannerKind.offline => (p.paper3, p.ink2, Icons.wifi_off_rounded, p.ink3),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: Spacing.x3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(Radii.md)),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: Spacing.x3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppType.bodyStrong.copyWith(color: fg, fontSize: 13)),
                if (body != null) ...[
                  const SizedBox(height: 2),
                  Text(body!, style: AppType.caption.copyWith(color: fg)),
                ],
              ],
            ),
          ),
          if (actionLabel != null) ...[
            const SizedBox(width: Spacing.x2),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: fg,
                padding: const EdgeInsets.symmetric(horizontal: Spacing.x2),
                minimumSize: const Size(44, 36),
              ),
              child: Text(actionLabel!, style: AppType.buttonS),
            ),
          ],
        ],
      ),
    );
  }
}
