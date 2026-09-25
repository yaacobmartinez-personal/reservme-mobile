import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/api_mode.dart';
import '../../../core/config/app_config.dart';
import '../../../core/config/feature_availability.dart';
import '../../../core/router/guards.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/app_banner.dart';
import '../../../core/widgets/async_view.dart';
import '../../shell/application/app_mode_controller.dart';
import '../application/auth_controller.dart';

/// V1 · Staff sign in. The only account in the app: customers never see this
/// screen, which is why it says so at the bottom.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.from});

  /// Where to return after signing in (set by the router's guard).
  final String? from;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_email.text.trim().isEmpty || _password.text.isEmpty) {
      setState(() => _error = 'Enter your email and password.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    FocusScope.of(context).unfocus();
    try {
      await ref.read(authControllerProvider.notifier).signIn(
            email: _email.text,
            password: _password.text,
          );
      if (!mounted) return;
      final auth = ref.read(authControllerProvider);
      ref.read(appModeControllerProvider.notifier).set(AppMode.venue);
      context.go(afterSignInTarget(
        from: widget.from,
        auth: auth,
        canOnboard: isAvailable(Feature.onboarding, ref.read(apiModeProvider)),
      ));
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
    final apiMode = ref.watch(apiModeProvider);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Spacing.x6, Spacing.x6, Spacing.x6, Spacing.x8),
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: p.pine,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text('R', style: AppType.displayAt(18).copyWith(color: p.onPine)),
              ),
              const SizedBox(width: Spacing.x2),
              Text(AppConfig.appName, style: AppType.displayAt(18).copyWith(color: p.ink)),
            ],
          ),
          const SizedBox(height: Spacing.x3),
          Text('Venue staff sign in', style: AppType.displayAt(34).copyWith(color: p.ink)),
          const SizedBox(height: Spacing.x2),
          Text(
            'Use the same email and password as your venue account.',
            style: AppType.bodyL.copyWith(color: p.ink2),
          ),
          const SizedBox(height: Spacing.x6),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: Spacing.x3),
          TextField(
            controller: _password,
            obscureText: _obscure,
            autocorrect: false,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                tooltip: _obscure ? 'Show password' : 'Hide password',
                icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: Spacing.x4),
            AppBanner(kind: BannerKind.error, title: _error!),
          ],
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
                : const Text('Sign in'),
          ),
          const SizedBox(height: Spacing.x2),
          Center(
            child: TextButton(
              onPressed: () => context.push(Routes.forgot),
              child: const Text('Forgot password?'),
            ),
          ),
          const SizedBox(height: Spacing.x2),
          // The way in for a venue that has not signed up yet. Without this
          // the onboarding flow exists but nothing reaches it.
          Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'New to ReservMe? ',
                  style: AppType.bodyS.copyWith(color: p.ink3),
                ),
                GestureDetector(
                  onTap: () => context.push(Routes.welcome),
                  child: Text(
                    'Set up your venue →',
                    style: AppType.bodyS.copyWith(
                      color: p.pineInk,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (apiMode == ApiMode.fake) ...[
            const SizedBox(height: Spacing.x4),
            _DemoAccounts(
              onPick: (email) {
                _email.text = email;
                _password.text = FakeAccountsHint.password;
              },
            ),
          ],
          const SizedBox(height: Spacing.x8),
          AppBanner(
            kind: BannerKind.info,
            title: 'Just booking a court?',
            body: "You don't need an account.",
            actionLabel: 'Find a venue',
            onAction: () => context.go(AppMode.customer.home),
          ),
          const SizedBox(height: Spacing.x4),
          Center(
            child: Text(
              'Server: ${Uri.parse(AppConfig.defaultServerUrl).host}',
              style: AppType.caption.copyWith(color: p.ink3),
            ),
          ),
        ],
      ),
    );
  }
}

/// Fake-mode convenience: the seeded accounts, one tap to fill.
class _DemoAccounts extends StatelessWidget {
  const _DemoAccounts({required this.onPick});

  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.all(Spacing.x3),
      decoration: BoxDecoration(
        color: p.claySoft,
        borderRadius: BorderRadius.circular(Radii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fake mode — demo accounts',
            style: AppType.captionStrong.copyWith(color: p.clayInk),
          ),
          const SizedBox(height: Spacing.x2),
          Wrap(
            spacing: Spacing.x2,
            children: [
              for (final (label, email) in const [
                ('Owner', FakeAccountsHint.owner),
                ('Front desk', FakeAccountsHint.staff),
              ])
                ActionChip(
                  label: Text(label),
                  onPressed: () => onPick(email),
                  backgroundColor: p.card,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The seeded credentials, duplicated here so the login screen does not
/// import the fake store into a release build.
abstract final class FakeAccountsHint {
  static const owner = 'owner@reservme.test';
  static const staff = 'staff@reservme.test';
  static const password = 'password123';
}
