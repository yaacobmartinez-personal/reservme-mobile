import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/model/enums.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/ui/app_banner.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/app_choice_chip.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../onboarding/domain/onboarding_input.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../application/venue_settings_controller.dart';
import '../domain/venue_settings.dart';

/// G2 · Venue settings. The booking page, how it looks, and the rules that
/// decide what a customer may do — all of `updateVenueSettings` in one form,
/// saved in one go, because that is how the server writes it.
class VenueSettingsScreen extends ConsumerStatefulWidget {
  const VenueSettingsScreen({super.key});

  @override
  ConsumerState<VenueSettingsScreen> createState() =>
      _VenueSettingsScreenState();
}

class _VenueSettingsScreenState extends ConsumerState<VenueSettingsScreen> {
  VenueSettingsInput? _input;
  final _name = TextEditingController();
  final _tagline = TextEditingController();
  final _address = TextEditingController();
  final _refund = TextEditingController();
  final _gcash = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _tagline.dispose();
    _address.dispose();
    _refund.dispose();
    _gcash.dispose();
    super.dispose();
  }

  /// Seeds the form the first time the venue lands, and never again — a
  /// rebuild must not throw away what the owner is typing.
  void _seed(VenueSettings venue) {
    if (_input != null) return;
    _input = VenueSettingsInput.from(venue);
    _name.text = _input!.name;
    _tagline.text = _input!.tagline;
    _address.text = _input!.address;
    _refund.text = _input!.refundTerms;
    _gcash.text = _input!.gcashName;
  }

  VenueSettingsInput get _current => _input!.copyWith(
        name: _name.text,
        tagline: _tagline.text,
        address: _address.text,
        refundTerms: _refund.text,
        gcashName: _gcash.text,
      );

  Future<void> _save(String slug) async {
    final input = _current;
    final message = input.validate();
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(venueSettingsControllerProvider(slug).notifier)
          .save(input);
      if (!mounted) return;
      setState(() {
        _busy = false;
        _input = input;
      });
      messenger.showSnackBar(
        const SnackBar(content: Text('Saved. Your booking page is updated.')),
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = AsyncView.messageFor(e);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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

    final provider = venueSettingsControllerProvider(venue.slug);
    final settings = ref.watch(provider);
    final p = context.palette;

    return Scaffold(
      appBar: AppBar(title: const Text('Venue settings')),
      body: AsyncView(
        value: settings,
        onRetry: () => ref.invalidate(provider),
        data: (current) {
          _seed(current);
          final input = _input!;

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              Spacing.gutter,
              0,
              Spacing.gutter,
              Spacing.x8,
            ),
            children: [
              if (current.suspended)
                Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.x3),
                  child: AppBanner(
                    kind: BannerKind.error,
                    title: 'Your booking page is switched off',
                    body: current.suspendedReason ??
                        'Customers cannot book until this is resolved.',
                  ),
                ),

              // The booking page is the product, so it leads.
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR BOOKING PAGE',
                      style: AppType.captionStrong.copyWith(color: p.ink3),
                    ),
                    const SizedBox(height: Spacing.x2),
                    Text(current.bookingUrl, style: AppType.bodyStrong),
                    const SizedBox(height: Spacing.x2),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => SharePlus.instance.share(
                            ShareParams(
                              text: 'Book ${current.name}: '
                                  '${current.bookingUrl}',
                            ),
                          ),
                          icon: const Icon(Icons.ios_share_rounded, size: 18),
                          label: const Text('Share'),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.x2),
                    Text(
                      'The address cannot be changed here — it is what your '
                      'printed QR codes and every confirmation email point at.',
                      style: AppType.bodyS.copyWith(color: p.ink3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.x3),

              _Group(
                title: 'THE BASICS',
                children: [
                  TextField(
                    controller: _name,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'Venue name'),
                  ),
                  const SizedBox(height: Spacing.x3),
                  TextField(
                    controller: _tagline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Tagline',
                      hintText: 'Four covered courts in Katipunan',
                    ),
                  ),
                  const SizedBox(height: Spacing.x3),
                  TextField(
                    controller: _address,
                    textCapitalization: TextCapitalization.words,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                  const SizedBox(height: Spacing.x3),
                  DropdownButtonFormField<String>(
                    initialValue: AppTime.supportedTimeZones()
                            .contains(input.timezone)
                        ? input.timezone
                        : null,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Timezone'),
                    items: [
                      for (final zone in AppTime.supportedTimeZones())
                        DropdownMenuItem(value: zone, child: Text(zone)),
                    ],
                    onChanged: (v) => setState(
                      () => _input = _current.copyWith(timezone: v),
                    ),
                  ),
                  const SizedBox(height: Spacing.x2),
                  Text(
                    'Every time in the app and on your booking page is shown '
                    'in this zone.',
                    style: AppType.bodyS.copyWith(color: p.ink3),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.x3),

              _Group(
                title: 'HOW IT LOOKS',
                children: [
                  Text(
                    'Accent colour',
                    style: AppType.bodyS.copyWith(color: p.ink3),
                  ),
                  const SizedBox(height: Spacing.x2),
                  Wrap(
                    spacing: Spacing.x2,
                    runSpacing: Spacing.x2,
                    children: [
                      for (final theme in VenueTheme.values)
                        AppChoiceChip(
                          label: _themeLabel(theme),
                          selected: input.theme == theme,
                          onSelected: () => setState(
                            () => _input = _current.copyWith(theme: theme),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: Spacing.x2),
                  Text(
                    'Your logo and cover photo are uploaded with the rest of '
                    'the image tools.',
                    style: AppType.bodyS.copyWith(color: p.ink3),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.x3),

              _Group(
                title: 'BOOKING RULES',
                children: [
                  DropdownButtonFormField<int>(
                    initialValue: PolicyInput.noticeChoices
                            .contains(input.minNoticeMinutes)
                        ? input.minNoticeMinutes
                        : null,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Least notice before a booking',
                    ),
                    items: [
                      for (final minutes in PolicyInput.noticeChoices)
                        DropdownMenuItem(
                          value: minutes,
                          child: Text(PolicyInput.noticeLabel(minutes)),
                        ),
                    ],
                    onChanged: (v) => setState(
                      () => _input = _current.copyWith(minNoticeMinutes: v),
                    ),
                  ),
                  const SizedBox(height: Spacing.x3),
                  DropdownButtonFormField<int>(
                    initialValue: PolicyInput.horizonChoices
                            .contains(input.maxHorizonDays)
                        ? input.maxHorizonDays
                        : null,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'How far ahead people can book',
                    ),
                    items: [
                      for (final days in PolicyInput.horizonChoices)
                        DropdownMenuItem(
                          value: days,
                          child: Text(PolicyInput.horizonLabel(days)),
                        ),
                    ],
                    onChanged: (v) => setState(
                      () => _input = _current.copyWith(maxHorizonDays: v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.x3),

              _Group(
                title: 'CANCELLATIONS',
                children: [
                  RadioGroup<CancellationMode>(
                    groupValue: input.cancellationMode,
                    onChanged: (v) => setState(
                      () => _input = _current.copyWith(cancellationMode: v),
                    ),
                    child: Column(
                      children: [
                        for (final mode in CancellationMode.values)
                          RadioListTile<CancellationMode>(
                            contentPadding: EdgeInsets.zero,
                            value: mode,
                            title: Text(_cancelTitle(mode)),
                            subtitle: Text(
                              _cancelHint(mode, input.cancellationGraceHours),
                              style: AppType.bodyS.copyWith(color: p.ink3),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (input.cancellationMode == CancellationMode.grace) ...[
                    const SizedBox(height: Spacing.x2),
                    DropdownButtonFormField<int>(
                      initialValue: _graceChoices
                              .contains(input.cancellationGraceHours)
                          ? input.cancellationGraceHours
                          : null,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Cut-off before the booking',
                      ),
                      items: [
                        for (final hours in _graceChoices)
                          DropdownMenuItem(
                            value: hours,
                            child: Text('$hours hours before'),
                          ),
                      ],
                      onChanged: (v) => setState(
                        () => _input =
                            _current.copyWith(cancellationGraceHours: v),
                      ),
                    ),
                  ],
                  const SizedBox(height: Spacing.x3),
                  TextField(
                    controller: _refund,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Refund terms',
                      hintText: 'Shown on the booking page and in emails.',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.x3),

              _Group(
                title: 'PAYMENT',
                children: [
                  TextField(
                    controller: _gcash,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'GCash account name',
                    ),
                  ),
                  const SizedBox(height: Spacing.x2),
                  Text(
                    'Customers pay at the venue in v1. This name is shown so '
                    'they know who they are transferring to if they ask.',
                    style: AppType.bodyS.copyWith(color: p.ink3),
                  ),
                ],
              ),

              if (_error != null) ...[
                const SizedBox(height: Spacing.x3),
                AppBanner(kind: BannerKind.error, title: _error!),
              ],
              const SizedBox(height: Spacing.x4),
              FilledButton(
                onPressed: _busy ? null : () => _save(venue.slug),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
                child: const Text('Save settings'),
              ),
            ],
          );
        },
      ),
    );
  }

  static const _graceChoices = [2, 6, 12, 24, 48, 72];

  static String _themeLabel(VenueTheme theme) =>
      theme.wire[0].toUpperCase() + theme.wire.substring(1);

  static String _cancelTitle(CancellationMode mode) => switch (mode) {
        CancellationMode.anytime => 'Anytime before the booking',
        CancellationMode.grace => 'Up to a cut-off',
        CancellationMode.never => 'Never — they contact us',
      };

  static String _cancelHint(CancellationMode mode, int hours) =>
      switch (mode) {
        CancellationMode.anytime =>
          'The friendliest option, and the most no-shows.',
        CancellationMode.grace =>
          'Cancelling closes $hours hours before the slot starts.',
        CancellationMode.never =>
          'Your desk can still cancel for them from Today.',
      };
}

class _Group extends StatelessWidget {
  const _Group({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: AppType.captionStrong.copyWith(color: context.palette.ink3),
            ),
            const SizedBox(height: Spacing.x3),
            ...children,
          ],
        ),
      );
}
