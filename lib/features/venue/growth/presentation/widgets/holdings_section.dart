import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/money/money.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/status_chip.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/time/app_time.dart';
import '../../../../../core/ui/primitives.dart';
import '../../../../../core/widgets/async_view.dart';
import '../../application/growth_controllers.dart';
import '../../domain/growth.dart';

/// A customer's passes and memberships on their profile (API-CONTRACT #43),
/// with the desk's way to record one they just bought.
class HoldingsSection extends ConsumerWidget {
  const HoldingsSection({
    super.key,
    required this.venueSlug,
    required this.customerId,
    required this.holdings,
    required this.timezone,
    required this.currency,
    required this.canManage,
  });

  final String venueSlug;
  final String customerId;
  final List<Holding> holdings;
  final String timezone;
  final String currency;
  final bool canManage;

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final List<MembershipPlan> plans;
    try {
      plans = (await ref.read(membershipPlansProvider(venueSlug).future)).where((p) => p.active).toList();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
      return;
    }
    if (!context.mounted) return;
    if (plans.isEmpty) {
      messenger.showSnackBar(const SnackBar(
        content: Text('No plans on sale yet — make one under More › Passes & memberships.'),
      ));
      return;
    }
    final plan = await showModalBottomSheet<MembershipPlan>(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Spacing.gutter, Spacing.x4, Spacing.gutter, Spacing.x1),
              child: Text('What did they buy?', style: AppType.displayS),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.gutter),
              child: Text(
                'Take payment at the desk as usual; this records it and starts the credits.',
                style: AppType.bodyS.copyWith(color: sheetContext.palette.ink3),
              ),
            ),
            for (final p in plans)
              ListTile(
                title: Text(p.name),
                subtitle: Text('${Money.format(p.priceCents, currency: currency)} · ${p.benefits}'),
                onTap: () => Navigator.of(sheetContext).pop(p),
              ),
            const SizedBox(height: Spacing.x2),
          ],
        ),
      ),
    );
    if (plan == null) return;
    try {
      await ref.read(growthCommandsProvider.notifier).grantPlan(venueSlug, customerId, plan.id);
      messenger.showSnackBar(SnackBar(content: Text('${plan.name} added.')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(child: Eyebrow('Passes & memberships')),
            if (canManage) TextButton(onPressed: () => _add(context, ref), child: const Text('Add')),
          ],
        ),
        const SizedBox(height: Spacing.x2),
        if (holdings.isEmpty)
          Text('None. A pass or membership sold at the desk goes here.',
              style: AppType.bodyS.copyWith(color: p.ink3))
        else
          for (final h in holdings) ...[
            AppCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(h.planName, style: AppType.bodyStrong),
                        const SizedBox(height: 2),
                        Text(
                          [
                            if (h.kind == PlanKind.pass || h.creditsRemaining > 0)
                              h.creditsRemaining == 1 ? '1 credit left' : '${h.creditsRemaining} credits left',
                            if (h.discountPct != null) '${h.discountPct}% off',
                            if (h.expiresAt != null) 'until ${AppTime.formatDay(h.expiresAt!, timezone)}',
                          ].join(' · '),
                          style: AppType.bodyS.copyWith(color: p.ink3),
                        ),
                      ],
                    ),
                  ),
                  if (!h.isActive) StatusChip(h.status == 'expired' ? 'Expired' : 'Cancelled', tone: ChipTone.clay),
                ],
              ),
            ),
            const SizedBox(height: Spacing.x2),
          ],
      ],
    );
  }
}
