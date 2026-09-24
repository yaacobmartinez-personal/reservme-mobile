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
import '../../domain/manual_booking_input.dart';

/// V9 · Block off time. A block stops *new* bookings; it does not cancel the
/// ones already in the window, which is why an overlap is a warning and not a
/// refusal — the desk is told, and decides.
Future<void> showBlockSheet(
  BuildContext context, {
  required String venueSlug,
  required String timezone,
  required String date,
  required List<CalendarLane> lanes,
}) =>
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _BlockSheet(
          venueSlug: venueSlug,
          timezone: timezone,
          date: date,
          lanes: lanes,
        ),
      ),
    );

class _BlockSheet extends ConsumerStatefulWidget {
  const _BlockSheet({
    required this.venueSlug,
    required this.timezone,
    required this.date,
    required this.lanes,
  });

  final String venueSlug;
  final String timezone;
  final String date;
  final List<CalendarLane> lanes;

  @override
  ConsumerState<_BlockSheet> createState() => _BlockSheetState();
}

const _wholeVenue = '__venue__';

class _BlockSheetState extends ConsumerState<_BlockSheet> {
  String _spaceId = _wholeVenue;
  String _from = '18:00';
  String _to = '20:00';
  final _reason = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _spaceId = widget.lanes.isEmpty ? _wholeVenue : widget.lanes.first.spaceId;
  }

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  BlockInput get _input => BlockInput(
        spaceId: _spaceId == _wholeVenue ? null : _spaceId,
        date: widget.date,
        from: _from,
        to: _to,
        reason: _reason.text,
      );

  /// Bookings already sitting inside the window. The server lets the block
  /// through; the desk should still know.
  List<CalendarItem> get _overlaps {
    final from = AppTime.minutesOfDay(_from);
    final to = AppTime.minutesOfDay(_to);
    if (from == null || to == null) return const [];
    final lanes = _spaceId == _wholeVenue
        ? widget.lanes
        : widget.lanes.where((l) => l.spaceId == _spaceId);
    return [
      for (final lane in lanes)
        for (final item in lane.items)
          if (item.isBooking)
            if (_minutes(item.startsAt) < to && _minutes(item.endsAt) > from) item,
    ];
  }

  int _minutes(DateTime instant) =>
      AppTime.minutesOfDay(AppTime.formatTime(instant, widget.timezone)) ?? 0;

  Future<void> _submit() async {
    final message = _input.validate();
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(calendarCommandsProvider.notifier).block(widget.venueSlug, _input);
      if (!mounted) return;
      Navigator.of(context).pop();
      messenger.showSnackBar(
        SnackBar(content: Text('Blocked $_from–$_to. Nothing new can be booked.')),
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
    final overlaps = _overlaps;
    final where = _spaceId == _wholeVenue
        ? 'the whole venue'
        : widget.lanes
            .firstWhere((l) => l.spaceId == _spaceId,
                orElse: () => widget.lanes.first)
            .spaceName;

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
            Text('Block off time', style: AppType.displayAt(26).copyWith(color: p.ink)),
            const SizedBox(height: 2),
            Text(
              'Nothing can be booked while blocked',
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
                const DropdownMenuItem(
                  value: _wholeVenue,
                  child: Text('The whole venue'),
                ),
              ],
              onChanged: (v) => setState(() => _spaceId = v ?? _spaceId),
            ),
            const SizedBox(height: Spacing.x3),
            Row(
              children: [
                Expanded(
                  child: TimeField(
                    label: 'From',
                    value: _from,
                    onChanged: (v) => setState(() {
                      // Keep the window's length when the start moves, so a
                      // two-hour block stays two hours.
                      final was = AppTime.minutesOfDay(_from);
                      final end = AppTime.minutesOfDay(_to);
                      final now = AppTime.minutesOfDay(v);
                      _from = v;
                      if (was != null && end != null && now != null && end > was) {
                        _to = AppTime.addMinutesToTime(v, end - was);
                      }
                    }),
                  ),
                ),
                const SizedBox(width: Spacing.x3),
                Expanded(
                  child: TimeField(
                    label: 'To',
                    value: _to,
                    onChanged: (v) => setState(() => _to = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.x3),
            Text('Reason', style: AppType.caption.copyWith(color: p.ink3)),
            const SizedBox(height: 6),
            TextField(
              controller: _reason,
              decoration: const InputDecoration(hintText: 'Net repair'),
            ),
            if (overlaps.isNotEmpty) ...[
              const SizedBox(height: Spacing.x3),
              AppBanner(
                kind: BannerKind.warn,
                title: overlaps.length == 1
                    ? '1 booking overlaps'
                    : '${overlaps.length} bookings overlap',
                body: '${overlaps.map((o) => '${o.title} · '
                    '${AppTime.formatTime(o.startsAt, widget.timezone)}').join(', ')}. '
                    'Blocking does not cancel them — move or cancel first.',
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: Spacing.x3),
              AppBanner(kind: BannerKind.error, title: _error!),
            ],
            const SizedBox(height: Spacing.x4),
            FilledButton(
              onPressed: _busy ? null : _submit,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                backgroundColor: p.claySoft,
                foregroundColor: p.clayInk,
              ),
              child: _busy
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Block $where, $_from–$_to'),
            ),
          ],
        ),
      ),
    );
  }
}
