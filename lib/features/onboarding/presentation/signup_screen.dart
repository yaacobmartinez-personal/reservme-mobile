import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/photos.dart';
import '../../../core/widgets/async_view.dart';
import '../application/onboarding_controller.dart';
import '../domain/onboarding_input.dart';
import 'widgets/onboarding_shell.dart';

/// O1 · Create your owner account. One account runs every venue the person
/// owns; staff are invited later, not created here.
class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _accepted = false;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // A refusal names one field. Once that field is edited the message is
    // stale and, worse, contradicts what is on screen: "That email doesn't
    // look right" sitting under a perfectly good address.
    for (final field in [_name, _email, _password]) {
      field.addListener(_clearError);
    }
  }

  void _clearError() {
    if (_error != null) setState(() => _error = null);
  }

  @override
  void dispose() {
    for (final field in [_name, _email, _password]) {
      field.removeListener(_clearError);
    }
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  SignupInput get _input => SignupInput(
        name: _name.text,
        email: _email.text,
        password: _password.text,
        acceptedTerms: _accepted,
      );

  Future<void> _submit() async {
    final message = _input.validate();
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(onboardingProvider.notifier).signUp(_input);
      if (mounted) context.go(Routes.verify);
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

    return OnboardingShell(
      step: OnboardingStep.signup,
      heroAsset: Photos.court,
      title: 'Create your owner account',
      subtitle: 'One account runs all your venues. Staff get invited later.',
      onBack: () => context.pop(),
      busy: _busy,
      error: _error,
      primaryLabel: 'Continue',
      onPrimary: _submit,
      footerChild: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: AppType.bodyS.copyWith(color: p.ink3),
          ),
          GestureDetector(
            onTap: () => context.push(Routes.login),
            child: Text(
              'Sign in',
              style: AppType.bodyS.copyWith(
                color: p.pineInk,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      children: [
        _Labelled(
          label: 'Your name',
          child: TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
          ),
        ),
        const SizedBox(height: Spacing.x3),
        _Labelled(
          label: 'Email',
          child: TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textInputAction: TextInputAction.next,
          ),
        ),
        const SizedBox(height: Spacing.x3),
        _Labelled(
          label: 'Password',
          child: TextField(
            controller: _password,
            obscureText: _obscure,
            autocorrect: false,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                tooltip: _obscure ? 'Show password' : 'Hide password',
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'At least ${SignupInput.minPasswordLength} characters',
          style: AppType.caption.copyWith(color: p.ink3),
        ),
        const SizedBox(height: Spacing.x3),
        InkWell(
          onTap: () => setState(() => _accepted = !_accepted),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _accepted,
                onChanged: (v) => setState(() => _accepted = v ?? false),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    'I agree to the Terms and Privacy Policy',
                    style: AppType.bodyS.copyWith(color: p.ink2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Labelled extends StatelessWidget {
  const _Labelled({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppType.caption.copyWith(color: p.ink3)),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
