import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../../venues/presentation/venue_switcher_button.dart';
import '../application/customers_controller.dart';
import '../domain/customer.dart';
import 'widgets/customer_avatar.dart';

/// V10 · Customers. A live search — at the counter you want the truth, not a
/// cached list — with the segments the venue actually sorts people into.
class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  final _search = TextEditingController();
  Timer? _debounce;
  String _query = '';
  CustomerSegment _segment = CustomerSegment.all;

  @override
  void initState() {
    super.initState();
    _search.addListener(() {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 250), () {
        if (mounted) setState(() => _query = _search.text.trim());
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final venue = ref.watch(selectedVenueProvider);
    if (venue == null) {
      return const Scaffold(
        body: EmptyState(
          icon: Icons.storefront_outlined,
          title: 'No venue selected',
          hint: 'Pick a venue to see its customers.',
        ),
      );
    }

    final page = ref.watch(
      customersProvider(venue.slug, search: _query, segment: _segment),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BigHeader(
              eyebrow: page.hasValue
                  ? '${page.value!.total} customer${page.value!.total == 1 ? '' : 's'}'
                  : null,
              title: 'Customers',
              trailing: const VenueSwitcherButton(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Spacing.gutter,
                0,
                Spacing.gutter,
                Spacing.x3,
              ),
              child: TextField(
                controller: _search,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: 'Name, email or phone',
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: Spacing.gutter),
                children: [
                  for (final segment in CustomerSegment.values)
                    Padding(
                      padding: const EdgeInsets.only(right: Spacing.x2),
                      child: ChoiceChip(
                        label: Text(segment.label),
                        selected: _segment == segment,
                        onSelected: (_) => setState(() => _segment = segment),
                        showCheckmark: false,
                        selectedColor: p.ink,
                        labelStyle: AppType.buttonS.copyWith(
                          color: _segment == segment ? p.paper : p.ink2,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.x3),
            Expanded(
              child: AsyncView(
                value: page,
                onRetry: () => ref.invalidate(
                  customersProvider(venue.slug, search: _query, segment: _segment),
                ),
                data: (result) => result.rows.isEmpty
                    ? EmptyState(
                        icon: Icons.person_search_outlined,
                        title: _query.isEmpty
                            ? 'Nobody here yet'
                            : 'Nobody matches "$_query"',
                        hint: _query.isEmpty
                            ? 'Customers appear the first time they book.'
                            : 'Try a phone number, or part of an email.',
                      )
                    : RefreshIndicator(
                        onRefresh: () async => ref.refresh(
                          customersProvider(
                            venue.slug,
                            search: _query,
                            segment: _segment,
                          ).future,
                        ),
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(
                            Spacing.gutter,
                            0,
                            Spacing.gutter,
                            Spacing.x8,
                          ),
                          itemCount: result.rows.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: Spacing.x3),
                          itemBuilder: (context, i) => _CustomerCard(
                            customer: result.rows[i],
                            onTap: () => context.push(
                              '/v/customers/${result.rows[i].id}',
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerCard extends StatelessWidget {
  const _CustomerCard({required this.customer, required this.onTap});

  final CustomerSummary customer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    final facts = [
      if ((customer.phone ?? '').isNotEmpty) customer.phone! else customer.email,
      if (customer.bookings > 0)
        '${customer.bookings} visit${customer.bookings == 1 ? '' : 's'}',
      if (customer.lastVisitDays != null)
        _lastVisit(customer.lastVisitDays!, customer.bookings),
    ];

    return Material(
      color: p.card,
      borderRadius: BorderRadius.circular(Radii.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.card),
        child: Ink(
          padding: const EdgeInsets.all(Spacing.x3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.card),
            border: Border.all(color: p.rule),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerAvatar(customer: customer),
              const SizedBox(width: Spacing.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppType.bodyStrong.copyWith(color: p.ink),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      facts.join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppType.bodyS.copyWith(color: p.ink2),
                    ),
                    if (customer.tags.isNotEmpty || customer.noShowCount > 0) ...[
                      const SizedBox(height: Spacing.x2),
                      Wrap(
                        spacing: Spacing.x2,
                        runSpacing: 6,
                        children: [
                          if (customer.noShowCount > 0)
                            StatusChip(
                              customer.noShowCount == 1
                                  ? '1 no-show'
                                  : '${customer.noShowCount} no-shows',
                              tone: ChipTone.clay,
                            ),
                          for (final tag in customer.tags)
                            StatusChip(tag, tone: ChipTone.neutral),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: p.ink3),
            ],
          ),
        ),
      ),
    );
  }

  /// "first visit today" is only true of someone with one booking to their
  /// name; for anyone else today is their *latest* visit, not their first.
  String _lastVisit(int days, int bookings) {
    String plural(int n, String unit) => '$n $unit${n == 1 ? '' : 's'}';
    return switch (days) {
      0 when bookings <= 1 => 'first visit today',
      0 => 'last visit today',
      1 => 'last visit yesterday',
      < 7 => 'last visit ${plural(days, 'day')} ago',
      < 30 => 'last visit ${plural((days / 7).floor(), 'week')} ago',
      _ => 'last visit ${plural((days / 30).floor(), 'month')} ago',
    };
  }
}
