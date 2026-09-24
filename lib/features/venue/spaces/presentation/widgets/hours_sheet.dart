import 'package:flutter/material.dart';

import '../../../../../core/model/opening_hours.dart';
import '../../../../../core/widgets/sheet_shell.dart';
import '../../../../../core/widgets/week_hours_editor.dart';

/// G1 · the week. Same grid as onboarding's O5, and the same rule: the whole
/// week is written at once, so a day switched off simply loses its row.
Future<HoursInput?> showHoursSheet(
  BuildContext context, {
  required HoursInput initial,
}) =>
    showModalBottomSheet<HoursInput>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _HoursSheet(initial: initial),
      ),
    );

class _HoursSheet extends StatefulWidget {
  const _HoursSheet({required this.initial});

  final HoursInput initial;

  @override
  State<_HoursSheet> createState() => _HoursSheetState();
}

class _HoursSheetState extends State<_HoursSheet> {
  late HoursInput _hours = widget.initial;
  String? _error;

  void _save() {
    final message = _hours.validate();
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    Navigator.of(context).pop(_hours);
  }

  @override
  Widget build(BuildContext context) => SheetShell(
        title: 'Opening hours',
        subtitle: 'A day that is off takes no bookings at all',
        error: _error,
        primaryLabel: 'Save hours',
        onPrimary: _save,
        children: [
          WeekHoursEditor(
            hours: _hours,
            onChanged: (next) => setState(() => _hours = next),
          ),
        ],
      );
}
