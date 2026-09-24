import 'package:flutter/material.dart';

import '../../../../../core/money/money.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/time/app_time.dart';
import '../../../../../core/widgets/sheet_shell.dart';
import '../../../../../core/widgets/wall_clock_field.dart';
import '../../domain/billing.dart';

/// G4 · "I've paid". The amount is shown but never entered: the server takes
/// it from the band, because what a venue owes is not something it declares.
Future<PaymentProofInput?> showPaymentProofSheet(
  BuildContext context, {
  required int amountCents,
  required String timezone,
}) =>
    showModalBottomSheet<PaymentProofInput>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _ProofSheet(amountCents: amountCents, timezone: timezone),
      ),
    );

class _ProofSheet extends StatefulWidget {
  const _ProofSheet({required this.amountCents, required this.timezone});

  final int amountCents;
  final String timezone;

  @override
  State<_ProofSheet> createState() => _ProofSheetState();
}

class _ProofSheetState extends State<_ProofSheet> {
  final _reference = TextEditingController();
  late String _paidAt =
      AppTime.today(DateTime.now().toUtc(), widget.timezone);
  String? _error;

  @override
  void dispose() {
    _reference.dispose();
    super.dispose();
  }

  void _send() {
    final input = PaymentProofInput(
      reference: _reference.text,
      paidAt: _paidAt,
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
      title: 'Tell us you paid',
      subtitle: 'We match it against the transfer and confirm',
      error: _error,
      primaryLabel: 'Submit for review',
      onPrimary: _send,
      children: [
        Container(
          padding: const EdgeInsets.all(Spacing.x3),
          decoration: BoxDecoration(
            color: p.paper2,
            borderRadius: BorderRadius.circular(Radii.sm),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Amount due',
                  style: AppType.bodyS.copyWith(color: p.ink3),
                ),
              ),
              Text(
                Money.format(widget.amountCents, currency: 'PHP'),
                style: AppType.bodyStrong,
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _reference,
          autocorrect: false,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(
            labelText: 'InstaPay reference number',
          ),
        ),
        const SizedBox(height: Spacing.x3),
        DateField(
          label: 'Date you paid',
          value: _paidAt,
          timezone: widget.timezone,
          onChanged: (v) => setState(() => _paidAt = v),
        ),
      ],
    );
  }
}
