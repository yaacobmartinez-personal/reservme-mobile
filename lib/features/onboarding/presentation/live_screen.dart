import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/config/app_config.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/motion.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/photos.dart';
import '../../../core/ui/primitives.dart';
import '../../shell/application/app_mode_controller.dart';
import '../../venue/venues/application/selected_venue_controller.dart';
import '../application/onboarding_controller.dart';

/// O7 · You're live. The end of the flow: the booking link to share, the QR
/// for the front desk, and the two things worth doing next.
class LiveScreen extends ConsumerWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final animate = ref.watch(motionSettingsProvider);
    final draft = ref.watch(onboardingProvider);
    final venue = ref.watch(selectedVenueProvider);

    final name = venue?.name ?? draft.venueName ?? 'Your venue';
    final slug = venue?.slug ?? draft.venueSlug ?? '';
    final url = '${AppConfig.publicOrigin}/$slug';
    final space = draft.spaceName ?? 'your space';

    Future<void> openRunSheet() async {
      await ref.read(onboardingProvider.notifier).finish();
      if (!context.mounted) return;
      ref.read(appModeControllerProvider.notifier).set(AppMode.venue);
      context.go(AppMode.venue.home);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  Spacing.gutter,
                  Spacing.x6,
                  Spacing.gutter,
                  Spacing.x6,
                ),
                children: [
                  Center(child: _Tick(animate: animate)),
                  const SizedBox(height: Spacing.x3),
                  Text(
                    '$name is live',
                    textAlign: TextAlign.center,
                    style: AppType.displayAt(34).copyWith(color: p.ink),
                  ).enter(enabled: animate),
                  const SizedBox(height: Spacing.x2),
                  Text(
                    'Customers can book $space right now. Share your page, or '
                    'print the QR for the front desk.',
                    textAlign: TextAlign.center,
                    style: AppType.bodyL.copyWith(color: p.ink2),
                  ).enter(delay: Motion.stagger, enabled: animate),
                  const SizedBox(height: Spacing.x5),
                  _BookingCard(url: url, animate: animate),
                  const SizedBox(height: Spacing.x3),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _copy(context, url),
                          icon: const Icon(Icons.link_rounded, size: 18),
                          label: const Text('Copy link'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                          ),
                        ),
                      ),
                      const SizedBox(width: Spacing.x2),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => SharePlus.instance.share(
                            ShareParams(
                              text: 'Book $name online: $url',
                              subject: 'Book at $name',
                            ),
                          ),
                          icon: const Icon(Icons.ios_share_rounded, size: 18),
                          label: const Text('Share'),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                            backgroundColor: p.pineSoft,
                            foregroundColor: p.pineInk,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.x5),
                  const Eyebrow('Next up'),
                  const SizedBox(height: Spacing.x2),
                  AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.add_rounded, color: p.pineInk),
                          title: const Text('Add your other spaces'),
                          subtitle: Text('Copy hours from $space'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () async {
                            await ref.read(onboardingProvider.notifier).finish();
                            if (context.mounted) context.go(Routes.venueSpaces);
                          },
                        ),
                        Divider(height: 1, color: p.rule),
                        ListTile(
                          leading: Icon(Icons.group_outlined, color: p.ink3),
                          title: const Text('Invite your front-desk staff'),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: () async {
                            await ref.read(onboardingProvider.notifier).finish();
                            if (context.mounted) context.go(Routes.venueTeam);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            StickyFooter(
              child: FilledButton(
                onPressed: openRunSheet,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                ),
                child: const Text('Open my run sheet'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copy(BuildContext context, String url) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking link copied.')),
    );
  }
}

/// The check that pops, with a ring behind it. The one moment in the app
/// worth a flourish.
class _Tick extends StatelessWidget {
  const _Tick({required this.animate});

  final bool animate;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final tick = Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(color: p.pine, shape: BoxShape.circle),
      child: Icon(Icons.check_rounded, size: 44, color: p.onPine),
    );

    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(color: p.pineSoft, shape: BoxShape.circle),
          ),
          if (!animate)
            tick
          else
            tick.animate().scale(
                  begin: const Offset(0.4, 0.4),
                  end: const Offset(1, 1),
                  duration: Motion.slow,
                  curve: Curves.elasticOut,
                ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.url, required this.animate});

  final String url;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.card),
      child: Stack(
        children: [
          Image.asset(
            Photos.qr,
            height: 170,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x000B0A09), Color(0xCC0B0A09)],
                ),
              ),
            ),
          ),
          Positioned(
            left: Spacing.x3,
            right: Spacing.x3,
            bottom: Spacing.x3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR BOOKING PAGE',
                  style: AppType.captionStrong.copyWith(
                    color: p.pineLine,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  url.replaceFirst('https://', ''),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.bodyStrong.copyWith(
                    color: const Color(0xFFFBFAF7),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
