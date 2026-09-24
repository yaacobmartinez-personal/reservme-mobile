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
    final controller = TextEditingController();
    final body = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a note'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 4,
          maxLength: 2000,
          decoration: const InputDecoration(
            hintText: 'Prefers Court 3 — says the lighting is better.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (body == null || !context.mounted) return;

    final message = NoteRules.validate(body);
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      return;
    }
    await _guarded(context, () => notifier.addNote(body));
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
