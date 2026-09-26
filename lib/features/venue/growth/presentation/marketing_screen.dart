import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/model/enums.dart';
import '../../../../core/money/money.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/status_chip.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/app_choice_chip.dart';
import '../../../../core/widgets/async_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../venues/application/selected_venue_controller.dart';
import '../../venues/domain/venue_membership.dart';
import '../application/growth_controllers.dart';
import '../domain/growth.dart';
import 'widgets/growth_widgets.dart';

/// Promo codes, the review link, and how loyalty works (API-CONTRACT #44,
/// #45) — the web's Marketing page.
class MarketingScreen extends ConsumerWidget {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ref.watch(selectedVenueProvider);
    if (venue == null) {
      return const Scaffold(
        body: EmptyState(icon: Icons.storefront_outlined, title: 'No venue selected', hint: 'Pick a venue first.'),
      );
    }
    final codesProvider = promoCodesProvider(venue.slug);
    final settingsProvider = marketingSettingsProvider(venue.slug);
    final codes = ref.watch(codesProvider);
    final settings = ref.watch(settingsProvider);
    final canManage = venue.role.atLeast(VenueRole.admin);

    return Scaffold(
      appBar: AppBar(title: const Text('Promos & reviews')),
      floatingActionButton: canManage
          ? FloatingActionButton.extended(
              onPressed: () => _createCode(context, venue),
              icon: const Icon(Icons.local_offer_outlined),
              label: const Text('New code'),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(codesProvider)
            ..invalidate(settingsProvider);
          await ref.read(codesProvider.future);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x10 * 2),
          children: [
            const SectionLabel('PROMO CODES'),
            const Hint(
              'Customers type a code on the booking form. A percentage or a peso '
              'amount comes off; a pass or membership then applies to what is left.',
            ),
            const SizedBox(height: Spacing.x3),
            AsyncView(
              value: codes,
              onRetry: () => ref.invalidate(codesProvider),
              data: (list) => list.isEmpty
                  ? const Hint('No codes yet.')
                  : GroupCard(children: [
                      for (final code in list) _CodeTile(code: code, venue: venue, canManage: canManage),
                    ]),
            ),
            const SectionLabel('REVIEWS'),
            AsyncView(
              value: settings,
              onRetry: () => ref.invalidate(settingsProvider),
              data: (data) => _ReviewCard(venue: venue, settings: data, canManage: canManage),
            ),
            const SectionLabel('LOYALTY'),
            AsyncView(
              value: settings,
              onRetry: () => ref.invalidate(settingsProvider),
              data: (data) => AppCard(
                child: Text(
                  'Customers earn 1 point for every '
                  '${Money.format(data.loyalty.pesosPerPoint * 100, currency: venue.currency)} of a '
                  'confirmed booking — you see their points on their profile. Anyone who '
                  'agreed to marketing email and has not been back in '
                  '${data.loyalty.winbackAfterDays} days gets one "we miss you" email.',
                  style: AppType.body,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createCode(BuildContext context, VenueMembership venue) async {
    final created = await showFormSheet<PromoCode>(context, (_) => _CodeForm(venue: venue));
    if (created != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${created.code} is live.')));
    }
  }
}

class _CodeTile extends ConsumerWidget {
  const _CodeTile({required this.code, required this.venue, required this.canManage});

  final PromoCode code;
  final VenueMembership venue;
  final bool canManage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final now = DateTime.now().toUtc();
    final off = code.kind == PromoKind.percent
        ? '${code.percent}% off'
        : '${Money.format(code.amountCents ?? 0, currency: venue.currency)} off';
    final uses = code.maxUses == null ? '${code.uses} used' : '${code.uses} of ${code.maxUses} used';
    final expiry = code.expiresAt == null
        ? null
        : code.isExpired(now)
            ? 'expired ${AppTime.formatDay(code.expiresAt!, venue.timezone)}'
            : 'until ${AppTime.formatDay(code.expiresAt!, venue.timezone)}';
    final dead = code.isExpired(now) || code.isUsedUp;

    return ListTile(
      title: Row(
        children: [
          Text(code.code, style: AppType.bodyStrong.copyWith(fontFamily: AppType.mono, letterSpacing: 1)),
          if (dead) ...[
            const SizedBox(width: Spacing.x2),
            StatusChip(code.isUsedUp ? 'Used up' : 'Expired', tone: ChipTone.clay),
          ],
        ],
      ),
      subtitle: Text(
        [off, uses, ?expiry].join(' · '),
        style: AppType.bodyS.copyWith(color: p.ink3),
      ),
      trailing: Switch(
        value: code.active,
        onChanged: canManage
            ? (on) async {
                final messenger = ScaffoldMessenger.of(context);
                try {
                  await ref.read(growthCommandsProvider.notifier).setPromoActive(venue.slug, code.id, on);
                } catch (e) {
                  messenger.showSnackBar(SnackBar(content: Text(AsyncView.messageFor(e))));
                }
              }
            : null,
      ),
    );
  }
}

class _ReviewCard extends ConsumerStatefulWidget {
  const _ReviewCard({required this.venue, required this.settings, required this.canManage});

  final VenueMembership venue;
  final MarketingSettings settings;
  final bool canManage;

  @override
  ConsumerState<_ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends ConsumerState<_ReviewCard> {
  late final _url = TextEditingController(text: widget.settings.reviewUrl ?? '');
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final problem = reviewUrlProblem(_url.text);
    if (problem != null) {
      setState(() => _error = problem);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(growthCommandsProvider.notifier).setReviewUrl(widget.venue.slug, _url.text);
      messenger.showSnackBar(SnackBar(
        content: Text(_url.text.trim().isEmpty
            ? 'Review requests are off.'
            : 'Saved. Customers are asked for a review after their visit.'),
      ));
    } catch (e) {
      if (mounted) setState(() => _error = AsyncView.messageFor(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Hint(
            'After a visit, customers get one email asking for a review at this '
            'link. Leave it empty and no review emails go out.',
          ),
          const SizedBox(height: Spacing.x3),
          TextField(
            controller: _url,
            enabled: widget.canManage,
            keyboardType: TextInputType.url,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'Review link',
              hintText: 'https://g.page/your-venue/review',
              errorText: _error,
            ),
          ),
          if (widget.canManage) ...[
            const SizedBox(height: Spacing.x3),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(onPressed: _busy ? null : _save, child: const Text('Save link')),
            ),
          ],
        ],
      ),
    );
  }
}

class _CodeForm extends ConsumerStatefulWidget {
  const _CodeForm({required this.venue});

  final VenueMembership venue;

  @override
  ConsumerState<_CodeForm> createState() => _CodeFormState();
}

class _CodeFormState extends ConsumerState<_CodeForm> {
  final _code = TextEditingController();
  final _value = TextEditingController();
  final _maxUses = TextEditingController();
  PromoKind _kind = PromoKind.percent;
  String? _expires;
  Map<String, String> _errors = const {};
  bool _busy = false;

  @override
  void dispose() {
    _code.dispose();
    _value.dispose();
    _maxUses.dispose();
    super.dispose();
  }

  Future<void> _pickExpiry() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      helpText: 'Works through',
      initialDate: now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: DateTime(now.year + 3),
    );
    if (picked == null) return;
    setState(() => _expires = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-'
        '${picked.day.toString().padLeft(2, '0')}');
  }

  Future<void> _save() async {
    final input = PromoInput(
      code: _code.text,
      kind: _kind,
      value: _value.text,
      maxUses: _maxUses.text,
      expiresAt: _expires,
    );
    final local = input.validate();
    if (local.isNotEmpty) {
      setState(() => _errors = local);
      return;
    }
    setState(() {
      _busy = true;
      _errors = const {};
    });
    try {
      final code = await ref.read(growthCommandsProvider.notifier).createPromo(widget.venue.slug, input);
      if (mounted) Navigator.of(context).pop(code);
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _errors = e is ApiError && e.fieldErrors.isNotEmpty ? e.fieldErrors : {'code': AsyncView.messageFor(e)};
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
        Text('New promo code', style: AppType.displayS),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _code,
          textCapitalization: TextCapitalization.characters,
          autocorrect: false,
          decoration: InputDecoration(labelText: 'Code', hintText: 'WEEKDAY10', errorText: _errors['code']),
        ),
        const SizedBox(height: Spacing.x3),
        Wrap(
          spacing: Spacing.x2,
          children: [
            AppChoiceChip(
              label: 'Percent off',
              selected: _kind == PromoKind.percent,
              onSelected: () => setState(() => _kind = PromoKind.percent),
            ),
            AppChoiceChip(
              label: '${Money.symbol(widget.venue.currency)} off',
              selected: _kind == PromoKind.amount,
              onSelected: () => setState(() => _kind = PromoKind.amount),
            ),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Discount',
            prefixText: _kind == PromoKind.amount ? '${Money.symbol(widget.venue.currency)} ' : null,
            suffixText: _kind == PromoKind.percent ? '%' : null,
            errorText: _errors['value'],
          ),
        ),
        const SizedBox(height: Spacing.x3),
        TextField(
          controller: _maxUses,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Limit uses — optional',
            helperText: 'Leave empty for unlimited.',
            errorText: _errors['maxUses'],
          ),
        ),
        const SizedBox(height: Spacing.x2),
        Row(
          children: [
            Expanded(
              child: Text(
                _expires == null ? 'No expiry' : 'Works through $_expires, end of day',
                style: AppType.bodyS.copyWith(color: p.ink2),
              ),
            ),
            TextButton(onPressed: _pickExpiry, child: Text(_expires == null ? 'Set expiry' : 'Change')),
            if (_expires != null)
              IconButton(
                tooltip: 'No expiry',
                onPressed: () => setState(() => _expires = null),
                icon: const Icon(Icons.close_rounded),
              ),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        FilledButton(onPressed: _busy ? null : _save, child: Text(_busy ? 'Saving…' : 'Create code')),
      ],
    );
  }
}
