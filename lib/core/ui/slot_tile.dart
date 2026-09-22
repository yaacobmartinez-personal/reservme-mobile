import 'package:flutter/material.dart';

import '../model/enums.dart';
import '../money/money.dart';
import '../theme/palette.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

/// One slot in the picker grid (design canvas, Molecules · Slots). Every
/// state the availability API can return has its own look, so a customer can
/// tell at a glance why a time is not offered.
class SlotTile extends StatelessWidget {
  const SlotTile({
    super.key,
    required this.label,
    required this.reason,
    required this.priceCents,
    required this.currency,
    this.peak = false,
    this.selected = false,
    this.onTap,
    this.onWaitlist,
  });

  final String label;
  final SlotReason reason;
  final int priceCents;
  final String currency;
  final bool peak;
  final bool selected;
  final VoidCallback? onTap;

  /// Tapping a taken slot offers the waitlist instead of doing nothing.
  final VoidCallback? onWaitlist;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final open = reason == SlotReason.open;

    final (bg, border, borderWidth, labelColor, subColor, sub, struck) = switch (reason) {
      SlotReason.open when selected =>
        (p.pineSoft, p.pine, 2.0, p.pineInk, p.pineInk, Money.format(priceCents, currency: currency), false),
      SlotReason.open => (
          p.card,
          p.pineLine,
          1.0,
          p.ink,
          peak ? p.clayInk : p.pine,
          '${Money.format(priceCents, currency: currency)}${peak ? ' peak' : ''}',
          false,
        ),
      SlotReason.taken => (p.paper3, p.rule, 1.0, p.ink3, p.ink3, 'Taken', true),
      SlotReason.closed => (Colors.transparent, p.rule, 1.0, p.ink3, p.ink3, 'Closed', false),
      SlotReason.tooSoon => (p.card, p.rule, 1.0, p.ink3, p.ink3, 'Too soon', false),
      SlotReason.tooFarAhead => (p.card, p.rule, 1.0, p.ink3, p.ink3, 'Not yet', false),
    };

    final tap = open ? onTap : (reason == SlotReason.taken ? onWaitlist : null);

    return Semantics(
      button: tap != null,
      selected: selected,
      label: '$label, $sub',
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.sm),
          side: BorderSide(
            color: border,
            width: borderWidth,
            style: reason == SlotReason.closed ? BorderStyle.solid : BorderStyle.solid,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: tap,
          child: SizedBox(
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: AppType.bodyStrong.copyWith(
                    color: labelColor,
                    fontSize: 15,
                    decoration: struck ? TextDecoration.lineThrough : null,
                    decorationColor: labelColor,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  sub,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.captionStrong.copyWith(
                    color: subColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A day in the horizontal date strip.
class DatePill extends StatelessWidget {
  const DatePill({
    super.key,
    required this.weekday,
    required this.day,
    required this.selected,
    required this.onTap,
  });

  final String weekday;
  final String day;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? p.pine : p.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          side: BorderSide(color: selected ? p.pine : p.rule),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 54,
            height: 62,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weekday,
                  style: AppType.captionStrong.copyWith(
                    color: selected ? p.onPine.withValues(alpha: 0.8) : p.ink3,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  day,
                  style: AppType.bodyStrong.copyWith(
                    color: selected ? p.onPine : p.ink,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The legend under the "Time" eyebrow.
class SlotLegend extends StatelessWidget {
  const SlotLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Widget item(Color fill, Color? border, String label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: fill,
                borderRadius: BorderRadius.circular(2),
                border: border == null ? null : Border.all(color: border),
              ),
            ),
            const SizedBox(width: 4),
            Text(label, style: AppType.captionStrong.copyWith(color: p.ink3, fontWeight: FontWeight.w400)),
          ],
        );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        item(p.card, p.pineLine, 'Open'),
        const SizedBox(width: Spacing.x3),
        item(p.paper3, null, 'Taken'),
      ],
    );
  }
}
