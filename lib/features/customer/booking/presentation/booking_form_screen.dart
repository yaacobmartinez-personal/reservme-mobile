import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/money/money.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/theme/venue_accent.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/ui/slot_tile.dart';
import '../../../../core/widgets/async_view.dart';
import '../../venues/application/venue_controller.dart';
import '../../venues/domain/public_venue.dart';
import '../application/availability_controller.dart';
import '../application/book_controller.dart';
import '../domain/availability.dart';
import '../domain/booking.dart';
import 'space_day_screen.dart';

/// C6 · Your details, and C7 · "that slot just went" — the same screen, because
/// losing the slot mid-form is a normal outcome, not an error page. When the
/// exclusion constraint refuses, the form stays filled and offers the times
/// that are still open.
class BookingFormScreen extends ConsumerStatefulWidget {
  const BookingFormScreen({super.key, required this.slug, required this.draft});

  final String slug;
  final BookingDraft? draft;

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _promo = TextEditingController();

  bool _prefilled = false;
  bool _busy = false;
  Map<String, String> _fieldErrors = const {};
  String? _message;

  /// Set when the slot went while the form was open.
  bool _slotTaken = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _promo.dispose();
    super.dispose();
  }

  Future<void> _submit(PublicVenue venue, VenueSpace space, Slot slot) async {
    final input = BookingInput(
      spaceId: space.id,
      startsAt: slot.startsAt,
      endsAt: slot.endsAt,
      name: _name.text,
      email: _email.text,
      phone: _phone.text.isEmpty ? null : _phone.text,
      promo: _promo.text.isEmpty ? null : _promo.text,
    );
    final local = input.validate();
    if (local.isNotEmpty) {
      setState(() => _fieldErrors = local);
      return;
    }

    setState(() {
      _busy = true;
      _fieldErrors = const {};
      _message = null;
    });
    FocusScope.of(context).unfocus();

    try {
      final outcome =
          await ref.read(bookControllerProvider.notifier).book(venueSlug: venue.slug, input: input);
      if (!mounted) return;
      switch (outcome) {
        case Booked(:final booking):
          context.pushReplacement(
            Routes.booking(venue.slug, booking.manageToken!),
            extra: const BookingArrival(justBooked: true),
          );
        case SlotTaken():
          ref.invalidate(availabilityProvider);
          setState(() {
            _busy = false;
            _slotTaken = true;
          });
        case SessionFull():
          setState(() {
            _busy = false;
            _message = 'That session filled up.';
          });
        case VenueClosed(:final message):
        case RateLimited(:final message):
          setState(() {
            _busy = false;
            _message = message;
          });
        case BookingInvalid(:final fieldErrors, :final message):
          setState(() {
            _busy = false;
            _fieldErrors = fieldErrors;
            _message = fieldErrors.isEmpty ? message : null;
          });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _message = AsyncView.messageFor(e);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    if (draft == null) {
      // Reached without a slot (a restored route): send them back to pick one.
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: FilledButton(
            onPressed: () => context.go(Routes.venue(widget.slug)),
            child: const Text('Pick a time'),
          ),
        ),
      );
    }

    final venue = ref.watch(venueProvider(widget.slug));
    return AsyncView(
      value: venue,
      onRetry: () => ref.invalidate(venueProvider(widget.slug)),
      data: (v) => VenueAccent(theme: v.theme, child: _form(v, draft)),
    );
  }

  Widget _form(PublicVenue venue, BookingDraft draft) {
    final p = context.palette;
    final zone = venue.timezone;
    final slot = draft.slot;

    final saved = ref.watch(savedContactProvider).value;
    if (saved != null && !_prefilled) {
      _prefilled = true;
      _name.text = saved.name;
      _email.text = saved.email;
      _phone.text = saved.phone;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Your booking')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          Spacing.gutter,
          Spacing.x2,
          Spacing.gutter,
          Spacing.x8,
        ),
        children: [
          if (_slotTaken) ...[
            const AppBanner(
              kind: BannerKind.warn,
              title: 'That slot just went',
              body: 'Someone booked it a moment ago. These are still open:',
            ),
            const SizedBox(height: Spacing.x4),
            _AlternativeSlots(
              venue: venue,
              space: draft.space,
              date: AppTime.localDate(slot.startsAt, zone),
            ),
            const SizedBox(height: Spacing.x6),
          ] else
            _Summary(venue: venue, draft: draft),
          const SizedBox(height: Spacing.x5),
          const Eyebrow("Who's booking"),
          const SizedBox(height: Spacing.x3),
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Name',
              errorText: _fieldErrors['name'],
            ),
          ),
          const SizedBox(height: Spacing.x3),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'Email',
              helperText: 'Your confirmation goes here',
              errorText: _fieldErrors['email'],
            ),
          ),
          const SizedBox(height: Spacing.x3),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Mobile — optional',
              errorText: _fieldErrors['phone'],
            ),
          ),
          const SizedBox(height: Spacing.x3),
          TextField(
            controller: _promo,
            textCapitalization: TextCapitalization.characters,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'Promo code',
              hintText: 'e.g. WEEKDAY10',
              errorText: _fieldErrors['promo'],
            ),
          ),
          if (_message != null) ...[
            const SizedBox(height: Spacing.x4),
            AppBanner(kind: BannerKind.error, title: _message!),
          ],
          const SizedBox(height: Spacing.x4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_rounded, size: 16, color: p.pine),
              const SizedBox(width: Spacing.x2),
              Expanded(
                child: Text(
                  'We remember these details on this phone only. No account is created.',
                  style: AppType.caption.copyWith(color: p.ink3),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: StickyFooter(
        child: FilledButton(
          onPressed: _busy || _slotTaken ? null : () => _submit(venue, draft.space, slot),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
          child: _busy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  'Confirm booking · ${Money.format(slot.priceCents, currency: venue.currency)}',
                ),
        ),
      ),
    );
  }
}

/// Passed to the booking detail screen so it can show the "You're booked"
/// banner only right after booking.
class BookingArrival {
  const BookingArrival({this.justBooked = false});

  final bool justBooked;
}

class _Summary extends StatelessWidget {
  const _Summary({required this.venue, required this.draft});

  final PublicVenue venue;
  final BookingDraft draft;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final zone = venue.timezone;
    final slot = draft.slot;

    Widget cell(String label, String value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: AppType.eyebrow.copyWith(color: p.bandMuted, fontSize: 10),
            ),
            const SizedBox(height: 2),
            Text(value, style: AppType.bodyStrong.copyWith(color: p.bandInk)),
          ],
        );

    return Container(
      padding: const EdgeInsets.all(Spacing.x4),
      decoration: BoxDecoration(
        color: p.band,
        borderRadius: BorderRadius.circular(Radii.xl),
      ),
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
                      venue.name,
                      style: AppType.displayS.copyWith(color: p.bandInk, fontSize: 20),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      draft.space.name,
                      style: AppType.bodyS.copyWith(color: p.bandMuted),
                    ),
                  ],
                ),
              ),
              Text(
                Money.format(slot.priceCents, currency: venue.currency),
                style: AppType.displayM.copyWith(color: p.bandInk),
              ),
            ],
          ),
          const SizedBox(height: Spacing.x3),
          Divider(color: p.bandInk.withValues(alpha: 0.14), height: 1),
          const SizedBox(height: Spacing.x3),
          Row(
            children: [
              Expanded(child: cell('Date', AppTime.formatDay(slot.startsAt, zone))),
              Expanded(
                child: cell(
                  'Time',
                  '${AppTime.formatTime(slot.startsAt, zone)} – ${AppTime.formatTime(slot.endsAt, zone)}',
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.x3),
          Text(
            'Pay at the venue · ${venue.policyLine.toLowerCase()}',
            style: AppType.caption.copyWith(color: p.bandMuted),
          ),
        ],
      ),
    );
  }
}

/// The still-open times on the same day, shown when the slot is lost.
class _AlternativeSlots extends ConsumerWidget {
  const _AlternativeSlots({required this.venue, required this.space, required this.date});

  final PublicVenue venue;
  final VenueSpace space;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availability = ref.watch(
      availabilityProvider(venueSlug: venue.slug, spaceId: space.id, date: date),
    );
    return availability.maybeWhen(
      data: (day) {
        final open = day.openSlots.take(6).toList();
        if (open.isEmpty) {
          return FilledButton(
            onPressed: () => context.pop(),
            child: const Text('See other days'),
          );
        }
        return Column(
          children: [
            GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: Spacing.x2,
              crossAxisSpacing: Spacing.x2,
              childAspectRatio: 110 / 60,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final slot in open)
                  SlotTile(
                    label: slot.label,
                    reason: slot.reason,
                    priceCents: slot.priceCents,
                    currency: venue.currency,
                    peak: slot.peak,
                    onTap: () => context.pushReplacement(
                      Routes.book(venue.slug),
                      extra: BookingDraft(space: space, slot: slot),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Spacing.x3),
            OutlinedButton(
              onPressed: () => context.pop(),
              child: const Text('See all times'),
            ),
          ],
        );
      },
      orElse: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
