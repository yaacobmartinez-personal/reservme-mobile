import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/money/money.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/kind_placeholder.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/space_editor_controller.dart';
import '../application/spaces_controller.dart';
import '../domain/space_detail.dart';
import '../domain/space_input.dart';
import 'widgets/basics_sheet.dart';
import 'widgets/closure_sheet.dart';
import 'widgets/hours_sheet.dart';
import 'widgets/pricing_rule_sheet.dart';

/// G1 · Space editor. One screen per space: the photo, the basics, the week,
/// peak pricing, closures, and the sessions it runs.
///
/// Sessions are read-only in v1 (D17) — the card explains them rather than
/// offering create/cancel, which is parked with memberships and promos.
class SpaceEditorScreen extends ConsumerWidget {
  const SpaceEditorScreen({super.key, required this.spaceId});

  final String spaceId;

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

    final provider = spaceEditorProvider(venue.slug, spaceId);
    final space = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        title: Text(space.value?.name ?? 'Space'),
      ),
      body: AsyncView(
        value: space,
        onRetry: () => ref.invalidate(provider),
        data: (detail) => RefreshIndicator(
          onRefresh: () async => ref.refresh(provider.future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              Spacing.gutter,
              0,
              Spacing.gutter,
              Spacing.x8,
            ),
            children: [
              _Photo(detail: detail, venueSlug: venue.slug),
              const SizedBox(height: Spacing.x3),
              if (!detail.isActive)
                const Padding(
                  padding: EdgeInsets.only(bottom: Spacing.x3),
                  child: AppBanner(
                    kind: BannerKind.warn,
                    title: 'This space is paused',
                    body: 'It takes no new bookings, and it does not count '
                        'towards your billing band.',
                  ),
                ),
              if (detail.isUnbookable)
                const Padding(
                  padding: EdgeInsets.only(bottom: Spacing.x3),
                  child: AppBanner(
                    kind: BannerKind.warn,
                    title: 'Nobody can book this space',
                    body: 'It is on sale but closed every day of the week. '
                        'Open at least one day below.',
                  ),
                ),
              _Basics(detail: detail, venueSlug: venue.slug, currency: venue.currency),
              const SizedBox(height: Spacing.x3),
              _Hours(detail: detail, venueSlug: venue.slug),
              const SizedBox(height: Spacing.x3),
              _Pricing(detail: detail, venueSlug: venue.slug, currency: venue.currency),
              const SizedBox(height: Spacing.x3),
              _Closures(
                detail: detail,
                venueSlug: venue.slug,
                timezone: venue.timezone,
              ),
              const SizedBox(height: Spacing.x3),
              _Sessions(detail: detail, timezone: venue.timezone),
              const SizedBox(height: Spacing.x5),
              _Danger(detail: detail, venueSlug: venue.slug),
            ],
          ),
        ),
      ),
    );
  }
}

/// Section scaffolding: a titled card with an optional trailing action, used
/// by every block below so they line up.
class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.child,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final Widget child;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppType.captionStrong.copyWith(color: p.ink3),
                ),
              ),
              if (actionLabel != null)
                TextButton(
                  onPressed: onAction,
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.x2),
                  ),
                  child: Text(actionLabel!),
                ),
            ],
          ),
          const SizedBox(height: Spacing.x2),
          child,
        ],
      ),
    );
  }
}

class _Photo extends ConsumerWidget {
  const _Photo({required this.detail, required this.venueSlug});

  final SpaceDetail detail;
  final String venueSlug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier =
        ref.read(spaceEditorProvider(venueSlug, detail.id).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Radii.card),
          child: SizedBox(
            height: 180,
            child: detail.imageUrl == null
                ? KindPlaceholder(kind: detail.kind, width: double.infinity, height: 180, radius: Radii.card)
                : Image.network(
                    detail.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        KindPlaceholder(kind: detail.kind, width: double.infinity, height: 180, radius: Radii.card),
                  ),
          ),
        ),
        const SizedBox(height: Spacing.x2),
        Row(
          children: [
            // The picker itself lands with the rest of the image pipeline;
            // until then the editor is honest about what it can do rather
            // than showing a button that does nothing.
            Expanded(
              child: Text(
                detail.imageUrl == null
                    ? 'Spaces with a photo get booked more.'
                    : 'Shown on your booking page.',
                style: AppType.bodyS.copyWith(color: context.palette.ink3),
              ),
            ),
            if (detail.imageUrl != null)
              TextButton(
                onPressed: () => _remove(context, notifier),
                child: const Text('Remove'),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _remove(BuildContext context, SpaceEditor notifier) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Remove this photo?',
      message: 'The space will show its kind placeholder instead.',
      confirmLabel: 'Remove',
      cancelLabel: 'Keep it',
      destructive: true,
    );
    if (!ok || !context.mounted) return;
    await _run(context, () => notifier.setPhoto(null));
  }
}

class _Basics extends ConsumerWidget {
  const _Basics({
    required this.detail,
    required this.venueSlug,
    required this.currency,
  });

  final SpaceDetail detail;
  final String venueSlug;
  final String currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final facts = <(String, String)>[
      ('Kind', detail.kind.label),
      ('Slot', '${detail.slotMinutes} min'),
      if (detail.bufferMinutes > 0) ('Buffer', '${detail.bufferMinutes} min'),
      ('Capacity', '${detail.capacity}'),
      ('Base price', Money.format(detail.priceCents, currency: currency)),
    ];

    return _Section(
      title: 'BASICS',
      actionLabel: 'Edit',
      onAction: () async {
        final input = await showBasicsSheet(
          context,
          initial: SpaceInput(
            name: detail.name,
            kind: detail.kind,
            capacity: detail.capacity,
            slotMinutes: detail.slotMinutes,
            bufferMinutes: detail.bufferMinutes,
            priceCents: detail.priceCents,
          ),
          currency: currency,
        );
        if (input == null || !context.mounted) return;
        await _run(
          context,
          () => ref
              .read(spaceEditorProvider(venueSlug, detail.id).notifier)
              .saveBasics(input),
        );
      },
      child: Column(
        children: [
          for (final (label, value) in facts)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: AppType.bodyS.copyWith(color: p.ink3),
                    ),
                  ),
                  Text(value, style: AppType.bodyStrong),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Hours extends ConsumerWidget {
  const _Hours({required this.detail, required this.venueSlug});

  final SpaceDetail detail;
  final String venueSlug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final week = detail.week;

    return _Section(
      title: 'OPENING HOURS',
      actionLabel: 'Edit',
      onAction: () async {
        final hours = await showHoursSheet(context, initial: week);
        if (hours == null || !context.mounted) return;
        await _run(
          context,
          () => ref
              .read(spaceEditorProvider(venueSlug, detail.id).notifier)
              .saveHours(hours),
        );
      },
      child: Column(
        children: [
          for (final day in week.weekOrder)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  SizedBox(
                    width: 42,
                    child: Text(
                      day.name,
                      style: AppType.bodyS.copyWith(
                        color: day.open ? p.ink : p.ink3,
                      ),
                    ),
                  ),
                  Text(
                    day.open ? '${day.opensAt} – ${day.closesAt}' : 'Closed',
                    style: day.open
                        ? AppType.bodyStrong
                        : AppType.bodyS.copyWith(color: p.ink3),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Pricing extends ConsumerWidget {
  const _Pricing({
    required this.detail,
    required this.venueSlug,
    required this.currency,
  });

  final SpaceDetail detail;
  final String venueSlug;
  final String currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final notifier =
        ref.read(spaceEditorProvider(venueSlug, detail.id).notifier);

    return _Section(
      title: 'PEAK PRICING',
      actionLabel: 'Add',
      onAction: () async {
        final input = await showPricingRuleSheet(context, currency: currency);
        if (input == null || !context.mounted) return;
        await _run(context, () => notifier.addPricingRule(input));
      },
      child: detail.pricingRules.isEmpty
          ? Text(
              'Every slot is ${Money.format(detail.priceCents, currency: currency)}. '
              'Add a rule to charge more at busy times.',
              style: AppType.bodyS.copyWith(color: p.ink3),
            )
          : Column(
              children: [
                for (final rule in detail.pricingRules)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rule.label ?? 'Peak',
                                style: AppType.bodyStrong,
                              ),
                              Text(
                                '${rule.daysLabel} · ${rule.window}',
                                style: AppType.bodyS.copyWith(color: p.ink3),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          Money.format(rule.priceCents, currency: currency),
                          style: AppType.bodyStrong,
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: 18),
                          tooltip: 'Remove',
                          onPressed: () =>
                              _run(context, () => notifier.removePricingRule(rule.id)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}

class _Closures extends ConsumerWidget {
  const _Closures({
    required this.detail,
    required this.venueSlug,
    required this.timezone,
  });

  final SpaceDetail detail;
  final String venueSlug;
  final String timezone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final notifier =
        ref.read(spaceEditorProvider(venueSlug, detail.id).notifier);

    return _Section(
      title: 'CLOSURES',
      actionLabel: 'Add',
      onAction: () async {
        final input = await showClosureSheet(
          context,
          spaceId: detail.id,
          spaceName: detail.name,
          timezone: timezone,
        );
        if (input == null || !context.mounted) return;
        await _run(context, () => notifier.addClosure(input));
      },
      child: detail.closures.isEmpty
          ? Text(
              'Nothing coming up. A closure stops new bookings for a window — '
              'it does not cancel the ones already in it.',
              style: AppType.bodyS.copyWith(color: p.ink3),
            )
          : Column(
              children: [
                for (final closure in detail.closures)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                closure.reason ?? 'Closed',
                                style: AppType.bodyStrong,
                              ),
                              Text(
                                '${AppTime.formatWhen(closure.startsAt, closure.endsAt, timezone)}'
                                '${closure.isWholeVenue ? ' · whole venue' : ''}',
                                style: AppType.bodyS.copyWith(color: p.ink3),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: 18),
                          tooltip: 'Remove',
                          onPressed: () =>
                              _run(context, () => notifier.removeClosure(closure.id)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}

class _Sessions extends StatelessWidget {
  const _Sessions({required this.detail, required this.timezone});

  final SpaceDetail detail;
  final String timezone;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    if (detail.sessions.isEmpty) return const SizedBox.shrink();

    return _Section(
      title: 'OPEN PLAY',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final session in detail.sessions)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(session.title, style: AppType.bodyStrong),
                        Text(
                          AppTime.formatWhen(
                            session.startsAt,
                            session.endsAt,
                            timezone,
                          ),
                          style: AppType.bodyS.copyWith(color: p.ink3),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    session.cancelled
                        ? 'Cancelled'
                        : '${session.spotsLeft} of ${session.capacity} left',
                    style: AppType.bodyS.copyWith(color: p.ink3),
                  ),
                ],
              ),
            ),
          const SizedBox(height: Spacing.x2),
          Text(
            'Sessions are set up on the web for now.',
            style: AppType.bodyS.copyWith(color: p.ink3),
          ),
        ],
      ),
    );
  }
}

class _Danger extends ConsumerWidget {
  const _Danger({required this.detail, required this.venueSlug});

  final SpaceDetail detail;
  final String venueSlug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final notifier =
        ref.read(spaceEditorProvider(venueSlug, detail.id).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton(
          onPressed: () => _run(
            context,
            () => notifier.setActive(!detail.isActive),
          ),
          child: Text(detail.isActive ? 'Pause this space' : 'Put back on sale'),
        ),
        const SizedBox(height: Spacing.x2),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: p.danger),
          onPressed: () => _delete(context, ref, notifier),
          child: const Text('Delete this space'),
        ),
      ],
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    SpaceEditor notifier,
  ) async {
    final ok = await showConfirmDialog(
      context,
      title: 'Delete ${detail.name}?',
      message: 'Its hours, pricing rules and closures go with it. This cannot '
          'be undone — pausing takes it off sale and is reversible.',
      confirmLabel: 'Delete',
      cancelLabel: 'Keep it',
      destructive: true,
    );
    if (!ok || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      await notifier.delete();
      // The list behind this screen still holds the space we just removed.
      ref.invalidate(spacesProvider(venueSlug));
      router.pop();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }
}

/// Runs a write and surfaces whatever the server refused with. Every editor
/// action goes through here so a 403 from a member, or a 409 from a delete
/// with bookings on it, reads the same way.
Future<void> _run(BuildContext context, Future<void> Function() write) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    await write();
  } catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
  }
}
