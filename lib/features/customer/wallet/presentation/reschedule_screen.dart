import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/money/money.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/theme/venue_accent.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/ui/slot_tile.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../booking/domain/availability.dart';
import '../../booking/domain/booking.dart';
import '../application/reschedule_controller.dart';
import '../application/wallet_controller.dart';
import '../domain/manage_repository.dart';

/// C10 · Reschedule. Same space, another open slot, within the venue's own
/// notice and horizon rules — the server re-checks all of it.
class RescheduleScreen extends ConsumerStatefulWidget {
  const RescheduleScreen({super.key, required this.slug, required this.token});

  final String slug;
  final String token;

  @override
  ConsumerState<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends ConsumerState<RescheduleScreen> {
  Slot? _selected;
  bool _busy = false;

  Future<void> _move(Booking booking) async {
    final slot = _selected;
    if (slot == null) return;
    setState(() => _busy = true);
    try {
      final outcome = await ref.read(rescheduleControllerProvider.notifier).move(
            venueSlug: widget.slug,
            token: widget.token,
            startsAt: slot.startsAt,
            endsAt: slot.endsAt,
          );
      if (!mounted) return;
      setState(() => _busy = false);
      switch (outcome) {
        case Rescheduled():
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Your booking has been moved.')),
          );
        case RescheduleSlotTaken():
          setState(() => _selected = null);
          ref.invalidate(rescheduleOptionsProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('That slot just went — pick another.')),
          );
        case RescheduleRefused(:final reason):
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(reason)));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(bookingDetailProvider(widget.slug, widget.token));
    return AsyncView(
      value: detail,
      onRetry: () => ref.invalidate(bookingDetailProvider(widget.slug, widget.token)),
      data: (view) => VenueAccent(
        theme: view.booking.venue.theme,
        child: _body(view.booking),
      ),
    );
  }

  Widget _body(Booking booking) {
    final p = context.palette;
    final zone = booking.venue.timezone;
    final options = ref.watch(
      rescheduleOptionsProvider(venueSlug: widget.slug, token: widget.token),
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reschedule', style: AppType.displayAt(20).copyWith(color: p.ink)),
            Text(
              '${booking.reference} · ${booking.space.name}',
              style: AppType.caption.copyWith(color: p.ink3),
            ),
          ],
        ),
      ),
      body: AsyncView(
        value: options,
        onRetry: () => ref.invalidate(rescheduleOptionsProvider),
        data: (days) => days.isEmpty
            ? const EmptyState(
                icon: Icons.event_busy_rounded,
                title: 'Nothing open this week',
                hint: 'Every slot on this space is taken for now. Try again later, or '
                    'cancel and book a different space.',
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(
                  Spacing.gutter,
                  Spacing.x2,
                  Spacing.gutter,
                  Spacing.x8,
                ),
                children: [
                  _CurrentVsNew(booking: booking, selected: _selected, zone: zone),
                  const SizedBox(height: Spacing.x5),
                  for (final day in days) ...[
                    Eyebrow(_dayLabel(day.date, zone)),
                    const SizedBox(height: Spacing.x3),
                    GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: Spacing.x2,
                      crossAxisSpacing: Spacing.x2,
                      childAspectRatio: 110 / 60,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (final slot in day.slots)
                          SlotTile(
                            label: slot.label,
                            reason: slot.reason,
                            priceCents: slot.priceCents,
                            currency: booking.venue.currency,
                            peak: slot.peak,
                            selected: _selected?.startsAt == slot.startsAt,
                            onTap: () => setState(() => _selected = slot),
                          ),
                      ],
                    ),
                    const SizedBox(height: Spacing.x5),
                  ],
                  AppBanner(
                    kind: BannerKind.info,
                    title: 'Same space, same rules',
                    body: booking.venue.currency == 'PHP'
                        ? 'Peak slots may cost more than your current booking.'
                        : 'Peak slots may cost more.',
                  ),
                ],
              ),
      ),
      bottomNavigationBar: _selected == null
          ? null
          : StickyFooter(
              child: FilledButton(
                onPressed: _busy ? null : () => _move(booking),
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
                child: _busy
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        'Move to ${AppTime.formatDay(_selected!.startsAt, zone)}, '
                        '${_selected!.label}',
                      ),
              ),
            ),
    );
  }

  static String _dayLabel(String date, String zone) {
    final start = AppTime.startOfLocalDay(date, zone);
    return start == null ? date : AppTime.formatDay(start, zone);
  }
}

class _CurrentVsNew extends StatelessWidget {
  const _CurrentVsNew({required this.booking, required this.selected, required this.zone});

  final Booking booking;
  final Slot? selected;
  final String zone;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    Widget side(String label, String value, Color color) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label.toUpperCase(), style: AppType.eyebrow.copyWith(color: p.ink3)),
              const SizedBox(height: 3),
              Text(value, style: AppType.bodyStrong.copyWith(color: color)),
            ],
          ),
        );

    return AppCard(
      color: selected == null ? p.card : p.pineSoft,
      borderColor: selected == null ? null : p.pineLine,
      child: Row(
        children: [
          side(
            'Current',
            '${AppTime.formatDay(booking.startsAt, zone)} · ${AppTime.formatTime(booking.startsAt, zone)}',
            p.ink,
          ),
          Icon(Icons.arrow_forward_rounded, size: 18, color: p.ink3),
          const SizedBox(width: Spacing.x3),
          side(
            'New',
            selected == null
                ? 'Pick a slot'
                : '${AppTime.formatDay(selected!.startsAt, zone)} · ${selected!.label}',
            selected == null ? p.ink3 : p.pineInk,
          ),
        ],
      ),
    );
  }
}

/// Price difference helper kept near the screen that shows it.
String priceDelta(int from, int to, String currency) {
  final diff = to - from;
  if (diff == 0) return 'Same price';
  final sign = diff > 0 ? '+' : '−';
  return '$sign${Money.format(diff.abs(), currency: currency)}';
}
