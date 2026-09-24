import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/time/app_time.dart';
import '../../../../../core/ui/app_banner.dart';
import '../../../../../core/widgets/async_view.dart';
import '../../../../../core/widgets/wall_clock_field.dart';
import '../../application/calendar_commands.dart';
import '../../domain/calendar_day.dart';

/// Move a booking to another space and/or time. The length comes with it and
/// the destination reprices it — the same rules the engine applies, so a move
/// onto a taken slot is refused rather than forced.
Future<void> showMoveBookingSheet(
  BuildContext context, {
  required String venueSlug,
  required String timezone,
  required String fromDate,
  required CalendarItem item,
  required List<CalendarLane> lanes,
}) =>
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _MoveSheet(
          venueSlug: venueSlug,
          timezone: timezone,
          fromDate: fromDate,
          item: item,
          lanes: lanes,
        ),
      ),
    );

class _MoveSheet extends ConsumerStatefulWidget {
  const _MoveSheet({
    required this.venueSlug,
    required this.timezone,
    required this.fromDate,
    required this.item,
    required this.lanes,
  });

  final String venueSlug;
  final String timezone;
  final String fromDate;
  final CalendarItem item;
  final List<CalendarLane> lanes;

  @override
  ConsumerState<_MoveSheet> createState() => _MoveSheetState();
}

class _MoveSheetState extends ConsumerState<_MoveSheet> {
  late String _spaceId;
  late String _date;
  late String _time;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _spaceId = widget.lanes.first.spaceId;
    _date = widget.fromDate;
    _time = AppTime.formatTime(widget.item.startsAt, widget.timezone);
  }

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final messenger = ScaffoldMessenger.of(context);
    try {
      final moved = await ref.read(calendarCommandsProvider.notifier).move(
            widget.venueSlug,
            widget.item.id,
            spaceId: _spaceId,
            fromDate: widget.fromDate,
            date: _date,
            time: _time,
          );
      if (!mounted) return;
      Navigator.of(context).pop();
      messenger.showSnackBar(
        SnackBar(content: Text('Moved to ${moved.spaceName} · ${moved.label}.')),
      );
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
    final hours = widget.item.durationMinutes / 60;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          Spacing.gutter,
          0,
          Spacing.gutter,
          Spacing.x4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Move booking', style: AppType.displayAt(26).copyWith(color: p.ink)),
            const SizedBox(height: 2),
            Text(
              '${widget.item.title} · ${widget.item.label} · '
              '${hours == hours.roundToDouble() ? hours.round() : hours} h',
              style: AppType.bodyS.copyWith(color: p.ink3),
            ),
            const SizedBox(height: Spacing.x4),
            Text('Space', style: AppType.caption.copyWith(color: p.ink3)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _spaceId,
              isExpanded: true,
              items: [
                for (final lane in widget.lanes)
                  DropdownMenuItem(
                    value: lane.spaceId,
                    child: Text(lane.spaceName, overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: (v) => setState(() => _spaceId = v ?? _spaceId),
            ),
            const SizedBox(height: Spacing.x3),
            Row(
              children: [
                Expanded(
                  child: DateField(
                    label: 'Date',
                    value: _date,
                    timezone: widget.timezone,
                    onChanged: (v) => setState(() => _date = v),
                  ),
                ),
                const SizedBox(width: Spacing.x3),
                Expanded(
                  child: TimeField(
                    label: 'Time',
                    value: _time,
                    onChanged: (v) => setState(() => _time = v),
                  ),
                ),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: Spacing.x3),
              AppBanner(kind: BannerKind.error, title: _error!),
            ],
            const SizedBox(height: Spacing.x4),
            FilledButton(
              onPressed: _busy ? null : _submit,
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
              child: _busy
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Move it'),
            ),
          ],
        ),
      ),
    );
  }
}
