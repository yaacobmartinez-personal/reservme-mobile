import 'package:flutter/material.dart';

import '../../../../../core/model/enums.dart';
import '../../../../../core/money/money.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../domain/space_input.dart';
import 'sheet_shell.dart';

/// G1 · the basics, ported from `spaceSchema`. The price is typed in pesos and
/// stored in centavos, the same conversion `toCents` does on the server.
///
/// Returns the edited input, or null if the sheet was dismissed. The caller
/// does the write, so a refusal lands on the screen that can show it.
Future<SpaceInput?> showBasicsSheet(
  BuildContext context, {
  required SpaceInput initial,
  required String currency,
}) =>
    showModalBottomSheet<SpaceInput>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _BasicsSheet(initial: initial, currency: currency),
      ),
    );

class _BasicsSheet extends StatefulWidget {
  const _BasicsSheet({required this.initial, required this.currency});

  final SpaceInput initial;
  final String currency;

  @override
  State<_BasicsSheet> createState() => _BasicsSheetState();
}

class _BasicsSheetState extends State<_BasicsSheet> {
  late final _name = TextEditingController(text: widget.initial.name);
  late final _price =
      TextEditingController(text: Money.toMajorInput(widget.initial.priceCents));
  late final _capacity =
      TextEditingController(text: '${widget.initial.capacity}');
  late final _buffer = TextEditingController(text: '${widget.initial.bufferMinutes}');
  late SpaceKind _kind = widget.initial.kind;
  late int _slot = widget.initial.slotMinutes;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _capacity.dispose();
    _buffer.dispose();
    super.dispose();
  }

  SpaceInput get _input => SpaceInput(
        name: _name.text,
        kind: _kind,
        capacity: int.tryParse(_capacity.text.trim()) ?? 0,
        slotMinutes: _slot,
        bufferMinutes: int.tryParse(_buffer.text.trim()) ?? 0,
        priceCents: SpaceInput.toCents(_price.text),
      );

  void _save() {
    final input = _input;
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
      title: 'Edit space',
      subtitle: 'What it is, how long a slot runs, what it costs',
      error: _error,
      primaryLabel: 'Save',
      onPrimary: _save,
      children: [
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        const SizedBox(height: Spacing.x3),
        DropdownButtonFormField<SpaceKind>(
          initialValue: _kind,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Kind'),
          items: [
            for (final kind in SpaceKind.values)
              DropdownMenuItem(value: kind, child: Text(kind.label)),
          ],
          onChanged: (v) => setState(() => _kind = v ?? _kind),
        ),
        const SizedBox(height: Spacing.x3),
        DropdownButtonFormField<int>(
          initialValue: SpaceInput.slotChoices.contains(_slot)
              ? _slot
              : SpaceInput.slotChoices.first,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Slot length'),
          items: [
            for (final minutes in SpaceInput.slotChoices)
              DropdownMenuItem(value: minutes, child: Text('$minutes minutes')),
          ],
          onChanged: (v) => setState(() => _slot = v ?? _slot),
        ),
        const SizedBox(height: Spacing.x3),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _price,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Price per slot',
                  prefixText: Money.symbol(widget.currency),
                ),
              ),
            ),
            const SizedBox(width: Spacing.x3),
            Expanded(
              child: TextField(
                controller: _capacity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Capacity'),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _buffer,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Turnaround buffer (minutes)',
          ),
        ),
        const SizedBox(height: Spacing.x2),
        Text(
          'A buffer keeps the next booking from starting the moment the last '
          'one ends.',
          style: AppType.bodyS.copyWith(color: p.ink3),
        ),
      ],
    );
  }
}
