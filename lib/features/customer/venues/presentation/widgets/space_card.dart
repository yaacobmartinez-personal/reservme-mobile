import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/money/money.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/status_chip.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/ui/kind_placeholder.dart';
import '../../../../../core/ui/primitives.dart';
import '../../domain/public_venue.dart';

/// A bookable space on the venue page (design canvas, C3). Without a photo it
/// shows the kind placeholder rather than a grey box — most venues ship
/// without photos at first.
class SpaceCard extends StatelessWidget {
  const SpaceCard({
    super.key,
    required this.space,
    required this.currency,
    required this.onTap,
    this.suspended = false,
  });

  final VenueSpace space;
  final String currency;
  final VoidCallback onTap;
  final bool suspended;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final open = space.openToday;

    return AppCard(
      onTap: suspended ? null : onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _thumb(),
          const SizedBox(width: Spacing.x3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and the availability chip share a row, so a long
                // space name shortens instead of squeezing the chip out.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        space.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppType.displayS.copyWith(color: p.ink),
                      ),
                    ),
                    if (!suspended && open != null) ...[
                      const SizedBox(width: Spacing.x2),
                      StatusChip(
                        open == 0 ? 'Full today' : '$open open',
                        tone: open == 0 ? ChipTone.clay : ChipTone.pine,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  space.summary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.bodyS.copyWith(color: p.ink2),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      Money.format(space.priceCents, currency: currency),
                      style: AppType.bodyStrong.copyWith(color: p.pineInk, fontSize: 16),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        _priceSub(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppType.caption.copyWith(color: p.ink3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _thumb() => space.hasPhoto
      ? ClipRRect(
          borderRadius: BorderRadius.circular(Radii.sm),
          child: CachedNetworkImage(
            imageUrl: space.imageUrl!,
            width: 72,
            height: 72,
            fit: BoxFit.cover,
            errorWidget: (_, _, _) => KindPlaceholder(kind: space.kind),
            placeholder: (_, _) => KindPlaceholder(kind: space.kind),
          ),
        )
      : KindPlaceholder(kind: space.kind);

  String _priceSub() {
    final per = space.slotMinutes == 60 ? 'per hour' : 'per ${space.slotMinutes} min';
    if (space.peakPriceCents == null) return per;
    return '$per · ${Money.format(space.peakPriceCents!, currency: currency)} peak';
  }
}
