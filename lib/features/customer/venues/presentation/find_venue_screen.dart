import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/clock.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../shell/application/app_mode_controller.dart';
import '../application/venue_controller.dart';
import '../domain/recent_venue.dart';

/// C1 · Find a venue. The whole customer side starts here: a venue code, a
/// QR, a pasted link, or one of the venues this phone has opened before.
class FindVenueScreen extends ConsumerStatefulWidget {
  const FindVenueScreen({super.key});

  @override
  ConsumerState<FindVenueScreen> createState() => _FindVenueScreenState();
}

class _FindVenueScreenState extends ConsumerState<FindVenueScreen> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _open() {
    final slug = VenueCode.normalize(_controller.text);
    if (slug == null) {
      setState(() => _error = "That doesn't look like a venue code.");
      return;
    }
    setState(() => _error = null);
    FocusScope.of(context).unfocus();
    context.push(Routes.venue(slug));
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final recents = ref.watch(recentVenuesProvider);
    final hasVenueAccess = ref.watch(authControllerProvider).hasVenueAccess;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            Spacing.gutter,
            Spacing.x8,
            Spacing.gutter,
            Spacing.x6,
          ),
          children: [
            Text(
              'Where are you playing?',
              style: AppType.displayL.copyWith(color: p.ink, fontSize: 34),
            ),
            const SizedBox(height: 6),
            Text(
              "Enter the venue's code or scan the QR on its booking page. "
              'No account needed.',
              style: AppType.bodyL.copyWith(color: p.ink2),
            ),
            const SizedBox(height: Spacing.x6),
            const Eyebrow('Venue code'),
            const SizedBox(height: Spacing.x3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autocorrect: false,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (_) => _open(),
                    decoration: InputDecoration(
                      prefixText: 'reservme.pro/',
                      hintText: 'your-venue',
                      errorText: _error,
                    ),
                  ),
                ),
                const SizedBox(width: Spacing.x3),
                SizedBox(
                  width: 52,
                  height: 52,
                  child: FilledButton(
                    onPressed: _open,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Radii.md),
                      ),
                    ),
                    child: const Icon(Icons.arrow_forward_rounded, size: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.x3),
            OutlinedButton.icon(
              onPressed: () => context.push(Routes.scan),
              icon: const Icon(Icons.qr_code_scanner_rounded, size: 20),
              label: const Text('Scan a venue QR'),
              style: OutlinedButton.styleFrom(
                backgroundColor: p.pineSoft,
                foregroundColor: p.pineInk,
                side: BorderSide(color: p.pineLine),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Radii.md),
                ),
              ),
            ),
            const SizedBox(height: Spacing.x6),
            recents.when(
              data: (rows) => rows.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Eyebrow('Recent venues'),
                        const SizedBox(height: Spacing.x3),
                        for (final r in rows) ...[
                          _RecentVenueCard(row: r),
                          const SizedBox(height: Spacing.x3),
                        ],
                      ],
                    ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: Spacing.x4),
            AppBanner(
              kind: BannerKind.info,
              title: 'Run a venue?',
              body: hasVenueAccess
                  ? 'Switch to venue mode for the run sheet.'
                  : 'Sign in as staff to open the run sheet.',
              actionLabel: hasVenueAccess ? 'Switch' : 'Sign in',
              onAction: () {
                if (hasVenueAccess) {
                  ref.read(appModeControllerProvider.notifier).set(AppMode.venue);
                  context.go(AppMode.venue.home);
                } else {
                  context.push(Routes.login);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentVenueCard extends ConsumerWidget {
  const _RecentVenueCard({required this.row});

  final RecentVenue row;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final booked = row.lastBookedAt;
    final now = ref.watch(clockProvider)();

    return AppCard(
      onTap: () => context.push(Routes.venue(row.slug)),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: p.pineInk,
              borderRadius: BorderRadius.circular(Radii.sm),
            ),
            alignment: Alignment.center,
            child: Text(
              row.name.characters.first.toUpperCase(),
              style: AppType.displayS.copyWith(color: p.pineLine, fontSize: 24),
            ),
          ),
          const SizedBox(width: Spacing.x3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.displayS.copyWith(color: p.ink, fontSize: 18),
                ),
                if (row.tagline != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    row.tagline!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppType.bodyS.copyWith(color: p.ink2),
                  ),
                ],
                const SizedBox(height: 3),
                Text(
                  booked == null
                      ? 'Visited ${_ago(now.difference(row.openedAt))}'
                      : 'Booked ${_ago(now.difference(booked))}',
                  style: AppType.captionStrong.copyWith(
                    color: booked == null ? p.ink3 : p.pine,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: p.ink3),
        ],
      ),
    );
  }

  static String _ago(Duration d) {
    if (d.inMinutes < 60) return 'just now';
    if (d.inHours < 24) return '${d.inHours}h ago';
    if (d.inDays == 1) return 'yesterday';
    if (d.inDays < 30) return '${d.inDays} days ago';
    return 'a while ago';
  }
}
