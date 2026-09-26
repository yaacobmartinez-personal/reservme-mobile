import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/money/money.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/customers_controller.dart';
import '../domain/customer.dart';
import '../domain/customers_repository.dart';
import 'widgets/customer_avatar.dart';
import 'widgets/tag_editor.dart';

/// V11 · Customer detail — who they are, what the venue has learned about
/// them, and every booking they have made.
class CustomerDetailScreen extends ConsumerWidget {
  const CustomerDetailScreen({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(selectedVenueProvider);
    if (venue == null) {
      return const Scaffold(
        body: EmptyState(
          icon: Icons.storefront_outlined,
          title: 'No venue selected',
          hint: 'Pick a venue first.',
        ),
      );
    }

    final profile = ref.watch(customerDetailProvider(venue.slug, customerId));

    return Scaffold(
      appBar: AppBar(title: const Text('Customer')),
      body: AsyncView(
        value: profile,
        onRetry: () =>
            ref.invalidate(customerDetailProvider(venue.slug, customerId)),
        data: (p) => _Body(
          profile: p,
          venueSlug: venue.slug,
          currency: venue.currency,
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    required this.profile,
    required this.venueSlug,
    required this.currency,
  });

  final CustomerProfile profile;
  final String venueSlug;
  final String currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final c = profile.customer;
    final notifier =
        ref.read(customerDetailProvider(venueSlug, c.id).notifier);

    return RefreshIndicator(
      onRefresh: () async =>
          ref.refresh(customerDetailProvider(venueSlug, c.id).future),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          Spacing.gutter,
          0,
          Spacing.gutter,
          Spacing.x8,
        ),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerAvatar(customer: c, size: 64),
              const SizedBox(width: Spacing.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name, style: AppType.displayAt(28).copyWith(color: p.ink)),
                    const SizedBox(height: 2),
                    Text(c.email, style: AppType.bodyS.copyWith(color: p.ink2)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _editContact(context, notifier, c),
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Edit contact',
              ),
            ],
          ),
          const SizedBox(height: Spacing.x3),
          TagEditor(
            tags: c.tags,
            onChanged: (tags) => _guarded(context, () => notifier.setTags(tags)),
          ),
          const SizedBox(height: Spacing.x4),
          Row(
            children: [
              if ((c.phone ?? '').isNotEmpty) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => launchUrl(Uri(scheme: 'tel', path: c.phone)),
                    icon: const Icon(Icons.phone_outlined, size: 18),
                    label: const Text('Call'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      foregroundColor: p.pineInk,
                    ),
                  ),
                ),
                const SizedBox(width: Spacing.x2),
              ],
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => launchUrl(Uri(scheme: 'mailto', path: c.email)),
                  icon: const Icon(Icons.mail_outline_rounded, size: 18),
                  label: const Text('Email'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.x4),
          Row(
            children: [
              Expanded(child: KpiTile(value: '${c.bookings}', label: 'Visits')),
              const SizedBox(width: Spacing.x2),
              Expanded(
                child: KpiTile(value: '${c.noShowCount}', label: 'No-shows'),
              ),
              const SizedBox(width: Spacing.x2),
              Expanded(
                child: KpiTile(
                  value: Money.compact(c.lifetimeValueCents, currency: currency),
                  label: 'Lifetime',
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.x5),

          Row(
            children: [
              const Expanded(child: Eyebrow('Notes')),
              TextButton(
                onPressed: () => _addNote(context, notifier),
                child: const Text('Add note'),
              ),
            ],
          ),
          const SizedBox(height: Spacing.x2),
          if (profile.notes.isEmpty)
            Text(
              'Nothing noted yet. Anything the desk should remember — a court '
              'they prefer, a standing arrangement — goes here.',
              style: AppType.bodyS.copyWith(color: p.ink3),
            )
          else
            for (final note in profile.notes) ...[
              _NoteCard(
                note: note,
                onDelete: () async {
                  final ok = await showConfirmDialog(
                    context,
                    title: 'Delete this note?',
                    message: 'It is only visible to your team, and it goes for good.',
                    confirmLabel: 'Delete',
                    cancelLabel: 'Keep it',
                    destructive: true,
                  );
                  if (!ok || !context.mounted) return;
                  await _guarded(context, () => notifier.deleteNote(note.id));
                },
              ),
              const SizedBox(height: Spacing.x2),
            ],

          const SizedBox(height: Spacing.x4),
          const Eyebrow('Bookings'),
          const SizedBox(height: Spacing.x2),
          if (profile.upcoming.isEmpty && profile.past.isEmpty)
            Text(
              'No bookings yet.',
              style: AppType.bodyS.copyWith(color: p.ink3),
            ),
          for (final booking in [...profile.upcoming, ...profile.past]) ...[
            _BookingRow(booking: booking, currency: currency),
            const SizedBox(height: Spacing.x2),
          ],
        ],
      ),
    );
  }

  Future<void> _addNote(BuildContext context, CustomerDetail notifier) async {
    // The refusal is shown *inside* the dialog and the dialog stays open:
    // closing first and complaining afterwards throws away what was typed.
    final body = await showDialog<String>(
      context: context,
      builder: (context) => _TextPrompt(
        title: 'Add a note',
        hint: 'Prefers Court 3 — says the lighting is better.',
        maxLength: 2000,
        maxLines: 4,
        confirm: 'Save',
        validate: NoteRules.validate,
      ),
    );
    if (body == null || !context.mounted) return;
    await _guarded(context, () => notifier.addNote(body));
  }

  /// The name and phone the desk can correct (#22). Email is not editable — it
  /// is the `(venue, email)` key the booking engine matches returning
  /// customers on, so changing it would split one person into two.
  Future<void> _editContact(
    BuildContext context,
    CustomerDetail notifier,
    CustomerSummary customer,
  ) async {
    final name = TextEditingController(text: customer.name);
    final phone = TextEditingController(text: customer.phone ?? '');
    // Declared out here on purpose: a local inside the builder is recreated on
    // every rebuild, so the refusal would be set and immediately forgotten.
    String? error;
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          void submit() {
            final message = ContactRules.validate(
              name: name.text,
              phone: phone.text,
            );
            if (message != null) {
              setState(() => error = message);
              return;
            }
            Navigator.of(context).pop(true);
          }

          return AlertDialog(
            title: const Text('Edit contact'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  autofocus: true,
                  maxLength: 120,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    errorText: error,
                  ),
                ),
                TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  maxLength: 40,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(height: Spacing.x2),
                Text(
                  '${customer.email} — the address bookings are matched on, '
                  'and not editable.',
                  style: AppType.caption,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              FilledButton(onPressed: submit, child: const Text('Save')),
            ],
          );
        },
      ),
    );
    if (saved != true || !context.mounted) return;

    await _guarded(
      context,
      () => notifier.updateContact(name: name.text, phone: phone.text),
    );
  }

  /// Runs a write and shows the server's message if it refuses.
  Future<void> _guarded(BuildContext context, Future<void> Function() run) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await run();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note, required this.onDelete});

  final CustomerNote note;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(note.body, style: AppType.body.copyWith(color: p.ink)),
          const SizedBox(height: Spacing.x2),
          Row(
            children: [
              Expanded(
                child: Text(
                  [
                    if ((note.authorName ?? '').isNotEmpty) note.authorName!,
                    '${note.createdAt.day}/${note.createdAt.month}',
                  ].join(' · '),
                  style: AppType.caption.copyWith(color: p.ink3),
                ),
              ),
              IconButton(
                onPressed: onDelete,
                tooltip: 'Delete note',
                visualDensity: VisualDensity.compact,
                icon: Icon(Icons.delete_outline_rounded, size: 18, color: p.ink3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BookingRow extends StatelessWidget {
  const _BookingRow({required this.booking, required this.currency});

  final CustomerBooking booking;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.whenLabel,
                  style: AppType.bodyStrong.copyWith(color: p.ink),
                ),
                const SizedBox(height: 2),
                Text(
                  '${booking.spaceName} · '
                  '${Money.format(booking.amountCents, currency: currency)} · '
                  '${booking.reference}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.bodyS.copyWith(color: p.ink2),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.x2),
          StatusChip.status(booking.status, checkedInAt: booking.checkedInAt),
        ],
      ),
    );
  }
}

/// A one-field dialog that refuses without closing, so a rejected value can be
/// corrected rather than retyped.
class _TextPrompt extends StatefulWidget {
  const _TextPrompt({
    required this.title,
    required this.hint,
    required this.confirm,
    required this.validate,
    this.maxLength,
    this.maxLines = 1,
  });

  final String title;
  final String hint;
  final String confirm;
  final String? Function(String value) validate;
  final int? maxLength;
  final int maxLines;

  @override
  State<_TextPrompt> createState() => _TextPromptState();
}

class _TextPromptState extends State<_TextPrompt> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final message = widget.validate(_controller.text);
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    Navigator.of(context).pop(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        decoration: InputDecoration(hintText: widget.hint, errorText: _error),
        onChanged: (_) {
          if (_error != null) setState(() => _error = null);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: Text(widget.confirm)),
      ],
    );
  }
}
