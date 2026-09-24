import 'package:flutter/material.dart';

import '../../../../../core/model/opening_hours.dart';
import '../../../../../core/money/money.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/sheet_shell.dart';
import '../../../../../core/widgets/wall_clock_field.dart';
import '../../domain/space_input.dart';

/// G1 · a peak-price rule, ported from `addPricingRule`: at least one day, an
/// end after the start, and a price that overrides the base inside that
/// window.
Future<PricingRuleInput?> showPricingRuleSheet(
  BuildContext context, {
  required String currency,
}) =>
    showModalBottomSheet<PricingRuleInput>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _PricingRuleSheet(currency: currency),
      ),
    );

class _PricingRuleSheet extends StatefulWidget {
  const _PricingRuleSheet({required this.currency});

  final String currency;

  @override
  State<_PricingRuleSheet> createState() => _PricingRuleSheetState();
}

class _PricingRuleSheetState extends State<_PricingRuleSheet> {
  final _label = TextEditingController();
  final _price = TextEditingController();

  // Evenings on weekdays is what a court actually charges more for, so that
  // is where the sheet starts.
  PricingRuleInput _input = const PricingRuleInput(weekdays: [1, 2, 3, 4, 5]);
  String? _error;

  @override
  void dispose() {
    _label.dispose();
    _price.dispose();
    super.dispose();
  }

  void _save() {
    final input = _input.copyWith(
      label: _label.text,
      priceCents: SpaceInput.toCents(_price.text),
    );
    final message = input.validate();
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    Navigator.of(context).pop(input);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return SheetShell(
      title: 'Peak pricing',
      subtitle: 'Charge more inside a window on the days you pick',
      error: _error,
      primaryLabel: 'Add rule',
      onPrimary: _save,
      children: [
        TextField(
          controller: _label,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Label',
            hintText: 'Evening peak',
          ),
        ),
        const SizedBox(height: Spacing.x3),
        Text('Days', style: AppType.caption.copyWith(color: p.ink3)),
        const SizedBox(height: 6),
        Wrap(
          spacing: Spacing.x2,
          runSpacing: Spacing.x2,
          // Monday first on screen, stored 0 = Sunday like the column.
          children: [
            for (var i = 1; i <= 7; i++)
              _DayChip(
                weekday: i % 7,
                selected: _input.weekdays.contains(i % 7),
                onTap: () => setState(() => _input = _input.toggleDay(i % 7)),
              ),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        Row(
          children: [
            Expanded(
              child: TimeField(
                label: 'From',
                value: _input.startsAt,
                onChanged: (v) => setState(() => _input = _input.copyWith(startsAt: v)),
              ),
            ),
            const SizedBox(width: Spacing.x3),
            Expanded(
              child: TimeField(
                label: 'To',
                value: _input.endsAt,
                onChanged: (v) => setState(() => _input = _input.copyWith(endsAt: v)),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _price,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Price per slot in this window',
            prefixText: Money.symbol(widget.currency),
          ),
        ),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.weekday,
    required this.selected,
    required this.onTap,
  });

  final int weekday;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => FilterChip(
        label: Text(DayHours.names[weekday]),
        selected: selected,
        onSelected: (_) => onTap(),
      );
}
