import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/calendar_controller.dart';
import '../domain/calendar_day.dart';
import 'widgets/block_sheet.dart';
import 'widgets/calendar_item_sheet.dart';
import 'widgets/manual_booking_sheet.dart';
import 'widgets/space_lane.dart';

/// V7 · Calendar — the week strip, one lane per space, and the two ways to
/// put something on the grid: a staff booking and a block.
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key, this.initialDate});

  final String? initialDate;

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  String? _date;

  @override
  Widget build(BuildContext context) {
    final venue = ref.watch(selectedVenueProvider);
    if (venue == null) {
      return const Scaffold(
        body: EmptyState(
          icon: Icons.storefront_outlined,
          title: 'No venue selected',
          hint: 'Pick a venue to see its calendar.',
        ),
      );
    }

    final now = ref.watch(clockProvider)();
    final date = _date ?? widget.initialDate ?? AppTime.today(now, venue.timezone);
    final day = ref.watch(calendarProvider(venue.slug, date));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              date: date,
              timezone: venue.timezone,
              onShift: (days) =>
                  setState(() => _date = AppTime.addDays(date, days, venue.timezone)),
              onPick: (picked) => setState(() => _date = picked),
            ),
            Expanded(
              child: AsyncView(
                value: day,
                onRetry: () => ref.invalidate(calendarProvider(venue.slug, date)),
                data: (state) => _Grid(
                  state: state,
                  venueSlug: venue.slug,
                  timezone: venue.timezone,
                  currency: venue.currency,
                  date: date,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: day.hasValue && !day.value!.stale
          ? FloatingActionButton.extended(
              onPressed: () => showManualBookingSheet(
                context,
                venueSlug: venue.slug,
                timezone: venue.timezone,
                currency: venue.currency,
                date: date,
                lanes: day.value!.day.lanes,
              ),
              icon: const Icon(Icons.add_rounded),
              label: const Text('New booking'),
            )
          : null,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.date,
    required this.timezone,
    required this.onShift,
    required this.onPick,
  });

  final String date;
  final String timezone;
  final ValueChanged<int> onShift;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    // The week the selected day sits in, Monday first.
    final weekday = AppTime.weekday(date, timezone); // 0 = Sunday
    final mondayOffset = weekday == 0 ? -6 : 1 - weekday;
    final monday = AppTime.addDays(date, mondayOffset, timezone);
    final days = [for (var i = 0; i < 7; i++) AppTime.addDays(monday, i, timezone)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BigHeader(
          title: 'Calendar',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundIconButton(
                icon: Icons.chevron_left_rounded,
                onPressed: () => onShift(-7),
                tooltip: 'Previous week',
              ),
              const SizedBox(width: Spacing.x2),
              RoundIconButton(
                icon: Icons.chevron_right_rounded,
                onPressed: () => onShift(7),
                tooltip: 'Next week',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x3),
          child: Row(
            children: [
              for (final d in days)
                Expanded(
                  child: _DayChip(
                    date: d,
                    timezone: timezone,
                    selected: d == date,
                    onTap: () => onPick(d),
                  ),
                ),
            ],
          ),
        ),
        Divider(height: 1, color: p.rule),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.date,
    required this.timezone,
    required this.selected,
    required this.onTap,
  });

  final String date;
  final String timezone;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final start = AppTime.startOfLocalDay(date, timezone);
    final label = start == null ? '' : AppTime.formatDay(start, timezone);
    // "Sat 26 Sep" → "Sat" and "26".
    final parts = label.split(' ');
    final dayName = parts.isNotEmpty ? parts.first : '';
    final dayNumber = parts.length > 1 ? parts[1] : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: selected ? p.pine : Colors.transparent,
        borderRadius: BorderRadius.circular(Radii.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Radii.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Text(
                  dayName,
                  style: AppType.caption.copyWith(
                    color: selected ? p.onPine : p.ink3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dayNumber,
                  style: AppType.displayAt(19).copyWith(
                    color: selected ? p.onPine : p.ink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Grid extends ConsumerStatefulWidget {
  const _Grid({
    required this.state,
    required this.venueSlug,
    required this.timezone,
    required this.currency,
    required this.date,
  });

  final CalendarState state;
  final String venueSlug;
  final String timezone;
  final String currency;
  final String date;

  @override
  ConsumerState<_Grid> createState() => _GridState();
}

class _GridState extends ConsumerState<_Grid> {
  static const _rowHeight = 74.0;
  ScrollController? _controller;

  String get venueSlug => widget.venueSlug;
  String get timezone => widget.timezone;
  String get currency => widget.currency;
  String get date => widget.date;
  CalendarState get state => widget.state;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final day = state.day;

    if (day.lanes.isEmpty) {
      return const EmptyState(
        icon: Icons.grid_view_outlined,
        title: 'No spaces yet',
        hint: 'Add a space and its opening hours to see a calendar.',
      );
    }
    if (day.rows.isEmpty) {
      return EmptyState(
        icon: Icons.event_busy_outlined,
        title: 'Closed today',
        hint: 'No space is open on ${_longDate()}.',
      );
    }

    const rowHeight = _rowHeight;
    _controller ??= _openedAt(day, rowHeight);

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(calendarProvider(venueSlug, date).future),
      child: ListView(
        controller: _controller,
        padding: const EdgeInsets.fromLTRB(
          Spacing.gutter,
          Spacing.x3,
          Spacing.gutter,
          96,
        ),
        children: [
          if (state.stale) ...[
            const AppBanner(
              kind: BannerKind.offline,
              title: "You're offline",
              body: 'Showing the last calendar. Booking needs a connection.',
            ),
            const SizedBox(height: Spacing.x3),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The time ruler, shared by every lane.
              Padding(
                padding: const EdgeInsets.only(top: 26),
                child: Column(
                  children: [
                    for (final row in day.rows)
                      SizedBox(
                        height: rowHeight,
                        width: 46,
                        child: Text(
                          row,
                          style: AppType.caption.copyWith(color: p.ink3),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final lane in day.lanes)
                        SpaceLane(
                          lane: lane,
                          rows: day.rows,
                          timezone: timezone,
                          rowHeight: rowHeight,
                          onItem: (item) => showCalendarItemSheet(
                            context,
                            venueSlug: venueSlug,
                            timezone: timezone,
                            currency: currency,
                            date: date,
                            item: item,
                            lanes: day.lanes,
                            offline: state.stale,
                          ),
                          onEmpty: (spaceId, time) => state.stale
                              ? null
                              : showManualBookingSheet(
                                  context,
                                  venueSlug: venueSlug,
                                  timezone: timezone,
                                  currency: currency,
                                  date: date,
                                  lanes: day.lanes,
                                  spaceId: spaceId,
                                  time: time,
                                ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.x4),
          Center(
            child: TextButton.icon(
              onPressed: state.stale
                  ? null
                  : () => showBlockSheet(
                        context,
                        venueSlug: venueSlug,
                        timezone: timezone,
                        date: date,
                        lanes: day.lanes,
                      ),
              icon: const Icon(Icons.block_rounded, size: 18),
              label: const Text('Block off time'),
            ),
          ),
        ],
      ),
    );
  }

  /// A venue opens at nine and fills up in the evening, so landing at the top
  /// of the grid means scrolling past six empty hours every time. Open on the
  /// current hour instead, or on the first thing booked.
  ScrollController _openedAt(CalendarDay day, double rowHeight) {
    final now = ref.read(clockProvider)();
    final isToday = AppTime.today(now, timezone) == date;
    final anchor = isToday
        ? AppTime.formatTime(now, timezone)
        : day.lanes
            .expand((l) => l.items)
            .map((i) => AppTime.formatTime(i.startsAt, timezone))
            .fold<String?>(null, (a, b) => a == null || b.compareTo(a) < 0 ? b : a);

    var index = 0;
    if (anchor != null) {
      // The last row at or before the anchor; -1 when the anchor precedes the
      // whole grid, which leaves us at the top, where we want to be anyway.
      index = day.rows.lastIndexWhere((r) => r.compareTo(anchor) <= 0);
      if (index < 0) index = 0;
    }
    return ScrollController(initialScrollOffset: index * rowHeight);
  }

  String _longDate() {
    final start = AppTime.startOfLocalDay(date, timezone);
    return start == null ? date : AppTime.formatLongDay(start, timezone);
  }
}
