import 'package:flutter/material.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/time/app_time.dart';
import '../../../../../core/widgets/wall_clock_field.dart';
import '../../domain/space_input.dart';
import 'sheet_shell.dart';

/// G1 · a closure, ported from `addClosure`. Venue-local wall clock in and
/// out — the server builds the instant in the venue's own zone, which is why
/// nothing here ever touches a `DateTime`.
///
/// A closure can shut this space or the whole venue; either way it stops new
/// bookings and leaves the ones already inside it alone.
Future<ClosureInput?> showClosureSheet(
  BuildContext context, {
  required String spaceId,
  required String spaceName,
  required String timezone,
}) =>
    showModalBottomSheet<ClosureInput>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _ClosureSheet(
          spaceId: spaceId,
          spaceName: spaceName,
          timezone: timezone,
        ),
      ),
    );

class _ClosureSheet extends StatefulWidget {
  const _ClosureSheet({
    required this.spaceId,
    required this.spaceName,
    required this.timezone,
  });

  final String spaceId;
  final String spaceName;
  final String timezone;

  @override
  State<_ClosureSheet> createState() => _ClosureSheetState();
}

class _ClosureSheetState extends State<_ClosureSheet> {
  late ClosureInput _input;
  final _reason = TextEditingController();
  bool _wholeVenue = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final today = AppTime.today(DateTime.now().toUtc(), widget.timezone);
    _input = ClosureInput(
      spaceId: widget.spaceId,
      fromDate: today,
      fromTime: '09:00',
      toDate: today,
      toTime: '18:00',
    );
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  void _save() {
    final input = _input.copyWith(
      reason: _reason.text,
      spaceId: _wholeVenue ? null : widget.spaceId,
      clearSpace: _wholeVenue,
    );
    final message = input.validate();
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    Navigator.of(context).pop(input);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return SheetShell(
      title: 'Close for a while',
      subtitle: 'Nothing new can be booked in the window',
      error: _error,
      primaryLabel: 'Add closure',
      onPrimary: _save,
      children: [
        Row(
          children: [
            Expanded(
              child: DateField(
                label: 'From',
                value: _input.fromDate,
                timezone: widget.timezone,
                onChanged: (v) => setState(() {
                  _input = _input.copyWith(fromDate: v);
                  // An end before the start is the common slip when the date
                  // moves forward; drag it along rather than refusing.
                  if (_input.toDate.compareTo(v) < 0) {
                    _input = _input.copyWith(toDate: v);
                  }
                }),
              ),
            ),
            const SizedBox(width: Spacing.x3),
            Expanded(
              child: TimeField(
                label: '',
                value: _input.fromTime,
                onChanged: (v) => setState(() => _input = _input.copyWith(fromTime: v)),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        Row(
          children: [
            Expanded(
              child: DateField(
                label: 'To',
                value: _input.toDate,
                timezone: widget.timezone,
                onChanged: (v) => setState(() => _input = _input.copyWith(toDate: v)),
              ),
            ),
            const SizedBox(width: Spacing.x3),
            Expanded(
              child: TimeField(
                label: '',
                value: _input.toTime,
                onChanged: (v) => setState(() => _input = _input.copyWith(toTime: v)),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _reason,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Reason',
            hintText: 'Resurfacing',
          ),
        ),
        const SizedBox(height: Spacing.x2),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _wholeVenue,
          onChanged: (v) => setState(() => _wholeVenue = v),
          title: const Text('Close the whole venue'),
          subtitle: Text(
            _wholeVenue
                ? 'Every space, not just ${widget.spaceName}.'
                : 'Only ${widget.spaceName}.',
            style: AppType.bodyS.copyWith(color: p.ink3),
          ),
        ),
      ],
    );
  }
}
