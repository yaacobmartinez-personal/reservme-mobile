import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/money/money.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/theme/venue_accent.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../booking/domain/booking.dart';
import '../../booking/presentation/booking_form_screen.dart';
import '../application/wallet_controller.dart';
import '../domain/manage_repository.dart';

/// C8 · Booked. The customer's copy of a booking: reference, when, and the
/// two things they can do — cancel (if the venue's policy allows) and move.
class BookingDetailScreen extends ConsumerWidget {
  const BookingDetailScreen({
    super.key,
    required this.slug,
    required this.token,
    this.arrival,
  });

  final String slug;
  final String token;
  final BookingArrival? arrival;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(bookingDetailProvider(slug, token));
    return AsyncView(
      value: detail,
      onRetry: () => ref.invalidate(bookingDetailProvider(slug, token)),
      data: (view) => VenueAccent(
        theme: view.booking.venue.theme,
        child: _Body(view: view, slug: slug, token: token, arrival: arrival),
      ),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body({
    required this.view,
    required this.slug,
    required this.token,
    this.arrival,
  });

  final BookingView view;
  final String slug;
  final String token;
  final BookingArrival? arrival;

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  bool _busy = false;

  Booking get booking => widget.view.booking;

  Future<void> _cancel() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Cancel this booking?',
      message: '${booking.space.name}, ${booking.whenLabel}. The slot goes back on '
          "sale straight away. This can't be undone.",
      confirmLabel: 'Cancel booking',
      cancelLabel: 'Keep it',
      destructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _busy = true);
    try {
      final outcome =
          await ref.read(bookingDetailProvider(widget.slug, widget.token).notifier).cancel();
      if (!mounted) return;
      setState(() => _busy = false);
      final messenger = ScaffoldMessenger.of(context);
      switch (outcome) {
        case Cancelled():
          messenger.showSnackBar(
            const SnackBar(content: Text('Your booking has been cancelled.')),
          );
        case CancelRefused(:final reason):
          messenger.showSnackBar(SnackBar(content: Text(reason)));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _busy = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }

  Future<void> _forget() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Remove from this phone?',
      message: 'The booking itself stays — the venue still has it, and the link in '
          'your confirmation email still opens it.',
      confirmLabel: 'Remove',
      destructive: true,
    );
    if (!confirmed || !mounted) return;
    await ref
        .read(bookingDetailProvider(widget.slug, widget.token).notifier)
        .removeFromPhone();
    if (mounted) context.go(Routes.customerBookings);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final zone = booking.venue.timezone;
    final link = '${AppConfig.publicOrigin}/${booking.venue.slug}/manage/${widget.token}';
    final justBooked = widget.arrival?.justBooked ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        actions: [
          IconButton(
            tooltip: 'Share booking',
            onPressed: () => SharePlus.instance.share(
              ShareParams(
                uri: Uri.parse(link),
                subject: '${booking.venue.name} · ${booking.reference}',
              ),
            ),
            icon: const Icon(Icons.ios_share_rounded),
          ),
          const SizedBox(width: Spacing.x1),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.refresh(bookingDetailProvider(widget.slug, widget.token).future),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            Spacing.gutter,
            Spacing.x2,
            Spacing.gutter,
            Spacing.x8,
          ),
          children: [
            if (justBooked && !booking.isCancelled) ...[
              const AppBanner(
                kind: BannerKind.success,
                title: "You're booked",
                body: 'A confirmation is on its way to your email.',
              ),
              const SizedBox(height: Spacing.x4),
            ],
            if (widget.view.missing) ...[
              const AppBanner(
                kind: BannerKind.error,
                title: 'The venue no longer recognises this booking',
                body: 'It may have been cancelled, or the link rotated. This is the '
                    'copy saved on your phone — check with the venue before turning up.',
              ),
              const SizedBox(height: Spacing.x4),
            ] else if (widget.view.stale) ...[
              AppBanner(
                kind: BannerKind.offline,
                title: "You're offline",
                body: widget.view.lastSyncedAt == null
                    ? 'Showing the copy saved on this phone.'
                    : 'Last checked ${AppTime.formatDay(widget.view.lastSyncedAt!, zone)}.',
                actionLabel: 'Retry',
                onAction: () =>
                    ref.invalidate(bookingDetailProvider(widget.slug, widget.token)),
              ),
              const SizedBox(height: Spacing.x4),
            ],
            _Ticket(booking: booking),
            const SizedBox(height: Spacing.x4),
            if (!booking.isCancelled && !widget.view.missing)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      // Gated on the same rule as Cancel. The policy governs
                      // both, so offering the picker here walked the customer
                      // through seven days of slots to a refusal at the end —
                      // found on a device, with a booking inside its grace
                      // window.
                      onPressed: _busy || !booking.cancellation.canCancel
                          ? null
                          : () => context.push(
                                Routes.reschedule(widget.slug, widget.token),
                              ),
                      icon: const Icon(Icons.event_repeat_rounded, size: 18),
                      label: const Text('Reschedule'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Radii.md),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Spacing.x3),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _busy || !booking.cancellation.canCancel ? null : _cancel,
                      icon: const Icon(Icons.cancel_outlined, size: 18),
                      label: const Text('Cancel'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: p.danger,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Radii.md),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: Spacing.x3),
            Text(
              // The server owns the policy, so its refusal is shown verbatim
              // and the app never invents a deadline of its own.
              widget.view.missing
                  ? 'Contact the venue with reference ${booking.reference}.'
                  : booking.cancellation.reason ??
                      'You can cancel or move this booking online.',
              textAlign: TextAlign.center,
              style: AppType.caption.copyWith(color: p.ink3),
            ),
            const SizedBox(height: Spacing.x6),
            if (booking.venue.address != null)
              OutlinedButton.icon(
                onPressed: () => launchUrl(
                  Uri.parse(
                    'https://maps.google.com/?q=${Uri.encodeComponent(booking.venue.address!)}',
                  ),
                  mode: LaunchMode.externalApplication,
                ),
                icon: const Icon(Icons.place_outlined, size: 18),
                label: const Text('Directions'),
              ),
            const SizedBox(height: Spacing.x3),
            TextButton.icon(
              onPressed: _forget,
              icon: const Icon(Icons.delete_outline_rounded, size: 18),
              label: const Text('Remove from this phone'),
              style: TextButton.styleFrom(foregroundColor: p.ink3),
            ),
          ],
        ),
      ),
    );
  }
}

/// The dark ticket card: reference, when, and the details underneath.
class _Ticket extends StatelessWidget {
  const _Ticket({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final zone = booking.venue.timezone;

    Widget row(String label, String value) => Padding(
          padding: const EdgeInsets.only(bottom: Spacing.x3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppType.bodyS.copyWith(color: p.ink3)),
              const Spacer(),
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: AppType.bodyStrong.copyWith(color: p.ink, fontSize: 14),
                ),
              ),
            ],
          ),
        );

    return Container(
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(Radii.xl),
        border: Border.all(color: p.rule),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Spacing.x4),
            color: p.pineInk,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REFERENCE',
                            style: AppType.eyebrow.copyWith(
                              color: p.pineLine,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            booking.reference,
                            style: AppType.reference.copyWith(
                              color: p.paper,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    StatusChip.status(booking.status, checkedInAt: booking.checkedInAt),
                  ],
                ),
                const SizedBox(height: Spacing.x3),
                Text(
                  AppTime.formatDay(booking.startsAt, zone),
                  style: AppType.displayAt(26).copyWith(color: p.paper),
                ),
                Text(
                  '${AppTime.formatTime(booking.startsAt, zone)} – ${AppTime.formatTime(booking.endsAt, zone)}',
                  style: AppType.displayAt(26).copyWith(color: p.paper),
                ),
                const SizedBox(height: Spacing.x2),
                Text(
                  'Show this reference at the desk. Pay at the venue.',
                  style: AppType.bodyS.copyWith(color: p.pineLine),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(Spacing.x4, Spacing.x4, Spacing.x4, Spacing.x1),
            child: Column(
              children: [
                row('Venue', booking.venue.name),
                row(
                  'Space',
                  '${booking.space.name} · ${booking.endsAt.difference(booking.startsAt).inMinutes} min',
                ),
                row(
                  'Amount',
                  '${Money.format(booking.amountCents, currency: booking.venue.currency)} · pay at venue',
                ),
                if (booking.partySize > 1) row('Party', '${booking.partySize} people'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
