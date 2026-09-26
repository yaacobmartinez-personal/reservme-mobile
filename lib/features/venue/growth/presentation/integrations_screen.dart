import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../../venues/domain/venue_membership.dart';
import '../application/growth_controllers.dart';
import '../domain/growth.dart';
import 'widgets/growth_widgets.dart';

/// The calendar feed, webhooks and API keys (API-CONTRACT #46). Owner/admin
/// only — every item here is a credential of some kind.
class IntegrationsScreen extends ConsumerWidget {
  const IntegrationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(selectedVenueProvider);
    if (venue == null) {
      return const Scaffold(
        body: EmptyState(icon: Icons.storefront_outlined, title: 'No venue selected', hint: 'Pick a venue first.'),
      );
    }
    final provider = integrationsProvider(venue.slug);
    final data = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(title: const Text('Integrations')),
      body: AsyncView(
        value: data,
        onRetry: () => ref.invalidate(provider),
        data: (i) => RefreshIndicator(
          onRefresh: () async => ref.refresh(provider.future),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x8),
            children: [
              const SectionLabel('CALENDAR FEED'),
              _FeedCard(venue: venue, url: i.icalUrl),
              const SectionLabel('WEBHOOKS'),
              const Hint(
                'We POST to your URL when a booking is made or cancelled, signed '
                'with the endpoint secret (HMAC-SHA256 of the body) so you can check '
                'it came from us.',
              ),
              const SizedBox(height: Spacing.x3),
              if (i.webhooks.isNotEmpty)
                GroupCard(children: [for (final w in i.webhooks) _WebhookTile(venue: venue, hook: w)]),
              const SizedBox(height: Spacing.x2),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: () => _addWebhook(context, venue, i.webhookEvents),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Add webhook'),
                ),
              ),
              const SectionLabel('API KEYS'),
              const Hint(
                'For reading your bookings and spaces from your own systems. A key is '
                'shown once, when it is made — copy it then.',
              ),
              const SizedBox(height: Spacing.x3),
              if (i.apiKeys.isNotEmpty)
                GroupCard(children: [for (final k in i.apiKeys) _KeyTile(venue: venue, apiKey: k)]),
              const SizedBox(height: Spacing.x2),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: () => _createKey(context, ref, venue),
                  icon: const Icon(Icons.key_rounded),
                  label: const Text('Create key'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addWebhook(BuildContext context, VenueMembership venue, List<String> events) async {
    final added = await showFormSheet<bool>(
      context,
      (_) => _WebhookForm(venue: venue, events: events),
    );
    if (added == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Webhook added.')));
    }
  }

  Future<void> _createKey(BuildContext context, WidgetRef ref, VenueMembership venue) async {
    final name = await showFormSheet<String>(context, (_) => const _KeyNameForm());
    if (name == null || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final key = await ref.read(growthCommandsProvider.notifier).createApiKey(venue.slug, name);
      if (context.mounted) await _showKeyOnce(context, key);
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
    }
  }

  /// The only time the whole key exists anywhere but the caller's system.
  Future<void> _showKeyOnce(BuildContext context, String key) => showDialog<void>(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Copy your key now'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("This is the only time it's shown. If you lose it, revoke it and make another."),
              const SizedBox(height: Spacing.x3),
              SelectableText(key, style: AppType.body.copyWith(fontFamily: AppType.mono)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Close whatever the clipboard does: a failed copy must not
                // trap anyone in a dialog they cannot dismiss.
                try {
                  await Clipboard.setData(ClipboardData(text: key));
                } finally {
                  if (dialogContext.mounted) Navigator.of(dialogContext).pop();
                }
              },
              child: const Text('Copy and close'),
            ),
          ],
        ),
      );
}

Future<void> _copy(BuildContext context, String text, String what) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$what copied.')));
  }
}

class _FeedCard extends ConsumerWidget {
  const _FeedCard({required this.venue, required this.url});

  final VenueMembership venue;
  final String? url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Hint(
            'Subscribe to this in Google Calendar or Apple Calendar to see your '
            'bookings there. Anyone with the link can read them, so treat it like a password.',
          ),
          const SizedBox(height: Spacing.x3),
          if (url != null)
            Text(url!, style: AppType.bodyS.copyWith(fontFamily: AppType.mono, color: p.ink2)),
          const SizedBox(height: Spacing.x2),
          Wrap(
            spacing: Spacing.x2,
            children: [
              if (url != null)
                OutlinedButton.icon(
                  onPressed: () => _copy(context, url!, 'Feed link'),
                  icon: const Icon(Icons.copy_rounded),
                  label: const Text('Copy link'),
                ),
              TextButton(
                onPressed: () async {
                  final ok = await showConfirmDialog(
                    context,
                    title: 'Make a new link?',
                    message: 'Every calendar using the current link stops updating. '
                        'Do this if the link has been shared somewhere it should not be.',
                    confirmLabel: 'New link',
                    cancelLabel: 'Keep it',
                    destructive: true,
                  );
                  if (!ok || !context.mounted) return;
                  final messenger = ScaffoldMessenger.of(context);
                  try {
                    await ref.read(growthCommandsProvider.notifier).rotateCalendarFeed(venue.slug);
                    messenger.showSnackBar(const SnackBar(content: Text('New link made. The old one no longer works.')));
                  } catch (e) {
                    messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
                  }
                },
                child: const Text('Make a new link'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WebhookTile extends ConsumerWidget {
  const _WebhookTile({required this.venue, required this.hook});

  final VenueMembership venue;
  final Webhook hook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    return ListTile(
      title: Text(hook.url, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(hook.events.join(', '), style: AppType.bodyS.copyWith(color: p.ink3)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Copy secret',
            icon: const Icon(Icons.key_outlined),
            onPressed: () => _copy(context, hook.secret, 'Signing secret'),
          ),
          IconButton(
            tooltip: 'Remove',
            icon: Icon(Icons.delete_outline_rounded, color: p.danger),
            onPressed: () async {
              final ok = await showConfirmDialog(
                context,
                title: 'Remove this webhook?',
                message: 'Nothing more is sent to ${hook.url}.',
                confirmLabel: 'Remove',
                cancelLabel: 'Keep',
                destructive: true,
              );
              if (!ok || !context.mounted) return;
              final messenger = ScaffoldMessenger.of(context);
              try {
                await ref.read(growthCommandsProvider.notifier).deleteWebhook(venue.slug, hook.id);
              } catch (e) {
                messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
              }
            },
          ),
        ],
      ),
    );
  }
}

class _KeyTile extends ConsumerWidget {
  const _KeyTile({required this.venue, required this.apiKey});

  final VenueMembership venue;
  final ApiKeyInfo apiKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final used = apiKey.lastUsedAt == null
        ? 'never used'
        : 'last used ${AppTime.formatDay(apiKey.lastUsedAt!, venue.timezone)}';
    return ListTile(
      title: Row(
        children: [
          Flexible(child: Text(apiKey.name, overflow: TextOverflow.ellipsis)),
          if (apiKey.revoked) ...[
            const SizedBox(width: Spacing.x2),
            const StatusChip('Revoked', tone: ChipTone.danger),
          ],
        ],
      ),
      subtitle: Text(
        '${apiKey.prefix}… · $used',
        style: AppType.bodyS.copyWith(color: p.ink3, fontFamily: AppType.mono),
      ),
      trailing: apiKey.revoked
          ? null
          : TextButton(
              onPressed: () async {
                final ok = await showConfirmDialog(
                  context,
                  title: 'Revoke ${apiKey.name}?',
                  message: 'Anything using this key stops working straight away.',
                  confirmLabel: 'Revoke',
                  cancelLabel: 'Keep',
                  destructive: true,
                );
                if (!ok || !context.mounted) return;
                final messenger = ScaffoldMessenger.of(context);
                try {
                  await ref.read(growthCommandsProvider.notifier).revokeApiKey(venue.slug, apiKey.id);
                } catch (e) {
                  messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
                }
              },
              style: TextButton.styleFrom(foregroundColor: p.danger),
              child: const Text('Revoke'),
            ),
    );
  }
}

class _WebhookForm extends ConsumerStatefulWidget {
  const _WebhookForm({required this.venue, required this.events});

  final VenueMembership venue;
  final List<String> events;

  @override
  ConsumerState<_WebhookForm> createState() => _WebhookFormState();
}

class _WebhookFormState extends ConsumerState<_WebhookForm> {
  final _url = TextEditingController();
  late final Set<String> _picked = widget.events.toSet();
  Map<String, String> _errors = const {};
  bool _busy = false;

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final uri = Uri.tryParse(_url.text.trim());
    final errors = <String, String>{
      if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) 'url': 'Enter a valid https URL.',
      if (_picked.isEmpty) 'events': 'Pick at least one event.',
    };
    if (errors.isNotEmpty) {
      setState(() => _errors = errors);
      return;
    }
    setState(() {
      _busy = true;
      _errors = const {};
    });
    try {
      await ref
          .read(growthCommandsProvider.notifier)
          .addWebhook(widget.venue.slug, url: _url.text, events: _picked.toList());
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _errors = e is ApiError && e.fieldErrors.isNotEmpty ? e.fieldErrors : {'url': AsyncView.messageFor(e)};
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Add a webhook', style: AppType.displayS),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _url,
          keyboardType: TextInputType.url,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: 'Endpoint URL',
            hintText: 'https://example.com/reservme',
            errorText: _errors['url'],
          ),
        ),
        const SizedBox(height: Spacing.x2),
        for (final event in widget.events)
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _picked.contains(event),
            title: Text(event, style: AppType.body.copyWith(fontFamily: AppType.mono)),
            onChanged: (on) => setState(() => on == true ? _picked.add(event) : _picked.remove(event)),
          ),
        if (_errors['events'] != null)
          Text(_errors['events']!, style: AppType.bodyS.copyWith(color: p.danger)),
        const SizedBox(height: Spacing.x3),
        FilledButton(onPressed: _busy ? null : _save, child: Text(_busy ? 'Adding…' : 'Add webhook')),
      ],
    );
  }
}

class _KeyNameForm extends StatefulWidget {
  const _KeyNameForm();

  @override
  State<_KeyNameForm> createState() => _KeyNameFormState();
}

class _KeyNameFormState extends State<_KeyNameForm> {
  final _name = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _next() {
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _error = 'Name the key.');
      return;
    }
    if (name.length > 60) {
      setState(() => _error = 'Keep the name under 60 characters.');
      return;
    }
    Navigator.of(context).pop(name);
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Create an API key', style: AppType.displayS),
          const SizedBox(height: Spacing.x3),
          TextField(
            controller: _name,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'What it is for',
              hintText: 'Accounting sync',
              errorText: _error,
            ),
            onSubmitted: (_) => _next(),
          ),
          const SizedBox(height: Spacing.x3),
          FilledButton(onPressed: _next, child: const Text('Create key')),
        ],
      );
}
