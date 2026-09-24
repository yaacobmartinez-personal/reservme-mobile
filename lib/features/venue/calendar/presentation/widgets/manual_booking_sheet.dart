import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/time/app_time.dart';
import '../../../../../core/ui/app_banner.dart';
import '../../../../../core/widgets/async_view.dart';
import '../../application/calendar_commands.dart';
import '../../domain/calendar_day.dart';
import '../../domain/calendar_repository.dart';
import '../../domain/manual_booking_input.dart';

/// V8 · New booking. Staff path: notice and horizon are relaxed, so the desk
/// can take a booking for ten minutes from now — but the physical rules still
/// apply, and the sheet shows the server's refusal when one bites.
Future<void> showManualBookingSheet(
  BuildContext context, {
  required String venueSlug,
  required String timezone,
  required String currency,
  required String date,
  required List<CalendarLane> lanes,
  String? spaceId,
  String? time,
}) =>
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _ManualBookingSheet(
          venueSlug: venueSlug,
          timezone: timezone,
          currency: currency,
          date: date,
          lanes: lanes,
          spaceId: spaceId,
          time: time,
        ),
      ),
    );

class _ManualBookingSheet extends ConsumerStatefulWidget {
  const _ManualBookingSheet({
    required this.venueSlug,
    required this.timezone,
    required this.currency,
    required this.date,
    required this.lanes,
    this.spaceId,
    this.time,
  });

  final String venueSlug;
  final String timezone;
  final String currency;
  final String date;
  final List<CalendarLane> lanes;
  final String? spaceId;
  final String? time;

  @override
  ConsumerState<_ManualBookingSheet> createState() => _ManualBookingSheetState();
}

class _ManualBookingSheetState extends ConsumerState<_ManualBookingSheet> {
  late String _spaceId;
  late String _time;
  int _slots = 1;
  int _party = 1;

  final _search = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();

  CustomerHit? _picked;
  bool _newCustomer = false;
  bool _busy = false;
  String? _error;
  Timer? _debounce;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _spaceId = widget.spaceId ?? widget.lanes.first.spaceId;
    _time = widget.time ?? '18:00';
    _search.addListener(() {
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 250), () {
        if (mounted) setState(() => _query = _search.text.trim());
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  CalendarLane get _lane =>
      widget.lanes.firstWhere((l) => l.spaceId == _spaceId, orElse: () => widget.lanes.first);

  ManualBookingInput get _input => ManualBookingInput(
        spaceId: _spaceId,
        date: widget.date,
        time: _time,
        slotCount: _slots,
        partySize: _party,
        customerId: _picked?.id,
        name: _newCustomer ? _name.text : null,
        email: _newCustomer ? _email.text : null,
        phone: _newCustomer ? _phone.text : null,
      );

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
      final booking = await ref
          .read(calendarCommandsProvider.notifier)
          .createBooking(widget.venueSlug, _input);
      if (!mounted) return;
      Navigator.of(context).pop();
      messenger.showSnackBar(
        SnackBar(content: Text('Booked ${booking.spaceName} · ${booking.label}.')),
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
    final start = AppTime.startOfLocalDay(widget.date, widget.timezone);
    final dayLabel = start == null ? widget.date : AppTime.formatDay(start, widget.timezone);

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
            Text('New booking', style: AppType.displayAt(26).copyWith(color: p.ink)),
            const SizedBox(height: 2),
            Text(
              '$dayLabel · staff booking',
              style: AppType.bodyS.copyWith(color: p.ink3),
            ),
            const SizedBox(height: Spacing.x4),

            Row(
              children: [
                Expanded(
                  child: _Field(
                    label: 'Space',
                    child: DropdownButtonFormField<String>(
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
                  ),
                ),
                const SizedBox(width: Spacing.x3),
                Expanded(
                  child: _Field(
                    label: 'Time',
                    child: TextFormField(
                      initialValue: _time,
                      keyboardType: TextInputType.datetime,
                      onChanged: (v) => _time = v.trim(),
                      decoration: const InputDecoration(hintText: 'HH:MM'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.x3),

            Row(
              children: [
                Expanded(
                  child: _Stepper(
                    label: 'Slots',
                    value: _slots,
                    min: 1,
                    max: 24,
                    onChanged: (v) => setState(() => _slots = v),
                  ),
                ),
                const SizedBox(width: Spacing.x3),
                Expanded(
                  child: _Stepper(
                    label: 'Players',
                    value: _party,
                    min: 1,
                    max: 500,
                    onChanged: (v) => setState(() => _party = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.x4),

            if (!_newCustomer) ...[
              TextField(
                controller: _search,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: 'Find a customer',
                ),
              ),
              const SizedBox(height: Spacing.x2),
              if (_query.isNotEmpty) _Results(
                venueSlug: widget.venueSlug,
                query: _query,
                picked: _picked,
                onPick: (hit) => setState(() {
                  _picked = identical(_picked, hit) ? null : hit;
                }),
              ),
              const SizedBox(height: Spacing.x2),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('Walk-in? ', style: AppType.bodyS.copyWith(color: p.ink2)),
                  GestureDetector(
                    onTap: () => setState(() {
                      _newCustomer = true;
                      _picked = null;
                    }),
                    child: Text(
                      'Add a new customer',
                      style: AppType.bodyS.copyWith(
                        color: p.pineInk,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    ' · notice and horizon rules are relaxed for staff',
                    style: AppType.bodyS.copyWith(color: p.ink3),
                  ),
                ],
              ),
            ] else ...[
              _Field(
                label: 'Name',
                child: TextField(controller: _name),
              ),
              const SizedBox(height: Spacing.x3),
              _Field(
                label: 'Email',
                child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                ),
              ),
              const SizedBox(height: Spacing.x3),
              _Field(
                label: 'Phone (optional)',
                child: TextField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: Spacing.x2),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => setState(() => _newCustomer = false),
                  child: const Text('Pick an existing customer instead'),
                ),
              ),
            ],

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
                  : Text(
                      'Book ${_lane.spaceName} · $_time'
                      '${_slots > 1 ? ' · $_slots slots' : ''}',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Results extends ConsumerWidget {
  const _Results({
    required this.venueSlug,
    required this.query,
    required this.picked,
    required this.onPick,
  });

  final String venueSlug;
  final String query;
  final CustomerHit? picked;
  final ValueChanged<CustomerHit> onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final hits = ref.watch(customerSearchProvider(venueSlug, query));

    return hits.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(Spacing.x3),
        child: Center(child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        )),
      ),
      error: (e, _) => Text(
        AsyncView.messageFor(e),
        style: AppType.bodyS.copyWith(color: p.danger),
      ),
      data: (rows) => rows.isEmpty
          ? Text(
              'Nobody matches "$query".',
              style: AppType.bodyS.copyWith(color: p.ink3),
            )
          : Column(
              children: [
                for (final hit in rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: Spacing.x2),
                    child: Material(
                      color: picked?.id == hit.id ? p.pineSoft : p.card,
                      borderRadius: BorderRadius.circular(Radii.md),
                      child: InkWell(
                        onTap: () => onPick(hit),
                        borderRadius: BorderRadius.circular(Radii.md),
                        child: Ink(
                          padding: const EdgeInsets.all(Spacing.x3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Radii.md),
                            border: Border.all(
                              color: picked?.id == hit.id ? p.pineLine : p.rule,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hit.name,
                                      style: AppType.bodyStrong.copyWith(color: p.ink),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      [
                                        if ((hit.phone ?? '').isNotEmpty) hit.phone!,
                                        if (hit.visits > 0) '${hit.visits} visits',
                                      ].join(' · '),
                                      style: AppType.caption.copyWith(color: p.ink3),
                                    ),
                                  ],
                                ),
                              ),
                              if (picked?.id == hit.id)
                                Icon(Icons.check_rounded, color: p.pine),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppType.caption.copyWith(color: p.ink3)),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.x3),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(Radii.md),
        border: Border.all(color: p.rule),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppType.bodyS.copyWith(color: p.ink2),
            ),
          ),
          IconButton(
            onPressed: value > min ? () => onChanged(value - 1) : null,
            icon: const Icon(Icons.remove_rounded, size: 18),
            tooltip: 'Fewer',
            visualDensity: VisualDensity.compact,
          ),
          Text('$value', style: AppType.bodyStrong.copyWith(color: p.ink)),
          IconButton(
            onPressed: value < max ? () => onChanged(value + 1) : null,
            icon: const Icon(Icons.add_rounded, size: 18),
            tooltip: 'More',
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
