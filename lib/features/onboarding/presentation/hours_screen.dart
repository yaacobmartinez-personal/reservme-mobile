import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/wall_clock_field.dart';
import '../application/onboarding_controller.dart';
import '../domain/onboarding_input.dart';
import 'widgets/onboarding_shell.dart';

/// O5 · Opening hours for the first space. Weekly wall clock in the venue's
/// own zone — a day that is switched off simply has no row, which is exactly
/// what `setOpeningHours` writes.
class HoursScreen extends ConsumerStatefulWidget {
  const HoursScreen({super.key});

  @override
  ConsumerState<HoursScreen> createState() => _HoursScreenState();
}

class _HoursScreenState extends ConsumerState<HoursScreen> {
  HoursInput _hours = HoursInput.initial();
  bool _busy = false;
  String? _error;

  Future<void> _submit() async {
    final message = _hours.validate();
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(onboardingProvider.notifier).setHours(_hours);
      if (mounted) context.go(Routes.policy);
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
    final draft = ref.watch(onboardingProvider);
    final space = draft.spaceName ?? 'your space';

    return OnboardingShell(
      step: OnboardingStep.hours,
      title: 'When is $space open?',
      subtitle: 'Weekly hours in ${draft.timezone}. Copy to other spaces later.',
      onBack: () => context.pop(),
      busy: _busy,
      error: _error,
      primaryLabel: 'Set booking policy',
      onPrimary: _submit,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: Spacing.x2),
          decoration: BoxDecoration(
            color: p.card,
            borderRadius: BorderRadius.circular(Radii.card),
            border: Border.all(color: p.rule),
          ),
          child: Column(
            children: [
              for (final day in _hours.weekOrder)
                _DayRow(
                  day: day,
                  onChanged: (next) => setState(() => _hours = _hours.replacing(next)),
                ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.x3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              // Monday is the week's first working day, so it is the one worth
              // copying from.
              onPressed: () => setState(() => _hours = _hours.copyFrom(1)),
              child: const Text('Copy Mon to all'),
            ),
            TextButton(
              onPressed: () => setState(() => _hours = _hours.everyDay(1)),
              child: const Text('Same every day'),
            ),
          ],
        ),
      ],
    );
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({required this.day, required this.onChanged});

  final DayHours day;
  final ValueChanged<DayHours> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.x3,
        vertical: 6,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 42,
            child: Text(
              day.name,
              style: AppType.bodyStrong.copyWith(
                color: day.open ? p.ink : p.ink3,
              ),
            ),
          ),
          Switch(
            value: day.open,
            onChanged: (v) => onChanged(day.copyWith(open: v)),
          ),
          const SizedBox(width: Spacing.x2),
          if (!day.open)
            Expanded(
              child: Text(
                'Closed',
                style: AppType.bodyS.copyWith(color: p.ink3),
              ),
            )
          else ...[
            Expanded(
              child: TimeField(
                label: '',
                value: day.opensAt,
                onChanged: (v) => onChanged(day.copyWith(opensAt: v)),
              ),
            ),
            const SizedBox(width: Spacing.x2),
            Expanded(
              child: TimeField(
                label: '',
                value: day.closesAt,
                onChanged: (v) => onChanged(day.copyWith(closesAt: v)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
