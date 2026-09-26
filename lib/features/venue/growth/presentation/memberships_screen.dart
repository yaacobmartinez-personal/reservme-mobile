import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/model/enums.dart';
import '../../../../core/money/money.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/app_choice_chip.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/growth_controllers.dart';
import '../domain/growth.dart';
import 'widgets/growth_widgets.dart';

/// Passes and memberships (API-CONTRACT #42). Sold at the desk — the app
/// records the sale, it does not take the money — and granted from a
/// customer's profile.
class MembershipsScreen extends ConsumerWidget {
  const MembershipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(selectedVenueProvider);
    if (venue == null) {
      return const Scaffold(
        body: EmptyState(icon: Icons.storefront_outlined, title: 'No venue selected', hint: 'Pick a venue first.'),
      );
    }
    final provider = membershipPlansProvider(venue.slug);
    final plans = ref.watch(provider);
    final canManage = venue.role.atLeast(VenueRole.admin);

    return Scaffold(
      appBar: AppBar(title: const Text('Passes & memberships')),
      floatingActionButton: canManage
          ? FloatingActionButton.extended(
              onPressed: () => _create(context, ref, venue.slug, venue.currency),
              icon: const Icon(Icons.add_rounded),
              label: const Text('New plan'),
            )
          : null,
      body: AsyncView(
        value: plans,
        onRetry: () => ref.invalidate(provider),
        data: (list) => RefreshIndicator(
          onRefresh: () async => ref.refresh(provider.future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x10 * 2),
            children: [
              const Hint(
                'A pass is a pack of games used one per booking. A membership renews '
                'monthly with credits, a discount, or both. Either comes off a booking '
                'automatically when the customer books with the same email.',
              ),
              const SizedBox(height: Spacing.x4),
              if (list.isEmpty)
                const EmptyState(
                  icon: Icons.card_membership_outlined,
                  title: 'No plans yet',
                  hint: 'Make a 10-game pass or a monthly membership to sell at the desk.',
                )
              else
                GroupCard(children: [
                  for (final plan in list)
                    _PlanTile(plan: plan, slug: venue.slug, currency: venue.currency, canManage: canManage),
                ]),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _create(BuildContext context, WidgetRef ref, String slug, String currency) async {
    final created = await showFormSheet<MembershipPlan>(
      context,
      (_) => _PlanForm(slug: slug, currency: currency),
    );
    if (created != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${created.name} is on sale.')));
    }
  }
}

class _PlanTile extends ConsumerWidget {
  const _PlanTile({required this.plan, required this.slug, required this.currency, required this.canManage});

  final MembershipPlan plan;
  final String slug;
  final String currency;
  final bool canManage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final holders = plan.holders == 1 ? '1 holder' : '${plan.holders} holders';
    return ListTile(
      title: Row(
        children: [
          Flexible(child: Text(plan.name, style: AppType.bodyStrong, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: Spacing.x2),
          StatusChip(plan.kind.label, tone: plan.kind == PlanKind.membership ? ChipTone.pine : ChipTone.neutral),
        ],
      ),
      subtitle: Text(
        '${Money.format(plan.priceCents, currency: currency)} · ${plan.benefits} · $holders',
        style: AppType.bodyS.copyWith(color: plan.active ? p.ink3 : p.ink3.withValues(alpha: 0.6)),
      ),
      trailing: Switch(
        value: plan.active,
        onChanged: canManage
            ? (on) async {
                final messenger = ScaffoldMessenger.of(context);
                try {
                  await ref.read(growthCommandsProvider.notifier).setPlanActive(slug, plan.id, on);
                } catch (e) {
                  messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
                }
              }
            : null,
      ),
    );
  }
}

class _PlanForm extends ConsumerStatefulWidget {
  const _PlanForm({required this.slug, required this.currency});

  final String slug;
  final String currency;

  @override
  ConsumerState<_PlanForm> createState() => _PlanFormState();
}

class _PlanFormState extends ConsumerState<_PlanForm> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _credits = TextEditingController();
  final _discount = TextEditingController();
  final _days = TextEditingController();
  PlanKind _kind = PlanKind.pass;
  Map<String, String> _errors = const {};
  bool _busy = false;

  @override
  void dispose() {
    for (final c in [_name, _price, _credits, _discount, _days]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final input = PlanInput(
      name: _name.text,
      kind: _kind,
      price: _price.text,
      credits: _credits.text,
      discountPct: _discount.text,
      validDays: _days.text,
    );
    final local = input.validate();
    if (local.isNotEmpty) {
      setState(() => _errors = local);
      return;
    }
    setState(() {
      _busy = true;
      _errors = const {};
    });
    try {
      final plan = await ref.read(growthCommandsProvider.notifier).createPlan(widget.slug, input);
      if (mounted) Navigator.of(context).pop(plan);
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _errors = e is ApiError && e.fieldErrors.isNotEmpty
              ? e.fieldErrors
              : {'name': AsyncView.messageFor(e)};
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('New plan', style: AppType.displayS),
        const SizedBox(height: Spacing.x3),
        Wrap(
          spacing: Spacing.x2,
          children: [
            for (final k in PlanKind.values)
              AppChoiceChip(
                label: k == PlanKind.pass ? 'Pass — one-time' : 'Membership — monthly',
                selected: _kind == k,
                onSelected: () => setState(() => _kind = k),
              ),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: 'Name', hintText: '10-game pass', errorText: _errors['name']),
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _price,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Price',
            prefixText: '${Money.symbol(widget.currency)} ',
            errorText: _errors['price'],
          ),
        ),
        const SizedBox(height: Spacing.x3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: _credits,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Credits', hintText: '10', errorText: _errors['credits']),
              ),
            ),
            const SizedBox(width: Spacing.x3),
            Expanded(
              child: TextField(
                controller: _discount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Discount',
                  suffixText: '%',
                  errorText: _errors['discountPct'],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _days,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Valid for (days) — optional',
            helperText: 'Leave empty for no expiry.',
            errorText: _errors['validDays'],
          ),
        ),
        const SizedBox(height: Spacing.x4),
        FilledButton(onPressed: _busy ? null : _save, child: Text(_busy ? 'Saving…' : 'Create plan')),
      ],
    );
  }
}
