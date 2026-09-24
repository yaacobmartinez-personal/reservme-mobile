import 'package:flutter/material.dart';

import '../../../../../core/model/enums.dart';
import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/sheet_shell.dart';
import '../../domain/team.dart';

/// G3 · Invite someone. Ownership is only offered when an owner is asking —
/// the server refuses it either way, but there is no point showing a choice
/// that cannot be made.
Future<InviteInput?> showInviteSheet(
  BuildContext context, {
  required bool canAssignOwner,
}) =>
    showModalBottomSheet<InviteInput>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _InviteSheet(canAssignOwner: canAssignOwner),
      ),
    );

class _InviteSheet extends StatefulWidget {
  const _InviteSheet({required this.canAssignOwner});

  final bool canAssignOwner;

  @override
  State<_InviteSheet> createState() => _InviteSheetState();
}

class _InviteSheetState extends State<_InviteSheet> {
  final _email = TextEditingController();
  VenueRole _role = VenueRole.member;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _send() {
    final input = InviteInput(email: _email.text, role: _role);
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
    final roles = [
      VenueRole.member,
      VenueRole.admin,
      if (widget.canAssignOwner) VenueRole.owner,
    ];

    return SheetShell(
      title: 'Invite someone',
      subtitle: 'They get an email with a link to join',
      error: _error,
      primaryLabel: 'Send invitation',
      onPrimary: _send,
      children: [
        TextField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: Spacing.x4),
        RadioGroup<VenueRole>(
          groupValue: _role,
          onChanged: (v) => setState(() => _role = v ?? _role),
          child: Column(
            children: [
              for (final role in roles)
                RadioListTile<VenueRole>(
                  contentPadding: EdgeInsets.zero,
                  value: role,
                  title: Text(role.label),
                  subtitle: Text(
                    _hint(role),
                    style: AppType.bodyS.copyWith(color: p.ink3),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  static String _hint(VenueRole role) => switch (role) {
        VenueRole.member =>
          'Runs the desk: check in, cancel, take a booking.',
        VenueRole.admin =>
          'All of that, plus spaces, pricing, hours and settings.',
        VenueRole.owner => 'Everything, including billing.',
      };
}
