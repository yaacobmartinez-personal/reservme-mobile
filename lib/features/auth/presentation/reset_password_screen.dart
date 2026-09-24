import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/app_banner.dart';
import '../../../core/widgets/async_view.dart';
import '../application/auth_controller.dart';

/// V3 · Choose a new password (API-CONTRACT #26, closing D14).
///
/// Until now a reset started in the app and finished on the website, which a
/// staff member with only a phone could not do at all.
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});

  /// Carried from the forgot screen so the code and the address stay
  /// together; a reset for an address you did not type is not a reset.
  final String email;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _code = TextEditingController();
  final _password = TextEditingController();
  bool _show = false;
  bool _busy = false;
  String? _error;

  static const _minPasswordLength = 10;

  @override
  void dispose() {
    _code.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_code.text.trim().length < 6) {
      setState(() => _error = 'Enter the six-digit code from the email.');
      return;
    }
    if (_password.text.length < _minPasswordLength) {
      setState(() => _error = 'Use at least $_minPasswordLength characters.');
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(authControllerProvider.notifier).resetPassword(
            email: widget.email,
            code: _code.text,
            password: _password.text,
          );
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Password changed. Sign in with it now.')),
      );
      context.go(Routes.login);
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
      appBar: AppBar(title: const Text('New password')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          Spacing.gutter,
          Spacing.x2,
          Spacing.gutter,
          Spacing.x8,
        ),
        children: [
          Text(
            'Check your email',
            style: AppType.displayAt(30).copyWith(color: p.ink),
          ),
          const SizedBox(height: Spacing.x2),
          Text(
            'We sent a six-digit code to ${widget.email}. Enter it with the '
            'password you want instead.',
            style: AppType.bodyL.copyWith(color: p.ink2),
          ),
          const SizedBox(height: Spacing.x5),
          TextField(
            controller: _code,
            keyboardType: TextInputType.number,
            autocorrect: false,
            maxLength: 6,
            decoration: const InputDecoration(
              labelText: 'Code',
              counterText: '',
            ),
          ),
          const SizedBox(height: Spacing.x3),
          TextField(
            controller: _password,
            obscureText: !_show,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'New password',
              helperText: 'At least $_minPasswordLength characters',
              suffixIcon: IconButton(
                icon: Icon(
                  _show ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                ),
                tooltip: _show ? 'Hide' : 'Show',
                onPressed: () => setState(() => _show = !_show),
              ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: Spacing.x3),
            AppBanner(kind: BannerKind.error, title: _error!),
          ],
          const SizedBox(height: Spacing.x5),
          FilledButton(
            onPressed: _busy ? null : _submit,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            child: _busy
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Change password'),
          ),
          const SizedBox(height: Spacing.x2),
          TextButton(
            onPressed: _busy
                ? null
                : () => ref
                    .read(authControllerProvider.notifier)
                    .requestPasswordReset(widget.email),
            child: const Text('Send another code'),
          ),
        ],
      ),
    );
  }
}
