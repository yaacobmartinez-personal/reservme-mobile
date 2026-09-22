import 'package:flutter/material.dart';

import '../theme/palette.dart';
import '../theme/typography.dart';

/// The one confirmation dialog (design canvas, Molecules · Sheets & dialogs).
/// Used before anything that cannot be undone: cancelling a booking, wiping
/// local data, deleting a space.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirm',
  String cancelLabel = 'Cancel',
  bool destructive = false,
}) async {
  final p = context.palette;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      // One Row, not two OverflowBar children: the buttons share the width
      // evenly and never wrap onto separate lines.
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(cancelLabel),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: destructive
                    ? FilledButton.styleFrom(
                        backgroundColor: p.danger,
                        foregroundColor: p.isDark ? p.onPine : Colors.white,
                      )
                    : null,
                child: Text(confirmLabel, style: AppType.button),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  return result ?? false;
}
