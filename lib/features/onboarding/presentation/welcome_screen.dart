import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/motion.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/photos.dart';
import '../../shell/application/app_mode_controller.dart';
import '../application/onboarding_controller.dart';

/// O0 · Welcome — the pitch a venue owner lands on. Full-bleed photo, the
/// promise, and one way forward; customers get a way out at the bottom,
/// because this is the one screen where the two audiences meet.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final animate = ref.watch(motionSettingsProvider);

    Future<void> start() async {
      await ref.read(welcomeSeenProvider.notifier).markSeen();
      if (context.mounted) context.go(Routes.signup);
    }

    final hero = Image.asset(Photos.padel, fit: BoxFit.cover);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0A09),
      body: Stack(
        fit: StackFit.expand,
        children: [
          animate
              ? hero.animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                    begin: const Offset(1.04, 1.04),
                    end: const Offset(1.14, 1.14),
                    duration: const Duration(seconds: 18),
                    curve: Curves.easeInOut,
                  )
              : hero,
          // The copy sits on the photo, so it needs its own floor to stay
          // legible whatever the image does.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x000B0A09), Color(0xE60B0A09), Color(0xFF0B0A09)],
                stops: [0.38, 0.72, 1],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.gutter),
              child: Column(
                children: [
                  const SizedBox(height: Spacing.x4),
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: p.pine,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'R',
                          style: AppType.displayAt(19).copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: Spacing.x2),
                      // Flexible, not fixed: the wordmark gives way before the
                      // sign-in link does on a narrow phone.
                      Flexible(
                        child: Text(
                          AppConfig.appName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppType.displayAt(19)
                              .copyWith(color: const Color(0xFFFBFAF7)),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => context.push(Routes.login),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFFBFAF7),
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.x2),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: const Text('Sign in'),
                      ),
                    ],
                  ).enter(enabled: animate),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x29FBFAF7),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'Built for Philippine venues · 0% commission',
                        style: AppType.captionStrong.copyWith(
                          color: const Color(0xFFFBFAF7),
                        ),
                      ),
                    ),
                  ).enter(delay: staggerDelay(1), enabled: animate),
                  const SizedBox(height: Spacing.x4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your courts,\nbooked while\nyou sleep.',
                      style: AppType.displayAt(44).copyWith(
                        color: const Color(0xFFFBFAF7),
                        height: 0.98,
                      ),
                    ),
                  ).enter(delay: staggerDelay(2), enabled: animate),
                  const SizedBox(height: Spacing.x4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'A booking page for every space, a run sheet for every '
                      'morning, and no account needed for your customers.',
                      style: AppType.bodyL.copyWith(color: const Color(0xFFD9D5CC)),
                    ),
                  ).enter(delay: staggerDelay(3), enabled: animate),
                  const SizedBox(height: Spacing.x6),
                  FilledButton(
                    onPressed: start,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                    ),
                    child: const Text('Start your venue — first month free'),
                  ).enter(delay: staggerDelay(4), enabled: animate),
                  const SizedBox(height: Spacing.x2),
                  TextButton(
                    onPressed: () {
                      ref.read(appModeControllerProvider.notifier).set(AppMode.customer);
                      context.go(AppMode.customer.home);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFD9D5CC),
                    ),
                    child: const Text('Just booking? Find a venue →'),
                  ).enter(delay: staggerDelay(5), enabled: animate),
                  const SizedBox(height: Spacing.x4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
