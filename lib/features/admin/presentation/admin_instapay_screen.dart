import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/async_view.dart';
import '../application/admin_controllers.dart';
import '../domain/admin.dart';
import 'widgets/admin_widgets.dart';

/// Where venues send their transfers (API-CONTRACT #40): the InstaPay QR,
/// the payee name and the account. Every venue's billing screen shows these,
/// so a wrong digit here is a wrong digit everywhere.
class AdminInstapayScreen extends ConsumerWidget {
  const AdminInstapayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(adminInstapayProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('InstaPay details')),
      body: AsyncView(
        value: settings,
        onRetry: () => ref.invalidate(adminInstapayProvider),
        data: (data) => _Form(initial: data),
      ),
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.initial});

  final InstapaySettings initial;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  late final _payee = TextEditingController(text: widget.initial.payee ?? '');
  late final _account = TextEditingController(text: widget.initial.account ?? '');
  String? _newQrPath;
  bool _clearQr = false;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _payee.dispose();
    _account.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        imageQuality: 90,
      );
      if (picked == null || !mounted) return;
      setState(() {
        _newQrPath = picked.path;
        _clearQr = false;
      });
    } catch (_) {
      if (mounted) setState(() => _error = "Couldn't open your photos.");
    }
  }

  Future<void> _save() async {
    if (_payee.text.trim().isEmpty) {
      setState(() => _error = 'Add the name transfers go to — venues check it before they pay.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    final messenger = ScaffoldMessenger.of(context);
    try {
      final bytes = _newQrPath == null ? null : await File(_newQrPath!).readAsBytes();
      await ref.read(adminCommandsProvider.notifier).saveInstapay(
            payee: _payee.text,
            account: _account.text,
            qrImage: bytes,
            clearQr: _clearQr,
          );
      messenger.showSnackBar(const SnackBar(content: Text('Saved. Every venue sees the new details.')));
    } catch (e) {
      if (mounted) setState(() => _error = AsyncView.messageFor(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final currentQr = _clearQr ? null : widget.initial.qrUrl;
    return ListView(
      padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x8),
      children: [
        Text(
          'Shown on every venue\'s billing screen. They scan the QR or type the '
          'account, then send you the reference to approve.',
          style: AppType.bodyS.copyWith(color: p.ink3),
        ),
        const AdminSection('QR CODE'),
        if (_newQrPath != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(Radii.sm),
            child: Image.file(File(_newQrPath!), height: 220, fit: BoxFit.contain),
          )
        else if (currentQr != null)
          AdminImage(url: currentQr, height: 220)
        else
          Text('No QR — venues will only see the account details.',
              style: AppType.bodyS.copyWith(color: p.ink3)),
        const SizedBox(height: Spacing.x2),
        Wrap(
          spacing: Spacing.x2,
          children: [
            OutlinedButton.icon(
              onPressed: _busy ? null : _pick,
              icon: const Icon(Icons.photo_library_outlined),
              label: Text(currentQr == null && _newQrPath == null ? 'Add QR' : 'Replace QR'),
            ),
            if (currentQr != null || _newQrPath != null)
              TextButton(
                onPressed: _busy
                    ? null
                    : () => setState(() {
                          _newQrPath = null;
                          _clearQr = true;
                        }),
                style: TextButton.styleFrom(foregroundColor: p.danger),
                child: const Text('Remove QR'),
              ),
          ],
        ),
        const AdminSection('ACCOUNT'),
        TextField(
          controller: _payee,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(labelText: 'Payee name'),
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _account,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(labelText: 'Account or mobile number'),
        ),
        if (_error != null) ...[
          const SizedBox(height: Spacing.x3),
          Text(_error!, style: AppType.bodyS.copyWith(color: p.danger)),
        ],
        const SizedBox(height: Spacing.x5),
        FilledButton(
          onPressed: _busy ? null : _save,
          child: Text(_busy ? 'Saving…' : 'Save'),
        ),
      ],
    );
  }
}
