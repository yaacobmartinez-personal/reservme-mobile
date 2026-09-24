import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/week_hours_editor.dart';
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
        WeekHoursEditor(
          hours: _hours,
          onChanged: (next) => setState(() => _hours = next),
        ),
      ],
    );
  }
}
