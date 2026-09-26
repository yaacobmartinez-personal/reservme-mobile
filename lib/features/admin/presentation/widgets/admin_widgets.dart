import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core/model/enums.dart';
import '../../../../core/money/money.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/primitives.dart';
import '../../domain/admin.dart';

/// Rows in one card, divided — the grouped-list look of More and Account.
class AdminGroup extends StatelessWidget {
  const AdminGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => AppCard(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            for (final (i, child) in children.indexed) ...[
              if (i > 0) const Divider(height: 1),
              child,
            ],
          ],
        ),
      );
}

/// A section label with the space the screens put around it.
class AdminSection extends StatelessWidget {
  const AdminSection(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: Spacing.x5, bottom: Spacing.x2),
        child: Eyebrow(title),
      );
}

String billingStatusLabel(BillingStatus status) => switch (status) {
      BillingStatus.trialing => 'Trial',
      BillingStatus.active => 'Paid',
      BillingStatus.pastDue => 'Past due',
      BillingStatus.cancelled => 'Cancelled',
      BillingStatus.comped => 'Comped',
    };

/// Where a venue stands, in one chip. Access problems outrank billing ones:
/// a suspended venue is taking no bookings whatever its plan says.
class TenantStatusChip extends StatelessWidget {
  const TenantStatusChip({
    super.key,
    required this.suspended,
    required this.billingSuspended,
    required this.subscription,
  });

  final bool suspended;
  final bool billingSuspended;
  final TenantSubscription subscription;

  @override
  Widget build(BuildContext context) {
    if (billingSuspended) {
      return const StatusChip('Off — unpaid', tone: ChipTone.danger, dot: true);
    }
    if (suspended) return const StatusChip('Suspended', tone: ChipTone.danger, dot: true);
    if (subscription.dueNow) return const StatusChip('Overdue', tone: ChipTone.warn, dot: true);
    return switch (subscription.status) {
      BillingStatus.trialing => StatusChip(
          subscription.trialDaysLeft == 1
              ? 'Trial · 1 day left'
              : 'Trial · ${subscription.trialDaysLeft} days left',
        ),
      BillingStatus.active => const StatusChip('Paid', tone: ChipTone.pine),
      BillingStatus.comped => const StatusChip('Comped', tone: ChipTone.band),
      BillingStatus.pastDue => const StatusChip('Past due', tone: ChipTone.warn),
      BillingStatus.cancelled => const StatusChip('Cancelled', tone: ChipTone.clay),
    };
  }
}

/// A venue in a list: name, slug, the one-line numbers, and its status.
class TenantTile extends StatelessWidget {
  const TenantTile({super.key, required this.tenant, this.onTap});

  final TenantSummary tenant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final spaces = tenant.activeSpaces == 1 ? '1 space' : '${tenant.activeSpaces} spaces';
    return ListTile(
      onTap: onTap,
      title: Text(tenant.name, style: AppType.bodyStrong),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          '${tenant.slug} · $spaces · ${tenant.bookingsLast30} bookings in 30 days',
          style: AppType.caption.copyWith(color: p.ink3),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: TenantStatusChip(
        suspended: tenant.suspended,
        billingSuspended: tenant.billingSuspended,
        subscription: tenant.subscription,
      ),
    );
  }
}

/// The band a venue sits in, with its price when it has one.
String bandLine(TenantBand band) => band.priceCents == null
    ? '${band.name} · quoted'
    : '${band.name} · ${Money.format(band.priceCents!)}/mo';

/// A receipt or QR from wherever it lives: a storage URL, a data URL (the
/// fallback when no bucket is configured), or a fake-mode placeholder.
class AdminImage extends StatelessWidget {
  const AdminImage({super.key, required this.url, this.height = 180});

  final String url;
  final double height;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Widget placeholder(String text) => Container(
          height: height,
          alignment: Alignment.center,
          color: p.paper2,
          child: Text(text, style: AppType.caption.copyWith(color: p.ink3)),
        );

    final Widget image;
    if (url.startsWith('data:')) {
      final comma = url.indexOf(',');
      try {
        image = Image.memory(
          base64Decode(url.substring(comma + 1)),
          height: height,
          fit: BoxFit.contain,
        );
      } catch (_) {
        return placeholder("This image can't be shown.");
      }
    } else if (url.startsWith('http')) {
      image = Image.network(
        url,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) => placeholder("This image can't be loaded."),
      );
    } else {
      return placeholder('Image attached');
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.sm),
      child: ColoredBox(color: p.paper2, child: Center(child: image)),
    );
  }
}

/// KPI tiles three to a row, each row as tall as its tallest tile. A fixed
/// aspect-ratio grid clipped the tiles by 6px on a 360pt phone, and would do
/// worse with the text size turned up.
class KpiRows extends StatelessWidget {
  const KpiRows({super.key, required this.tiles, this.perRow = 3});

  final List<Widget> tiles;
  final int perRow;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < tiles.length; i += perRow) {
      final slice = tiles.sublist(i, (i + perRow).clamp(0, tiles.length));
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (j, tile) in slice.indexed) ...[
              if (j > 0) const SizedBox(width: Spacing.x2),
              Expanded(child: tile),
            ],
            // Keep a short last row's tiles the same width as the rest.
            for (var k = slice.length; k < perRow; k++) ...[
              const SizedBox(width: Spacing.x2),
              const Expanded(child: SizedBox.shrink()),
            ],
          ],
        ),
      ));
    }
    return Column(
      children: [
        for (final (i, row) in rows.indexed) ...[
          if (i > 0) const SizedBox(height: Spacing.x2),
          row,
        ],
      ],
    );
  }
}
