import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/model/enums.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/team_controller.dart';
import '../domain/team.dart';
import 'widgets/invite_sheet.dart';

/// G3 · Team. Who can do what at this venue, and who has been asked.
///
/// The screen shows every control and lets the server refuse, rather than
/// hiding buttons: "only an owner can do that" is information a manager needs,
/// and a missing control teaches nobody anything.
class TeamScreen extends ConsumerWidget {
  const TeamScreen({super.key});

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

    final provider = teamControllerProvider(venue.slug);
    final team = ref.watch(provider);
    final p = context.palette;

    return Scaffold(
      appBar: AppBar(title: const Text('Team')),
      floatingActionButton: team.value?.canManage ?? false
          ? FloatingActionButton.extended(
              onPressed: () => _invite(context, ref, venue.slug, team.value!),
              icon: const Icon(Icons.person_add_alt_rounded),
              label: const Text('Invite'),
            )
          : null,
      body: AsyncView(
        value: team,
        onRetry: () => ref.invalidate(provider),
        data: (data) => RefreshIndicator(
          onRefresh: () async => ref.refresh(provider.future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              Spacing.gutter,
              0,
              Spacing.gutter,
              Spacing.x8,
            ),
            children: [
              if (!data.canManage)
                const Padding(
                  padding: EdgeInsets.only(bottom: Spacing.x3),
                  child: AppBanner(
                    kind: BannerKind.info,
                    title: 'You can see the team but not change it',
                    body: 'Ask an owner or admin to invite someone or change '
                        'a role.',
                  ),
                ),
              Text(
                'ON THE TEAM',
                style: AppType.captionStrong.copyWith(color: p.ink3),
              ),
              const SizedBox(height: Spacing.x2),
              for (final member in data.members) ...[
                _MemberCard(
                  member: member,
                  team: data,
                  venueSlug: venue.slug,
                ),
                const SizedBox(height: Spacing.x2),
              ],
              if (data.invitations.isNotEmpty) ...[
                const SizedBox(height: Spacing.x3),
                Text(
                  'INVITED, NOT YET JOINED',
                  style: AppType.captionStrong.copyWith(color: p.ink3),
                ),
                const SizedBox(height: Spacing.x2),
                for (final invite in data.invitations) ...[
                  _InviteCard(
                    invite: invite,
                    canManage: data.canManage,
                    venueSlug: venue.slug,
                    timezone: venue.timezone,
                  ),
                  const SizedBox(height: Spacing.x2),
                ],
              ],
              const SizedBox(height: Spacing.x3),
              Text(
                'Staff run the desk: check in, cancel, take a booking. Admins '
                'can also reshape the venue. Owners can do everything, '
                'including billing.',
                style: AppType.bodyS.copyWith(color: p.ink3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _invite(
    BuildContext context,
    WidgetRef ref,
    String slug,
    Team team,
  ) async {
    final input = await showInviteSheet(context, canAssignOwner: team.canAssignOwner);
    if (input == null || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(teamControllerProvider(slug).notifier).invite(input);
      messenger.showSnackBar(
        SnackBar(content: Text('Invitation sent to ${input.email.trim()}.')),
      );
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }
}

class _MemberCard extends ConsumerWidget {
  const _MemberCard({
    required this.member,
    required this.team,
    required this.venueSlug,
  });

  final TeamMember member;
  final Team team;
  final String venueSlug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;

    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.isSelf ? '${member.name} (you)' : member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.bodyStrong,
                ),
                Text(
                  member.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.bodyS.copyWith(color: p.ink3),
                ),
              ],
            ),
          ),
          if (!team.canManage || member.isSelf)
            Padding(
              padding: const EdgeInsets.only(left: Spacing.x2),
              child: Text(
                member.role.label,
                style: AppType.bodyS.copyWith(color: p.ink3),
              ),
            )
          else
            PopupMenuButton<String>(
              tooltip: 'Change role',
              onSelected: (value) => _act(context, ref, value),
              itemBuilder: (_) => [
                for (final role in VenueRole.values)
                  PopupMenuItem(
                    value: 'role:${role.wire}',
                    enabled: role != member.role,
                    child: Text('Make ${role.label.toLowerCase()}'),
                  ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'remove',
                  child: Text('Remove from team'),
                ),
              ],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(member.role.label, style: AppType.bodyStrong),
                  const Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _act(BuildContext context, WidgetRef ref, String value) async {
    final messenger = ScaffoldMessenger.of(context);
    final notifier = ref.read(teamControllerProvider(venueSlug).notifier);

    try {
      if (value == 'remove') {
        final ok = await showConfirmDialog(
          context,
          title: 'Remove ${member.name}?',
          message: 'They lose access to this venue straight away. Bookings '
              'they took are kept.',
          confirmLabel: 'Remove',
          cancelLabel: 'Keep them',
          destructive: true,
        );
        if (!ok) return;
        await notifier.remove(member.id);
        messenger.showSnackBar(
          SnackBar(content: Text('${member.name} is off the team.')),
        );
        return;
      }

      final role = VenueRole.fromWire(value.split(':').last);
      await notifier.setRole(member.id, role);
      messenger.showSnackBar(
        SnackBar(
          content: Text('${member.name} is now ${role.label.toLowerCase()}.'),
        ),
      );
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }
}

class _InviteCard extends ConsumerWidget {
  const _InviteCard({
    required this.invite,
    required this.canManage,
    required this.venueSlug,
    required this.timezone,
  });

  final PendingInvite invite;
  final bool canManage;
  final String venueSlug;

  /// Every date in the app is shown in the venue's own zone; an expiry
  /// rendered in UTC lands on the wrong day for most of a Manila evening.
  final String timezone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final expired = invite.expiredAt(DateTime.now().toUtc());

    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invite.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.bodyStrong,
                ),
                Text(
                  expired
                      ? 'Invitation expired'
                      : 'As ${invite.role.label.toLowerCase()} · expires '
                          '${AppTime.formatDay(invite.expiresAt, 'UTC')}',
                  style: AppType.bodyS.copyWith(
                    color: expired ? p.warn : p.ink3,
                  ),
                ),
              ],
            ),
          ),
          if (canManage)
            TextButton(
              onPressed: () => _cancel(context, ref),
              child: const Text('Cancel'),
            ),
        ],
      ),
    );
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(teamControllerProvider(venueSlug).notifier)
          .cancelInvite(invite.id);
      messenger.showSnackBar(
        const SnackBar(content: Text('Invitation withdrawn.')),
      );
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }
}
