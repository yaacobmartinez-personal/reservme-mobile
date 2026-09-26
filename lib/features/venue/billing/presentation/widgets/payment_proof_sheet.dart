import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/money/money.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/time/app_time.dart';
import '../../../../../core/widgets/async_view.dart';
import '../../../../../core/widgets/sheet_shell.dart';
import '../../../../../core/widgets/wall_clock_field.dart';
import '../../domain/billing.dart';

/// What the sheet hands back: the reference and date, plus the screenshot of
/// the transfer when the owner attached one.
class ProofSubmission {
  const ProofSubmission({required this.input, this.receipt});

  final PaymentProofInput input;
  final List<int>? receipt;
}

/// G4 · "I've paid". The amount is shown but never entered: the server takes
/// it from the band, because what a venue owes is not something it declares.
///
/// The screenshot is optional and worth offering: whoever approves the payment
/// is matching a reference number against a bank statement by hand, and a
/// picture of the transfer is what settles it.
Future<ProofSubmission?> showPaymentProofSheet(
  BuildContext context, {
  required int amountCents,
  required String timezone,
}) =>
    showModalBottomSheet<ProofSubmission>(
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
  String? _receiptPath;

  @override
  void dispose() {
    _reference.dispose();
    super.dispose();
  }

  Future<void> _pick(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        // Resized on the way in, so the upload is a photo and not a payload.
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 82,
      );
      if (picked != null && mounted) setState(() => _receiptPath = picked.path);
    } catch (e) {
      if (mounted) setState(() => _error = AsyncView.messageFor(e));
    }
  }

  Future<void> _send() async {
    final input = PaymentProofInput(
      reference: _reference.text,
      paidAt: _paidAt,
    );
    final message = input.validate();
    if (message != null) {
      setState(() => _error = message);
      return;
    }

    final bytes =
        _receiptPath == null ? null : await File(_receiptPath!).readAsBytes();
    if (!mounted) return;
    Navigator.of(context).pop(ProofSubmission(input: input, receipt: bytes));
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
        const SizedBox(height: Spacing.x3),
        if (_receiptPath == null)
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pick(ImageSource.camera),
                  icon: const Icon(Icons.photo_camera_outlined, size: 18),
                  label: const Text('Photo'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ),
              const SizedBox(width: Spacing.x2),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pick(ImageSource.gallery),
                  icon: const Icon(Icons.image_outlined, size: 18),
                  label: const Text('Screenshot'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ),
            ],
          )
        else
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Radii.sm),
                child: Image.file(
                  File(_receiptPath!),
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: Spacing.x3),
              Expanded(
                child: Text(
                  'Receipt attached',
                  style: AppType.bodyS.copyWith(color: p.ink2),
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _receiptPath = null),
                child: const Text('Remove'),
              ),
            ],
          ),
        const SizedBox(height: Spacing.x2),
        Text(
          'Optional — a screenshot of the transfer is what settles a '
          'reference nobody can find.',
          style: AppType.caption.copyWith(color: p.ink3),
        ),
      ],
    );
  }
}
