import 'package:flutter/material.dart';

import '../theme/palette.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// Small pieces every screen uses (design canvas, Atoms + Molecules): the
/// eyebrow label, the bordered card, the KPI tile, the 40 px round icon
/// button, and the section title row.

/// "RECENT VENUES" — uppercase tracking label above a group.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Text(
        text.toUpperCase(),
        style: AppType.eyebrow.copyWith(color: color ?? context.palette.ink3),
      );
}

/// The standard bordered card: card fill, 1 px rule, 16 px radius, 12 px pad.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Spacing.x3),
    this.onTap,
    this.color,
    this.borderColor,
    this.radius = Radii.card,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: BorderSide(color: borderColor ?? p.rule),
    );
    return Material(
      color: color ?? p.card,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// A KPI tile: a serif number over a caption. [dark] is the pine-ink variant
/// used for the money tile.
class KpiTile extends StatelessWidget {
  const KpiTile({super.key, required this.value, required this.label, this.dark = false});

  final String value;
  final String label;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final bg = dark ? p.pineInk : p.card;
    final fg = dark ? p.paper : p.ink;
    final sub = dark ? const Color(0xFF9FD4BB) : p.ink3;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: Spacing.x3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.md),
        border: Border.all(color: dark ? p.pineInk : p.rule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value, style: AppType.numeral.copyWith(color: fg, fontSize: dark ? 22 : 24)),
          ),
          const SizedBox(height: 4),
          Text(label, style: AppType.captionStrong.copyWith(color: sub, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

/// 40 px circular icon button on a card fill with a rule — app-bar back,
/// share, calendar.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.onBand = false,
    this.size = 40,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;

  /// Translucent paper on a dark cover instead of the card fill.
  final bool onBand;
  final double size;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      button: true,
      label: tooltip,
      child: Material(
        color: onBand ? p.bandInk.withValues(alpha: 0.92) : p.card,
        shape: CircleBorder(side: onBand ? BorderSide.none : BorderSide(color: p.rule)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(icon, size: size * 0.5, color: onBand ? AppPalette.light.ink : p.ink),
          ),
        ),
      ),
    );
  }
}

/// Screen header with an eyebrow line, a serif title, and an optional
/// trailing widget (design canvas: Today, Bookings, Customers, More).
class BigHeader extends StatelessWidget {
  const BigHeader({super.key, required this.eyebrow, required this.title, this.trailing});

  final String eyebrow;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(Spacing.gutter, Spacing.x2, Spacing.gutter, Spacing.x3),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eyebrow, style: AppType.caption.copyWith(color: p.ink3)),
                const SizedBox(height: 2),
                Text(title, style: AppType.displayL.copyWith(color: p.ink, fontSize: 28)),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// The sticky bottom bar with a primary CTA (and optional summary on the
/// left), sitting above the safe area.
class StickyFooter extends StatelessWidget {
  const StickyFooter({super.key, required this.child, this.transparent = false});

  final Widget child;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      decoration: BoxDecoration(
        color: transparent ? p.paper : p.card,
        border: Border(top: BorderSide(color: p.rule)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.gutter, Spacing.x3, Spacing.gutter, Spacing.x3),
          child: child,
        ),
      ),
    );
  }
}
