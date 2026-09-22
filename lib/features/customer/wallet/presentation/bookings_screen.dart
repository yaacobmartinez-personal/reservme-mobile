import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../booking/domain/booking.dart';
import '../application/wallet_controller.dart';

/// C9 · My bookings. The wallet: everything this phone has booked or
/// imported, since there is no account to look them up from.
class BookingsScreen extends ConsumerStatefulWidget {
  const BookingsScreen({super.key});

  @override
  ConsumerState<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends ConsumerState<BookingsScreen> {
  bool _past = false;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final wallet = ref.watch(walletProvider);
    final now = ref.watch(clockProvider)();

    return Scaffold(
      body: SafeArea(
        child: wallet.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => const Center(child: Text('Could not open your bookings.')),
          data: (all) {
            final upcoming = all
                .where((b) => !b.isCancelled && b.endsAt.isAfter(now))
                .toList(growable: false);
            final past = all
                .where((b) => b.isCancelled || !b.endsAt.isAfter(now))
                .toList(growable: false)
                .reversed
                .toList(growable: false);
            final shown = _past ? past : upcoming;

            return Column(
              children: [
                BigHeader(
                  eyebrow: upcoming.isEmpty
                      ? 'Nothing coming up'
                      : '${upcoming.length} upcoming',
                  title: 'Bookings',
                ),
                if (all.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      Spacing.gutter,
                      0,
                      Spacing.gutter,
                      Spacing.x3,
                    ),
                    child: SegmentedButton<bool>(
                      showSelectedIcon: false,
                      style: SegmentedButton.styleFrom(textStyle: AppType.buttonS),
                      segments: const [
                        ButtonSegment(value: false, label: Text('Upcoming')),
                        ButtonSegment(value: true, label: Text('Past')),
                      ],
                      selected: {_past},
                      onSelectionChanged: (s) => setState(() => _past = s.first),
                    ),
                  ),
                Expanded(
                  child: shown.isEmpty
                      ? EmptyState(
                          icon: Icons.calendar_today_rounded,
                          title: _past ? 'Nothing here yet' : 'No bookings yet',
                          hint: _past
                              ? 'Past and cancelled bookings show up here.'
                              : 'Bookings you make here appear here — or open a '
                                  'manage link from your confirmation email.',
                          action: _past
                              ? null
                              : FilledButton(
                                  onPressed: () => context.go(Routes.customerFind),
                                  child: const Text('Find a venue'),
                                ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(
                            Spacing.gutter,
                            0,
                            Spacing.gutter,
                            Spacing.x8,
                          ),
                          itemCount: shown.length,
                          separatorBuilder: (_, _) => const SizedBox(height: Spacing.x3),
                          itemBuilder: (context, i) => _WalletRow(booking: shown[i]),
                        ),
                ),
                if (all.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      Spacing.x8,
                      0,
                      Spacing.x8,
                      Spacing.x3,
                    ),
                    child: Text(
                      'Got a confirmation email? Open its link on this phone and the '
                      'booking is added here.',
                      textAlign: TextAlign.center,
                      style: AppType.caption.copyWith(color: p.ink3),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _WalletRow extends StatelessWidget {
  const _WalletRow({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final zone = booking.venue.timezone;

    return AppCard(
      onTap: () => context.push(
        Routes.booking(booking.venue.slug, booking.manageToken ?? ''),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: p.pineInk,
              borderRadius: BorderRadius.circular(Radii.sm),
            ),
            alignment: Alignment.center,
            child: Text(
              booking.venue.name.characters.first.toUpperCase(),
              style: AppType.displayS.copyWith(color: p.pineLine, fontSize: 20),
            ),
          ),
          const SizedBox(width: Spacing.x3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.venue.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.bodyStrong.copyWith(color: p.ink),
                ),
                const SizedBox(height: 2),
                Text(
                  '${AppTime.formatDay(booking.startsAt, zone)} · '
                  '${AppTime.formatTime(booking.startsAt, zone)} · ${booking.space.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.bodyS.copyWith(color: p.ink2),
                ),
                const SizedBox(height: 3),
                Text(
                  booking.reference,
                  style: AppType.reference.copyWith(color: p.ink3, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.x2),
          StatusChip.status(booking.status, checkedInAt: booking.checkedInAt),
        ],
      ),
    );
  }
}
