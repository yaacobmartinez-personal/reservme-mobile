import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/theme/venue_accent.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../application/venue_controller.dart';
import '../domain/public_venue.dart';
import 'widgets/space_card.dart';

/// C3 · Venue page. Public: this is what a shared link or a scanned QR
/// opens, with no sign-in anywhere. The whole page takes the venue's accent.
class VenueScreen extends ConsumerWidget {
  const VenueScreen({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(venueProvider(slug));
    return AsyncView(
      value: venue,
      onRetry: () => ref.invalidate(venueProvider(slug)),
      data: (v) => VenueAccent(theme: v.theme, child: _Body(venue: v)),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.venue});

  final PublicVenue venue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final link = '${AppConfig.publicOrigin}/${venue.slug}';

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(venueProvider(venue.slug).future),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _Cover(venue: venue, link: link)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                Spacing.gutter,
                Spacing.x5,
                Spacing.gutter,
                Spacing.x8,
              ),
              sliver: SliverList.list(
                children: [
                  if (venue.suspended) ...[
                    const AppBanner(
                      kind: BannerKind.warn,
                      title: 'Not taking bookings right now',
                      body: 'Contact the venue directly to reserve a space.',
                    ),
                    const SizedBox(height: Spacing.x4),
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(child: Eyebrow('Spaces')),
                      if (venue.address != null)
                        Flexible(
                          child: Text(
                            venue.address!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: AppType.caption.copyWith(color: p.ink3),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: Spacing.x3),
                  if (venue.spaces.isEmpty)
                    AppCard(
                      child: Text(
                        'This venue has not published any spaces yet.',
                        style: AppType.bodyS.copyWith(color: p.ink2),
                      ),
                    )
                  else
                    for (final space in venue.spaces) ...[
                      SpaceCard(
                        space: space,
                        currency: venue.currency,
                        suspended: venue.suspended,
                        onTap: () => context.push(Routes.space(venue.slug, space.id)),
                      ),
                      const SizedBox(height: Spacing.x3),
                    ],
                  const SizedBox(height: Spacing.x3),
                  _Policy(venue: venue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.venue, required this.link});

  final PublicVenue venue;
  final String link;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final top = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: 340,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (venue.coverUrl != null)
            CachedNetworkImage(
              imageUrl: venue.coverUrl!,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => ColoredBox(color: p.band),
              placeholder: (_, _) => ColoredBox(color: p.band),
            )
          else
            ColoredBox(color: p.band),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: p.scrim,
                stops: const [0.25, 0.75, 1],
              ),
            ),
          ),
          Positioned(
            top: top + Spacing.x2,
            left: Spacing.x4,
            right: Spacing.x4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundIconButton(
                  icon: Icons.arrow_back_rounded,
                  tooltip: 'Back',
                  onBand: true,
                  onPressed: () => context.pop(),
                ),
                RoundIconButton(
                  icon: Icons.ios_share_rounded,
                  tooltip: 'Share venue',
                  onBand: true,
                  onPressed: () => SharePlus.instance.share(
                    ShareParams(uri: Uri.parse(link), subject: venue.name),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: Spacing.gutter,
            right: Spacing.gutter,
            bottom: Spacing.gutter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StatusChip(
                      venue.suspended ? 'Closed' : 'Open for bookings',
                      tone: ChipTone.band,
                      dot: true,
                      large: true,
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.x3),
                Text(
                  venue.name,
                  style: AppType.displayAt(32).copyWith(color: p.bandInk),
                ),
                if (venue.tagline != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    venue.tagline!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppType.body.copyWith(color: p.bandMuted),
                  ),
                ],
                const SizedBox(height: Spacing.x3),
                Row(
                  children: [
                    if (venue.address != null)
                      FilledButton.icon(
                        onPressed: () => launchUrl(
                          Uri.parse(
                            'https://maps.google.com/?q=${Uri.encodeComponent(venue.address!)}',
                          ),
                          mode: LaunchMode.externalApplication,
                        ),
                        icon: const Icon(Icons.place_outlined, size: 16),
                        label: const Text('Directions'),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(0, 36),
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.x4),
                          textStyle: AppType.buttonS,
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
}

class _Policy extends StatelessWidget {
  const _Policy({required this.venue});

  final PublicVenue venue;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Widget line(IconData icon, String text) => Padding(
          padding: const EdgeInsets.only(bottom: Spacing.x2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 18, color: p.ink3),
              const SizedBox(width: Spacing.x3),
              Expanded(child: Text(text, style: AppType.bodyS.copyWith(color: p.ink2))),
            ],
          ),
        );

    return AppCard(
      padding: const EdgeInsets.all(Spacing.x4),
      color: p.paper2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('Good to know'),
          const SizedBox(height: Spacing.x3),
          line(Icons.payments_outlined, 'Pay at the venue — cash, GCash or card on arrival.'),
          line(Icons.event_busy_outlined, venue.policyLine),
          if (venue.refundTerms != null) line(Icons.receipt_long_outlined, venue.refundTerms!),
          line(
            Icons.schedule_rounded,
            'Times are in ${venue.timezone.replaceAll('_', ' ')}.',
          ),
        ],
      ),
    );
  }
}
