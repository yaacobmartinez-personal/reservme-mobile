import 'package:flutter/material.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/ui/app_banner.dart';
import '../../../../../core/widgets/sheet_shell.dart';

/// G7 · Confirming deletion. Typing the word is deliberate friction: this is
/// the one action in the app with no undo and no support path back.
///
/// [ownerOf] names the venues the user owns, so the sheet can warn *before*
/// the server refuses — the fix is to hand a venue over, which takes a
/// conversation, not a tap.
Future<bool> showDeleteAccountSheet(
  BuildContext context, {
  required List<String> ownerOf,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (_) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: _DeleteSheet(ownerOf: ownerOf),
    ),
  );
  return result ?? false;
}

class _DeleteSheet extends StatefulWidget {
  const _DeleteSheet({required this.ownerOf});

  final List<String> ownerOf;

  @override
  State<_DeleteSheet> createState() => _DeleteSheetState();
}

class _DeleteSheetState extends State<_DeleteSheet> {
  static const _word = 'DELETE';

  final _typed = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    _typed.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _typed.dispose();
    super.dispose();
  }

  bool get _matches => _typed.text.trim().toUpperCase() == _word;

  void _confirm() {
    if (!_matches) {
      setState(() => _error = 'Type $_word to confirm.');
      return;
    }
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return SheetShell(
      title: 'Delete your account',
      subtitle: 'This cannot be undone',
      error: _error,
      primaryLabel: 'Delete my account',
      onPrimary: _confirm,
      busy: !_matches,
      children: [
        if (widget.ownerOf.isNotEmpty) ...[
          AppBanner(
            kind: BannerKind.warn,
            title: widget.ownerOf.length == 1
                ? 'You own ${widget.ownerOf.single}'
                : 'You own ${widget.ownerOf.length} venues',
            body: 'If you are its only owner, make someone else an owner '
                'first — a venue with no owner cannot be paid for or handed '
                'on, and we cannot undo that for you.',
          ),
          const SizedBox(height: Spacing.x3),
        ],
        Text(
          'Your login, your team memberships and the notes you wrote go with '
          'you. Bookings belong to the venue and stay with it.',
          style: AppType.bodyS.copyWith(color: p.ink2),
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _typed,
          autocorrect: false,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(
            labelText: 'Type $_word to confirm',
          ),
        ),
      ],
    );
  }
}
