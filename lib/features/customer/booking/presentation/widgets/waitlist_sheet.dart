import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/time/app_time.dart';
import '../../../../../core/widgets/async_view.dart';
import '../../../venues/domain/public_venue.dart';
import '../../../wallet/application/reschedule_controller.dart';
import '../../application/book_controller.dart';
import '../../domain/availability.dart';

/// C5 · Waitlist sheet. Opened by tapping a taken slot: the venue tells the
/// customer if it frees up, which is the only thing that can be done with a
/// slot the exclusion constraint has already given away.
Future<void> showWaitlistSheet(
  BuildContext context, {
  required PublicVenue venue,
  required VenueSpace space,
  required Slot slot,
}) =>
    showModalBottomSheet<void>(
      context: context,
      // On the root navigator, or the shell's bottom nav sits on top of it.
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: _WaitlistSheet(venue: venue, space: space, slot: slot),
      ),
    );

class _WaitlistSheet extends ConsumerStatefulWidget {
  const _WaitlistSheet({required this.venue, required this.space, required this.slot});

  final PublicVenue venue;
  final VenueSpace space;
  final Slot slot;

  @override
  ConsumerState<_WaitlistSheet> createState() => _WaitlistSheetState();
}

class _WaitlistSheetState extends ConsumerState<_WaitlistSheet> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  bool _busy = false;
  bool _prefilled = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_name.text.trim().isEmpty || _email.text.trim().isEmpty) {
      setState(() => _error = 'We need a name and an email to tell you.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(waitlistControllerProvider.notifier).join(
            venueSlug: widget.venue.slug,
            spaceId: widget.space.id,
            startsAt: widget.slot.startsAt,
            endsAt: widget.slot.endsAt,
            name: _name.text,
            email: _email.text,
            phone: _phone.text.isEmpty ? null : _phone.text,
          );
      await ref.read(savedContactProvider.notifier).save(
            Contact(name: _name.text, email: _email.text, phone: _phone.text),
          );
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You're on the waitlist for that slot.")),
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
    final zone = widget.venue.timezone;

    // Prefill from the contact this phone remembers.
    ref.listen(savedContactProvider, (_, next) {
      final contact = next.value;
      if (contact == null || _prefilled) return;
      _prefilled = true;
      _name.text = contact.name;
      _email.text = contact.email;
      _phone.text = contact.phone;
    });
    final saved = ref.watch(savedContactProvider).value;
    if (saved != null && !_prefilled) {
      _prefilled = true;
      _name.text = saved.name;
      _email.text = saved.email;
      _phone.text = saved.phone;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Spacing.gutter,
          0,
          Spacing.gutter,
          Spacing.gutter,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Join the waitlist',
              style: AppType.displayAt(22).copyWith(color: p.ink),
            ),
            const SizedBox(height: 4),
            Text(
              '${AppTime.formatWhen(widget.slot.startsAt, widget.slot.endsAt, zone)} · ${widget.space.name}',
              style: AppType.bodyS.copyWith(color: p.ink2),
            ),
            const SizedBox(height: Spacing.x4),
            TextField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: Spacing.x3),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: Spacing.x3),
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Mobile — optional'),
            ),
            if (_error != null) ...[
              const SizedBox(height: Spacing.x3),
              Text(_error!, style: AppType.bodyS.copyWith(color: p.danger)),
            ],
            const SizedBox(height: Spacing.x3),
            Text(
              'If it frees up we send you a link; you have 30 minutes to claim it.',
              style: AppType.caption.copyWith(color: p.ink3),
            ),
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
                  : const Text('Notify me if it frees up'),
            ),
          ],
        ),
      ),
    );
  }
}
