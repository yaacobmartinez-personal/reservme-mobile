import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/photos.dart';
import '../../../core/widgets/async_view.dart';
import '../../auth/application/auth_controller.dart';
import '../application/onboarding_controller.dart';
import 'widgets/onboarding_shell.dart';

/// O2 · Check your email. Skippable on purpose: booking emails start once the
/// address is confirmed, and blocking someone here to go hunt for a code is a
/// good way to lose them mid-setup.
class VerifyScreen extends ConsumerStatefulWidget {
  const VerifyScreen({super.key});

  @override
  ConsumerState<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends ConsumerState<VerifyScreen> {
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;
  String? _note;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    if (_code.text.trim().length < 6) {
      setState(() => _error = 'Enter all six digits.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(onboardingProvider.notifier).verify(_code.text);
      if (mounted) context.go(Routes.createVenue);
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = AsyncView.messageFor(e);
        });
      }
    }
  }

  Future<void> _skip() async {
    await ref.read(onboardingProvider.notifier).skipVerification();
    if (mounted) context.go(Routes.createVenue);
  }

  Future<void> _resend() async {
    try {
      await ref.read(onboardingProvider.notifier).resendCode();
      if (mounted) setState(() => _note = 'Sent again — check your spam folder.');
    } catch (e) {
      if (mounted) setState(() => _error = AsyncView.messageFor(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final email = ref.watch(authControllerProvider).userOrNull?.email ?? 'your email';
    final name = ref.watch(authControllerProvider).userOrNull?.name;

    return OnboardingShell(
      step: OnboardingStep.verify,
      title: 'Check your email',
      subtitle: 'Enter the code, or keep going and verify later — booking '
          'emails send once you do.',
      onBack: () => context.pop(),
      busy: _busy,
      error: _error,
      primaryLabel: 'Verify',
      onPrimary: _verify,
      footerChild: TextButton(
        onPressed: _busy ? null : _skip,
        child: const Text('Skip for now'),
      ),
      children: [
        Container(
          padding: const EdgeInsets.all(Spacing.x3),
          decoration: BoxDecoration(
            color: p.card,
            borderRadius: BorderRadius.circular(Radii.card),
            border: Border.all(color: p.rule),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Radii.md),
                child: Image.asset(
                  Photos.owner,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: Spacing.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name == null
                          ? 'One more step'
                          : 'Hi ${name.split(' ').first} — one more step',
                      style: AppType.bodyStrong.copyWith(color: p.ink),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'We emailed a 6-digit code to $email',
                      style: AppType.caption.copyWith(color: p.ink3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.x4),
        TextField(
          controller: _code,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          autofocus: true,
          onSubmitted: (_) => _verify(),
          onChanged: (v) {
            if (v.length == 6) _verify();
          },
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: AppType.displayAt(30).copyWith(color: p.ink, letterSpacing: 12),
          decoration: const InputDecoration(counterText: '', hintText: '------'),
        ),
        const SizedBox(height: Spacing.x2),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Didn't get it? ",
              style: AppType.bodyS.copyWith(color: p.ink3),
            ),
            GestureDetector(
              onTap: _resend,
              child: Text(
                'Resend',
                style: AppType.bodyS.copyWith(
                  color: p.pineInk,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              ' · check spam',
              style: AppType.bodyS.copyWith(color: p.ink3),
            ),
          ],
        ),
        if (_note != null) ...[
          const SizedBox(height: Spacing.x2),
          Text(
            _note!,
            textAlign: TextAlign.center,
            style: AppType.caption.copyWith(color: p.pineInk),
          ),
        ],
      ],
    );
  }
}
