import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/app_banner.dart';
import '../../../core/widgets/async_view.dart';
import '../application/auth_controller.dart';

/// V2 · Forgot password. The answer is the same whether or not the address
/// has an account — anything else would tell a stranger which emails exist.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _email = TextEditingController();
  bool _busy = false;
  bool _sent = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_email.text.trim().isEmpty) {
      setState(() => _error = 'Enter the email you sign in with.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    FocusScope.of(context).unfocus();
    try {
      await ref.read(authControllerProvider.notifier).requestPasswordReset(_email.text);
      if (mounted) {
        setState(() {
          _busy = false;
          _sent = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = AsyncView.messageFor(e);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Spacing.x6, Spacing.x4, Spacing.x6, Spacing.x8),
        children: [
          Text(
            "Enter your email and we'll send a reset code.",
            style: AppType.bodyL.copyWith(color: p.ink2),
          ),
          const SizedBox(height: Spacing.x5),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            enabled: !_sent,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => _submit(),
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          if (_error != null) ...[
            const SizedBox(height: Spacing.x4),
            AppBanner(kind: BannerKind.error, title: _error!),
          ],
          if (_sent) ...[
            const SizedBox(height: Spacing.x4),
            const AppBanner(
              kind: BannerKind.success,
              title: 'Check your inbox',
              body: 'If that address has an account, a code is on its way. '
                  'It expires in an hour.',
            ),
          ] else ...[
            const SizedBox(height: Spacing.x5),
            FilledButton(
              onPressed: _busy ? null : _submit,
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
              child: _busy
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Send reset code'),
            ),
          ],
        ],
      ),
    );
  }
}
