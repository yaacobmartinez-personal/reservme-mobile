import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/primitives.dart';
import '../../application/onboarding_controller.dart';

/// The frame every onboarding step shares (boards O1–O6): an optional hero
/// photo, the progress bar, a title and subtitle, the step's own content, and
/// a sticky footer that never scrolls out of reach.
class OnboardingShell extends ConsumerWidget {
  const OnboardingShell({
    super.key,
    required this.step,
    required this.title,
    required this.subtitle,
    required this.children,
    required this.primaryLabel,
    required this.onPrimary,
    this.heroAsset,
    this.footerChild,
    this.busy = false,
    this.error,
    this.onBack,
  });

  final OnboardingStep step;
  final String title;
  final String subtitle;
  final List<Widget> children;
  final String primaryLabel;
  final VoidCallback? onPrimary;

  /// The full-bleed photo at the top. Steps without one start at the progress
  /// bar, which is what boards O2, O4, O5 and O6 do.
  final String? heroAsset;

  /// Under the primary button — "Skip for now", "Already have an account?".
  final Widget? footerChild;
  final bool busy;
  final String? error;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final animate = ref.watch(motionSettingsProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                if (heroAsset != null)
                  SliverToBoxAdapter(
                    child: _Hero(asset: heroAsset!, onBack: onBack, animate: animate),
                  ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    Spacing.gutter,
                    heroAsset == null ? Spacing.x6 : Spacing.x4,
                    Spacing.gutter,
                    Spacing.x6,
                  ),
                  sliver: SliverList.list(
                    children: [
                      if (heroAsset == null && onBack != null) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RoundIconButton(
                            icon: Icons.chevron_left_rounded,
                            onPressed: onBack,
                            tooltip: 'Back',
                          ),
                        ),
                        const SizedBox(height: Spacing.x3),
                      ],
                      StepProgress(step: step, animate: animate),
                      const SizedBox(height: Spacing.x2),
                      Text(
                        'Step ${step.number} of ${OnboardingStep.total}',
                        style: AppType.bodyS.copyWith(color: p.ink3),
                      ),
                      const SizedBox(height: Spacing.x3),
                      Text(
                        title,
                        style: AppType.displayAt(34).copyWith(color: p.ink),
                      ).enter(enabled: animate),
                      const SizedBox(height: Spacing.x2),
                      Text(
                        subtitle,
                        style: AppType.bodyL.copyWith(color: p.ink2),
                      ).enter(delay: Motion.stagger, enabled: animate),
                      const SizedBox(height: Spacing.x5),
                      for (final (i, child) in children.indexed)
                        child.enter(
                          delay: staggerDelay(i + 2),
                          enabled: animate,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          StickyFooter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (error != null) ...[
                  Text(
                    error!,
                    textAlign: TextAlign.center,
                    style: AppType.bodyS.copyWith(color: p.danger),
                  ),
                  const SizedBox(height: Spacing.x2),
                ],
                FilledButton(
                  onPressed: busy ? null : onPrimary,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                  ),
                  child: busy
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(primaryLabel),
                ),
                if (footerChild != null) ...[
                  const SizedBox(height: Spacing.x2),
                  footerChild!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Six segments, filled up to the current step. The segment that just filled
/// animates; the ones behind it are simply full.
class StepProgress extends StatelessWidget {
  const StepProgress({super.key, required this.step, this.animate = true});

  final OnboardingStep step;
  final bool animate;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          for (var i = 1; i <= OnboardingStep.total; i++) ...[
            Expanded(
              child: _Segment(
                filled: i <= step.number,
                // Only the segment that just filled animates; the ones behind
                // it are simply full.
                animate: animate && i == step.number,
              ),
            ),
            if (i < OnboardingStep.total) const SizedBox(width: 6),
          ],
        ],
      );
}

class _Segment extends StatelessWidget {
  const _Segment({required this.filled, required this.animate});

  final bool filled;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final bar = Container(
      height: 4,
      decoration: BoxDecoration(
        color: filled ? p.pine : p.rule,
        borderRadius: BorderRadius.circular(2),
      ),
    );
    if (!filled || !animate) return bar;
    return bar
        .animate()
        .scaleX(begin: 0, end: 1, alignment: Alignment.centerLeft, duration: Motion.slow, curve: Curves.easeOutCubic);
  }
}

/// The full-bleed photo with a Ken Burns drift, as the canvas has it.
class _Hero extends StatelessWidget {
  const _Hero({required this.asset, required this.onBack, required this.animate});

  final String asset;
  final VoidCallback? onBack;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      asset,
      height: 260,
      width: double.infinity,
      fit: BoxFit.cover,
    );

    return SizedBox(
      height: 260,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRect(
            child: animate
                ? image
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(1.04, 1.04),
                      end: const Offset(1.14, 1.14),
                      duration: const Duration(seconds: 16),
                      curve: Curves.easeInOut,
                    )
                : image,
          ),
          if (onBack != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + Spacing.x2,
              left: Spacing.gutter,
              child: RoundIconButton(
                icon: Icons.chevron_left_rounded,
                onPressed: onBack,
                tooltip: 'Back',
                onBand: true,
              ),
            ),
        ],
      ),
    );
  }
}
