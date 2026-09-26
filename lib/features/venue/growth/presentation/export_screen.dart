import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/growth_controllers.dart';
import '../domain/growth.dart';
import 'widgets/growth_widgets.dart';

/// Get your data out (API-CONTRACT #47): the same three CSVs the web
/// dashboard downloaded, handed to the phone's share sheet — email it, save it
/// to Drive, open it in Sheets.
class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  ExportKind? _busy;

  Future<void> _export(String slug, ExportKind kind) async {
    setState(() => _busy = kind);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final csv = await ref.read(growthCommandsProvider.notifier).export(slug, kind);
      final name = '${kind.name}-$slug.csv';
      await SharePlus.instance.share(ShareParams(
        files: [XFile.fromData(utf8.encode(csv), mimeType: 'text/csv', name: name)],
        fileNameOverrides: [name],
        subject: '${kind.label} — $slug',
      ));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final venue = ref.watch(selectedVenueProvider);
    if (venue == null) {
      return const Scaffold(
        body: EmptyState(icon: Icons.storefront_outlined, title: 'No venue selected', hint: 'Pick a venue first.'),
      );
    }
    final p = context.palette;
    return Scaffold(
      appBar: AppBar(title: const Text('Export')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x8),
        children: [
          const Hint(
            'Spreadsheet files (CSV), in your venue\'s time. They open in Excel, '
            'Numbers and Google Sheets.',
          ),
          const SizedBox(height: Spacing.x4),
          GroupCard(children: [
            for (final kind in ExportKind.values)
              ListTile(
                leading: Icon(
                  switch (kind) {
                    ExportKind.bookings => Icons.event_note_outlined,
                    ExportKind.customers => Icons.people_outline_rounded,
                    ExportKind.transactions => Icons.receipt_long_outlined,
                  },
                  color: p.ink3,
                ),
                title: Text(kind.label),
                subtitle: Text(kind.blurb),
                trailing: _busy == kind
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.ios_share_rounded),
                enabled: _busy == null,
                onTap: () => _export(venue.slug, kind),
              ),
          ]),
        ],
      ),
    );
  }
}
