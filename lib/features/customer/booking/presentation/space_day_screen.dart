import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/model/enums.dart';
import '../../../../core/money/money.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
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
import '../domain/availability.dart';
import 'widgets/waitlist_sheet.dart';

/// C4 · Pick a slot. The date strip and grid are rendered in the *venue's*
/// timezone, so a customer in another country sees the venue's own clock.
class SpaceDayScreen extends ConsumerWidget {
  const SpaceDayScreen({
    super.key,
    required this.slug,
    required this.spaceId,
    this.initialDate,
  });

  final String slug;
  final String spaceId;
  final String? initialDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(venueProvider(slug));
    return AsyncView(
      value: venue,
      onRetry: () => ref.invalidate(venueProvider(slug)),
      data: (v) {
        final space = v.spaces.where((s) => s.id == spaceId).firstOrNull;
        if (space == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('That space is no longer available.')),
          );
        }
        return VenueAccent(
          theme: v.theme,
          child: _Body(venue: v, space: space, initialDate: initialDate),
        );
      },
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body({required this.venue, required this.space, this.initialDate});

  final PublicVenue venue;
  final VenueSpace space;
  final String? initialDate;

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  Slot? _selected;
  String? _date;

  String get _venueSlug => widget.venue.slug;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final zone = widget.venue.timezone;
    final dateProvider = selectedDateProvider(_venueSlug, zone);
    final String date = _date ?? widget.initialDate ?? ref.watch(dateProvider);

    final dates = ref.watch(
      bookableDatesProvider(timezone: zone, horizonDays: widget.venue.maxHorizonDays),
    );
    final availability = ref.watch(
      availabilityProvider(venueSlug: _venueSlug, spaceId: widget.space.id, date: date),
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.space.name, style: AppType.displayAt(20).copyWith(color: p.ink)),
            Text(
              '${widget.venue.name} · ${zone.replaceAll('_', ' ')}',
              style: AppType.caption.copyWith(color: p.ink3),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _DateStrip(
            dates: dates,
            selected: date,
            zone: zone,
            onSelected: (d) => setState(() {
              _date = d;
              _selected = null;
            }),
          ),
          Expanded(
            child: AsyncView(
              value: availability,
              onRetry: () => ref.invalidate(availabilityProvider),
              data: (day) => _Grid(
                venue: widget.venue,
                space: widget.space,
                day: day,
                selected: _selected,
                onSelect: (slot) => setState(() => _selected = slot),
                onWaitlist: (slot) => showWaitlistSheet(
                  context,
                  venue: widget.venue,
                  space: widget.space,
                  slot: slot,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _selected == null
          ? null
          : StickyFooter(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppTime.formatWhen(_selected!.startsAt, _selected!.endsAt, zone),
                          style: AppType.caption.copyWith(color: p.ink3),
                        ),
                        Text(
                          Money.format(_selected!.priceCents, currency: widget.venue.currency),
                          style: AppType.displayAt(22).copyWith(color: p.ink),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Spacing.x4),
                  FilledButton(
                    onPressed: () => context.push(
                      Routes.book(_venueSlug),
                      extra: BookingDraft(
                        space: widget.space,
                        slot: _selected!,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 52),
                      padding: const EdgeInsets.symmetric(horizontal: Spacing.x8),
                    ),
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
    );
  }
}

/// What the slot picker hands to the booking form.
class BookingDraft {
  const BookingDraft({required this.space, required this.slot});

  final VenueSpace space;
  final Slot slot;
}

class _DateStrip extends StatelessWidget {
  const _DateStrip({
    required this.dates,
    required this.selected,
    required this.zone,
    required this.onSelected,
  });

  final List<String> dates;
  final String selected;
  final String zone;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x3),
          child: Row(
            children: [
              const Expanded(child: Eyebrow('Date')),
              Text(
                _longLabel(selected, zone),
                style: AppType.bodyS.copyWith(color: p.ink2),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 62,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Spacing.gutter),
            itemCount: dates.length,
            separatorBuilder: (_, _) => const SizedBox(width: 6),
            itemBuilder: (context, i) {
              final date = dates[i];
              final start = AppTime.startOfLocalDay(date, zone);
              return DatePill(
                weekday: start == null ? '' : AppTime.formatDay(start, zone).split(' ').first,
                day: date.split('-').last,
                selected: date == selected,
                onTap: () => onSelected(date),
              );
            },
          ),
        ),
        const SizedBox(height: Spacing.x4),
      ],
    );
  }

  static String _longLabel(String date, String zone) {
    final start = AppTime.startOfLocalDay(date, zone);
    return start == null ? date : AppTime.formatLongDay(start, zone);
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    required this.venue,
    required this.space,
    required this.day,
    required this.selected,
    required this.onSelect,
    required this.onWaitlist,
  });

  final PublicVenue venue;
  final VenueSpace space;
  final DayAvailability day;
  final Slot? selected;
  final ValueChanged<Slot> onSelect;
  final ValueChanged<Slot> onWaitlist;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final bookable = day.slots.where((s) => s.reason != SlotReason.closed).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x8),
      children: [
        Row(
          children: [
            Expanded(child: Eyebrow('Time · ${space.slotMinutes} min')),
            const SlotLegend(),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        if (bookable.isEmpty)
          AppCard(
            child: Text(
              venue.suspended
                  ? 'This venue is not taking bookings right now.'
                  : 'Nothing is open on this date. Try another day.',
              style: AppType.bodyS.copyWith(color: p.ink2),
            ),
          )
        else
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: Spacing.x2,
            crossAxisSpacing: Spacing.x2,
            childAspectRatio: 110 / 60,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final slot in bookable)
                SlotTile(
                  label: slot.label,
                  reason: slot.reason,
                  priceCents: slot.priceCents,
                  currency: venue.currency,
                  peak: slot.peak,
                  selected: selected?.startsAt == slot.startsAt,
                  onTap: venue.suspended ? null : () => onSelect(slot),
                  onWaitlist: venue.suspended ? null : () => onWaitlist(slot),
                ),
            ],
          ),
        if (day.sessions.isNotEmpty) ...[
          const SizedBox(height: Spacing.x6),
          const Eyebrow('Open play'),
          const SizedBox(height: Spacing.x3),
          for (final session in day.sessions) ...[
            _SessionRow(session: session, currency: venue.currency),
            const SizedBox(height: Spacing.x3),
          ],
        ],
        const SizedBox(height: Spacing.x4),
        const AppBanner(
          kind: BannerKind.info,
          title: 'Taken slots can be joined on the waitlist',
          body: "Tap one — we'll message you if it frees up.",
        ),
      ],
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({required this.session, required this.currency});

  final SessionSummary session;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${session.title} · ${session.label}',
                  style: AppType.bodyStrong.copyWith(color: p.ink),
                ),
                const SizedBox(height: 3),
                Text(
                  'Shared court · ${Money.format(session.pricePerPersonCents, currency: currency)} per person',
                  style: AppType.bodyS.copyWith(color: p.ink2),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.x2),
          StatusChip(
            session.isFull ? 'Full' : '${session.spotsLeft} spots',
            tone: session.isFull ? ChipTone.clay : ChipTone.pine,
            large: true,
          ),
        ],
      ),
    );
  }
}
