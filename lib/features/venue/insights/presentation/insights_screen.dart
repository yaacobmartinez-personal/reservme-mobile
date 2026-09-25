import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/money.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/insights_controller.dart';
import '../domain/insights.dart';
import 'widgets/mini_chart.dart';

/// G5 · Insights. Booked value, utilisation, when people book, and what needs
/// doing today.
///
/// Charts are hand-drawn rather than pulled from a chart library: four small
/// shapes are less code than a dependency, and they theme themselves.
class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(selectedVenueProvider);
    if (venue == null) {
      return const Scaffold(
        body: EmptyState(
          icon: Icons.storefront_outlined,
          title: 'No venue selected',
          hint: 'Pick a venue first.',
        ),
      );
    }

    final range = ref.watch(insightsRangeControllerProvider);
    final provider = insightsProvider(venue.slug, range);
    final insights = ref.watch(provider);
    final p = context.palette;

    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Spacing.gutter,
              0,
              Spacing.gutter,
              Spacing.x3,
            ),
            child: SegmentedButton<InsightsRange>(
              segments: [
                for (final r in InsightsRange.values)
                  ButtonSegment(value: r, label: Text(r.label)),
              ],
              selected: {range},
              showSelectedIcon: false,
              onSelectionChanged: (s) => ref
                  .read(insightsRangeControllerProvider.notifier)
                  .set(s.first),
            ),
          ),
          Expanded(
            child: AsyncView(
              value: insights,
              onRetry: () => ref.invalidate(provider),
              data: (data) => RefreshIndicator(
                onRefresh: () async => ref.refresh(provider.future),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    Spacing.gutter,
                    0,
                    Spacing.gutter,
                    Spacing.x8,
                  ),
                  children: data.isEmpty
                      ? [
                          const SizedBox(height: Spacing.x8),
                          EmptyState(
                            icon: Icons.insights_rounded,
                            title: 'Nothing booked in this window',
                            hint: 'Pick a longer period, or come back once '
                                'bookings start landing.',
                          ),
                        ]
                      : [
                          _Kpis(data: data, currency: venue.currency),
                          const SizedBox(height: Spacing.x3),
                          _BookedByDay(
                            data: data,
                            currency: venue.currency,
                            timezone: venue.timezone,
                          ),
                          const SizedBox(height: Spacing.x3),
                          _PeakHours(data: data),
                          const SizedBox(height: Spacing.x3),
                          _BySpace(data: data, currency: venue.currency),
                          const SizedBox(height: Spacing.x3),
                          _Mix(data: data),
                          const SizedBox(height: Spacing.x3),
                          _Customers(data: data),
                          if (!data.needsYou.isEmpty) ...[
                            const SizedBox(height: Spacing.x3),
                            _NeedsYou(data: data, timezone: venue.timezone),
                          ],
                          const SizedBox(height: Spacing.x3),
                          Text(
                            'Booked value is what the bookings are worth, not '
                            'cash collected — customers pay at the venue.',
                            style: AppType.bodyS.copyWith(color: p.ink3),
                          ),
                        ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.child, this.hint});

  final String title;
  final String? hint;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppType.captionStrong.copyWith(color: p.ink3)),
          const SizedBox(height: Spacing.x3),
          child,
          if (hint != null) ...[
            const SizedBox(height: Spacing.x2),
            Text(hint!, style: AppType.bodyS.copyWith(color: p.ink3)),
          ],
        ],
      ),
    );
  }
}

class _Kpis extends StatelessWidget {
  const _Kpis({required this.data, required this.currency});

  final Insights data;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final tiles = <Widget>[
      _KpiTile(
        label: 'Booked value',
        value: Money.compact(data.bookedValueCents.value.round(),
            currency: currency),
        kpi: data.bookedValueCents,
      ),
      _KpiTile(
        label: 'Bookings',
        value: '${data.bookings.value.round()}',
        kpi: data.bookings,
      ),
      _KpiTile(
        label: 'Utilisation',
        value: '${_trim(data.utilisationPct.value)}%',
        kpi: data.utilisationPct,
      ),
      _KpiTile(
        label: 'No-shows',
        value: '${_trim(data.noShowRatePct.value)}%',
        kpi: data.noShowRatePct,
        // A falling no-show rate is the good direction, unlike the others.
        lowerIsBetter: true,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - Spacing.x3) / 2;
        return Wrap(
          spacing: Spacing.x3,
          runSpacing: Spacing.x3,
          children: [
            for (final tile in tiles) SizedBox(width: width, child: tile),
          ],
        );
      },
    );
  }

  static String _trim(num v) {
    final s = v.toStringAsFixed(1);
    return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
  }
}

class _KpiTile extends StatelessWidget {
  const _KpiTile({
    required this.label,
    required this.value,
    required this.kpi,
    this.lowerIsBetter = false,
  });

  final String label;
  final String value;
  final Kpi kpi;
  final bool lowerIsBetter;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final delta = kpi.deltaPct;
    final good = kpi.isGood(lowerIsBetter: lowerIsBetter);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppType.bodyS.copyWith(color: p.ink3)),
          const SizedBox(height: 2),
          Text(value, style: AppType.displayAt(28)),
          const SizedBox(height: Spacing.x2),
          SizedBox(
            height: 26,
            child: Sparkline(values: kpi.series, colour: p.pineLine),
          ),
          const SizedBox(height: 4),
          Text(
            delta == null
                ? 'No earlier period'
                : '${delta > 0 ? '+' : ''}${delta.toStringAsFixed(1)}%',
            style: AppType.bodyS.copyWith(
              color: good == null ? p.ink3 : (good ? p.pineInk : p.danger),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookedByDay extends StatelessWidget {
  const _BookedByDay({
    required this.data,
    required this.currency,
    required this.timezone,
  });

  final Insights data;
  final String currency;
  final String timezone;

  @override
  Widget build(BuildContext context) {
    final best = data.bookedByDay.fold<int>(0, (b, d) => d.cents > b ? d.cents : b);
    return _Card(
      title: 'BOOKED VALUE BY DAY',
      hint: best == 0
          ? null
          : 'Busiest day: ${Money.format(best, currency: currency)}',
      child: SizedBox(
        height: 120,
        child: BarChart(
          values: [for (final d in data.bookedByDay) d.cents],
          labels: [for (final d in data.bookedByDay) d.day],
        ),
      ),
    );
  }
}

class _PeakHours extends StatelessWidget {
  const _PeakHours({required this.data});

  final Insights data;

  @override
  Widget build(BuildContext context) => _Card(
        title: 'WHEN PEOPLE BOOK',
        hint: data.peakMax == 0
            ? null
            : 'Darker is busier. Hours run 6am to 11pm.',
        child: Heatmap(grid: data.peakHours, max: data.peakMax),
      );
}

class _BySpace extends StatelessWidget {
  const _BySpace({required this.data, required this.currency});

  final Insights data;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final best = data.bySpace.isEmpty ? 0 : data.bySpace.first.cents;

    return _Card(
      title: 'BOOKED VALUE BY SPACE',
      child: Column(
        children: [
          for (final space in data.bySpace)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: 84,
                    child: Text(
                      space.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppType.bodyS,
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: best == 0 ? 0 : space.cents / best,
                        minHeight: 8,
                        backgroundColor: p.rule,
                        valueColor: AlwaysStoppedAnimation(p.pine),
                      ),
                    ),
                  ),
                  const SizedBox(width: Spacing.x2),
                  Text(
                    Money.compact(space.cents, currency: currency),
                    style: AppType.bodyS.copyWith(color: p.ink3),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Mix extends StatelessWidget {
  const _Mix({required this.data});

  final Insights data;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final mix = data.mix;

    Widget row(String label, int n, Color colour) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
              ),
              const SizedBox(width: Spacing.x2),
              Expanded(child: Text(label, style: AppType.bodyS)),
              Text(
                mix.total == 0
                    ? '$n'
                    : '$n · ${(n / mix.total * 100).round()}%',
                style: AppType.bodyS.copyWith(color: p.ink3),
              ),
            ],
          ),
        );

    return _Card(
      title: 'HOW BOOKINGS ENDED',
      child: Column(
        children: [
          row('Honoured', mix.confirmed, p.pine),
          row('Cancelled', mix.cancelled, p.ink3),
          row('No-show', mix.noShow, p.danger),
        ],
      ),
    );
  }
}

class _Customers extends StatelessWidget {
  const _Customers({required this.data});

  final Insights data;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final c = data.customers;

    return _Card(
      title: 'CUSTOMERS',
      hint: '${c.repeatRatePct}% of the people who booked had been before.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${c.newCount} new · ${c.returningCount} returning',
            style: AppType.bodyStrong,
          ),
          if (c.top.isNotEmpty) ...[
            const SizedBox(height: Spacing.x3),
            for (final customer in c.top)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        customer.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppType.bodyS,
                      ),
                    ),
                    Text(
                      customer.bookings == 1
                          ? '1 booking'
                          : '${customer.bookings} bookings',
                      style: AppType.bodyS.copyWith(color: p.ink3),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _NeedsYou extends StatelessWidget {
  const _NeedsYou({required this.data, required this.timezone});

  final Insights data;
  final String timezone;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final needs = data.needsYou;

    return _Card(
      title: 'NEEDS YOU',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (needs.toCheckIn > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: Spacing.x2),
              child: Text(
                needs.toCheckIn == 1
                    ? '1 booking today is not checked in yet.'
                    : '${needs.toCheckIn} bookings today are not checked in '
                        'yet.',
                style: AppType.bodyS,
              ),
            ),
          for (final session in needs.halfEmptySessions)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(session.title, style: AppType.bodyS),
                        Text(
                          AppTime.formatLongDay(session.startsAt, timezone),
                          style: AppType.bodyS.copyWith(color: p.ink3),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${session.spotsLeft} of ${session.capacity} left',
                    style: AppType.bodyS.copyWith(color: p.warn),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
