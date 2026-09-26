import 'package:flutter/material.dart';

import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Asks for one line of text. Returns null when dismissed, and the trimmed
/// text (possibly empty, when [required] is false) when confirmed.
///
/// A required prompt refuses in place rather than closing: validating after
/// the dialog has gone would throw away what was typed.
Future<String?> showAdminTextPrompt(
  BuildContext context, {
  required String title,
  required String message,
  required String label,
  required String confirmLabel,
  bool required = false,
  bool destructive = false,
  int maxLength = 300,
}) =>
    showDialog<String>(
      context: context,
      useRootNavigator: true,
      builder: (_) => _TextPrompt(
        title: title,
        message: message,
        label: label,
        confirmLabel: confirmLabel,
        required: required,
        destructive: destructive,
        maxLength: maxLength,
      ),
    );

class _TextPrompt extends StatefulWidget {
  const _TextPrompt({
    required this.title,
    required this.message,
    required this.label,
    required this.confirmLabel,
    required this.required,
    required this.destructive,
    required this.maxLength,
  });

  final String title;
  final String message;
  final String label;
  final String confirmLabel;
  final bool required;
  final bool destructive;
  final int maxLength;

  @override
  State<_TextPrompt> createState() => _TextPromptState();
}

class _TextPromptState extends State<_TextPrompt> {
  final _text = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _confirm() {
    final value = _text.text.trim();
    if (widget.required && value.isEmpty) {
      setState(() => _error = 'Write something first.');
      return;
    }
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.message, style: AppType.body.copyWith(color: p.ink2)),
          const SizedBox(height: Spacing.x3),
          TextField(
            controller: _text,
            autofocus: true,
            maxLength: widget.maxLength,
            minLines: 1,
            maxLines: 3,
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
            decoration: InputDecoration(labelText: widget.label, errorText: _error),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Keep it')),
        TextButton(
          onPressed: _confirm,
          style: widget.destructive ? TextButton.styleFrom(foregroundColor: p.danger) : null,
          child: Text(widget.confirmLabel),
        ),
      ],
    );
  }
}

/// The owner's email: subject and message. Returns null when dismissed.
Future<({String subject, String body})?> showEmailOwnerSheet(
  BuildContext context, {
  required String venueName,
}) =>
    showModalBottomSheet<({String subject, String body})>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(sheetContext).viewInsets.bottom),
        child: _EmailSheet(venueName: venueName),
      ),
    );

class _EmailSheet extends StatefulWidget {
  const _EmailSheet({required this.venueName});

  final String venueName;

  @override
  State<_EmailSheet> createState() => _EmailSheetState();
}

class _EmailSheetState extends State<_EmailSheet> {
  final _subject = TextEditingController();
  final _body = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _subject.dispose();
    _body.dispose();
    super.dispose();
  }

  void _send() {
    if (_subject.text.trim().length < 2 || _body.text.trim().length < 2) {
      setState(() => _error = 'Add a subject and a message.');
      return;
    }
    Navigator.of(context).pop((subject: _subject.text.trim(), body: _body.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Spacing.gutter, Spacing.x4, Spacing.gutter, Spacing.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Email the owner', style: AppType.displayS),
            const SizedBox(height: Spacing.x1),
            Text(
              'Goes to the first owner of ${widget.venueName}, signed "The ReservMe team". '
              'The subject is kept in the audit trail; the message is not.',
              style: AppType.bodyS.copyWith(color: p.ink3),
            ),
            const SizedBox(height: Spacing.x3),
            TextField(
              controller: _subject,
              maxLength: 200,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            TextField(
              controller: _body,
              minLines: 5,
              maxLines: 10,
              maxLength: 5000,
              decoration: InputDecoration(labelText: 'Message', errorText: _error),
            ),
            const SizedBox(height: Spacing.x3),
            FilledButton(onPressed: _send, child: const Text('Send email')),
          ],
        ),
      ),
    );
  }
}
