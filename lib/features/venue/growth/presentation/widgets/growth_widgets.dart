import 'package:flutter/material.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/ui/primitives.dart';

/// Rows in one card, divided — the grouped-list look of More and Account.
class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => AppCard(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            for (final (i, child) in children.indexed) ...[
              if (i > 0) const Divider(height: 1),
              child,
            ],
          ],
        ),
      );
}

/// A section label with the space the screens put around it.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: Spacing.x5, bottom: Spacing.x2),
        child: Eyebrow(title),
      );
}

/// One or two sentences under a section, in the quiet ink.
class Hint extends StatelessWidget {
  const Hint(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: AppType.bodyS.copyWith(color: context.palette.ink3));
}

/// The bottom sheet every create form here uses: a title, the fields, one
/// button, and an error line that refuses in place rather than closing.
Future<T?> showFormSheet<T>(BuildContext context, Widget Function(BuildContext) builder) =>
    showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(sheetContext).viewInsets.bottom),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(Spacing.gutter, Spacing.x4, Spacing.gutter, Spacing.x4),
            child: builder(sheetContext),
          ),
        ),
      ),
    );
