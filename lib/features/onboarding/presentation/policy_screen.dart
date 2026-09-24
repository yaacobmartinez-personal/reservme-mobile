import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/model/enums.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/status_chip.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/primitives.dart';
import '../../../core/widgets/async_view.dart';
import '../application/onboarding_controller.dart';
import '../domain/onboarding_input.dart';
import 'widgets/onboarding_shell.dart';

/// O6 · Booking rules — the last step. Everything here has a sensible default
/// and lives in Venue settings afterwards, so the screen's job is to let
/// someone say yes quickly rather than to make them decide.
class PolicyScreen extends ConsumerStatefulWidget {
  const PolicyScreen({super.key});

  @override
  ConsumerState<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends ConsumerState<PolicyScreen> {
  PolicyInput _policy = const PolicyInput();
  bool _busy = false;
  String? _error;

  Future<void> _submit() async {
    final message = _policy.validate();
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(onboardingProvider.notifier).goLive(_policy);
      if (mounted) context.go(Routes.live);
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
      step: OnboardingStep.policy,
      title: 'Booking rules',
      subtitle: 'Sensible defaults — change any of them later in Venue settings.',
      onBack: () => context.pop(),
      busy: _busy,
      error: _error,
      primaryLabel: 'Go live',
      onPrimary: _submit,
      children: [
        const Eyebrow('Customers can cancel online'),
        const SizedBox(height: Spacing.x2),
        Container(
          decoration: BoxDecoration(
            color: p.card,
            borderRadius: BorderRadius.circular(Radii.card),
            border: Border.all(color: p.rule),
          ),
          child: RadioGroup<CancellationMode>(
            groupValue: _policy.cancellationMode,
            onChanged: (m) =>
                setState(() => _policy = _policy.copyWith(cancellationMode: m)),
            child: Column(
              children: [
                _ModeRow(
                  mode: CancellationMode.anytime,
                  selected: _policy.cancellationMode,
                  label: 'Anytime before the booking',
                  onTap: (m) =>
                      setState(() => _policy = _policy.copyWith(cancellationMode: m)),
                ),
                _ModeRow(
                  mode: CancellationMode.grace,
                  selected: _policy.cancellationMode,
                  label: 'Up to',
                  onTap: (m) =>
                      setState(() => _policy = _policy.copyWith(cancellationMode: m)),
                  trailing: _GraceStepper(
                    hours: _policy.graceHours,
                    enabled: _policy.cancellationMode == CancellationMode.grace,
                    onChanged: (h) =>
                        setState(() => _policy = _policy.copyWith(graceHours: h)),
                  ),
                ),
                _ModeRow(
                  mode: CancellationMode.never,
                  selected: _policy.cancellationMode,
                  label: 'Never — they contact us',
                  onTap: (m) =>
                      setState(() => _policy = _policy.copyWith(cancellationMode: m)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Spacing.x4),
        const Eyebrow('Notice & horizon'),
        const SizedBox(height: Spacing.x2),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Minimum notice', style: AppType.caption.copyWith(color: p.ink3)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    initialValue: _policy.minNoticeMinutes,
                    isExpanded: true,
                    items: [
                      for (final minutes in PolicyInput.noticeChoices)
                        DropdownMenuItem(
                          value: minutes,
                          child: Text(PolicyInput.noticeLabel(minutes)),
                        ),
                    ],
                    onChanged: (v) =>
                        setState(() => _policy = _policy.copyWith(minNoticeMinutes: v)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Spacing.x3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Book up to', style: AppType.caption.copyWith(color: p.ink3)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    initialValue: _policy.maxHorizonDays,
                    isExpanded: true,
                    items: [
                      for (final days in PolicyInput.horizonChoices)
                        DropdownMenuItem(
                          value: days,
                          child: Text(
                            PolicyInput.horizonLabel(days),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: (v) =>
                        setState(() => _policy = _policy.copyWith(maxHorizonDays: v)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.x4),
        const Eyebrow('Payment'),
        const SizedBox(height: Spacing.x2),
        AppCard(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pay at the venue',
                      style: AppType.bodyStrong.copyWith(color: p.ink),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Cash, GCash or card on arrival. Online payment comes later.',
                      style: AppType.caption.copyWith(color: p.ink3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.x2),
              const StatusChip('Default', tone: ChipTone.pine),
            ],
          ),
        ),
      ],
    );
  }
}

class _ModeRow extends StatelessWidget {
  const _ModeRow({
    required this.mode,
    required this.selected,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final CancellationMode mode;
  final CancellationMode selected;
  final String label;
  final ValueChanged<CancellationMode> onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return InkWell(
      onTap: () => onTap(mode),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.x3, vertical: 6),
        child: Row(
          children: [
            Radio<CancellationMode>(value: mode),
            const SizedBox(width: 4),
            // The grace option reads "Up to [24] hours before" on one line,
            // which is wider than a 360pt phone. Both halves give way rather
            // than overflowing.
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppType.body.copyWith(color: p.ink),
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: Spacing.x2),
              Flexible(child: trailing!),
            ],
          ],
        ),
      ),
    );
  }
}

class _GraceStepper extends StatelessWidget {
  const _GraceStepper({
    required this.hours,
    required this.enabled,
    required this.onChanged,
  });

  final int hours;
  final bool enabled;
  final ValueChanged<int> onChanged;

  /// The windows a venue actually picks, rather than a free number field.
  static const choices = [1, 2, 6, 12, 24, 48, 72];

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButton<int>(
          value: choices.contains(hours) ? hours : 24,
          underline: const SizedBox.shrink(),
          isDense: true,
          onChanged: enabled ? (v) => onChanged(v ?? hours) : null,
          items: [for (final h in choices) DropdownMenuItem(value: h, child: Text('$h'))],
        ),
        Flexible(
          child: Text(
            ' hours before',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppType.body.copyWith(color: enabled ? p.ink : p.ink3),
          ),
        ),
      ],
    );
  }
}
