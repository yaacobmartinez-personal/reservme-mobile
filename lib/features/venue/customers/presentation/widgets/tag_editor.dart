import 'package:flutter/material.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../domain/customers_repository.dart';

/// The tag row on V11. Tags are the venue's own shorthand — "Regular",
/// "Weekday league" — so the editor validates with the server's own rules
/// and refuses in place rather than round-tripping to find out.
class TagEditor extends StatelessWidget {
  const TagEditor({super.key, required this.tags, required this.onChanged});

  final List<String> tags;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Wrap(
      spacing: Spacing.x2,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final tag in tags)
          InputChip(
            label: Text(tag),
            onDeleted: () => onChanged([...tags]..remove(tag)),
            deleteIcon: const Icon(Icons.close_rounded, size: 16),
            backgroundColor: p.pineSoft,
            side: BorderSide(color: p.pineLine),
            labelStyle: AppType.captionStrong.copyWith(color: p.pineInk),
          ),
        IconButton(
          onPressed: () => _add(context),
          tooltip: 'Add a tag',
          visualDensity: VisualDensity.compact,
          icon: Icon(Icons.add_rounded, size: 20, color: p.pineInk),
        ),
      ],
    );
  }

  Future<void> _add(BuildContext context) async {
    final controller = TextEditingController();
    String? error;

    final tag = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add a tag'),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLength: 30,
            decoration: InputDecoration(
              hintText: 'Regular',
              errorText: error,
            ),
            onSubmitted: (_) {
              final message = TagRules.validate(controller.text, tags);
              if (message != null) {
                setState(() => error = message);
                return;
              }
              Navigator.of(context).pop(controller.text.trim());
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final message = TagRules.validate(controller.text, tags);
                if (message != null) {
                  setState(() => error = message);
                  return;
                }
                Navigator.of(context).pop(controller.text.trim());
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
    if (tag != null && tag.isNotEmpty) onChanged([...tags, tag]);
  }
}
