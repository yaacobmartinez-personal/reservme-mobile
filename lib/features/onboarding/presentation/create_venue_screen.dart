import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/time/app_time.dart';
import '../../../core/ui/photos.dart';
import '../../../core/widgets/async_view.dart';
import '../application/onboarding_controller.dart';
import '../domain/onboarding_input.dart';
import '../domain/onboarding_repository.dart';
import 'widgets/onboarding_shell.dart';

/// O3 · Name your venue. The name suggests the booking-page address, which
/// is checked as it is typed — finding out it is taken after submitting is
/// the worst moment to find out.
class CreateVenueScreen extends ConsumerStatefulWidget {
  const CreateVenueScreen({super.key});

  @override
  ConsumerState<CreateVenueScreen> createState() => _CreateVenueScreenState();
}

class _CreateVenueScreenState extends ConsumerState<CreateVenueScreen> {
  final _name = TextEditingController();
  final _slug = TextEditingController();
  final _address = TextEditingController();
  String _timezone = 'Asia/Manila';
  String _currency = 'PHP';

  /// True once the owner edits the address themselves — after that the name
  /// stops overwriting it.
  bool _slugTouched = false;
  Timer? _debounce;
  SlugCheck? _check;
  bool _checking = false;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _name.addListener(() {
      if (_slugTouched) return;
      _slug.text = VenueInput.slugify(_name.text);
      _queueCheck();
    });
    _slug.addListener(_queueCheck);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _name.dispose();
    _slug.dispose();
    _address.dispose();
    super.dispose();
  }

  void _queueCheck() {
    _debounce?.cancel();
    final wanted = _slug.text.trim();
    if (wanted.isEmpty) {
      setState(() => _check = null);
      return;
    }
    setState(() => _checking = true);
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      try {
        final result = await ref.read(onboardingProvider.notifier).checkSlug(wanted);
        if (mounted && result.slug == _slug.text.trim().toLowerCase()) {
          setState(() {
            _check = result;
            _checking = false;
          });
        }
      } catch (_) {
        if (mounted) setState(() => _checking = false);
      }
    });
  }

  VenueInput get _input => VenueInput(
        name: _name.text,
        slug: _slug.text,
        timezone: _timezone,
        currency: _currency,
        address: _address.text,
      );

  Future<void> _submit() async {
    final message = _input.validate();
    if (message != null) {
      setState(() => _error = message);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(onboardingProvider.notifier).createVenue(_input);
      if (mounted) context.go(Routes.firstSpace);
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
    final p = context.palette;

    return OnboardingShell(
      step: OnboardingStep.venue,
      heroAsset: Photos.padel,
      title: 'Name your venue',
      subtitle: 'This becomes your public booking page. Change it later any time.',
      onBack: () => context.pop(),
      busy: _busy,
      error: _error,
      primaryLabel: 'Create venue',
      onPrimary: _submit,
      children: [
        Text('Venue name', style: AppType.caption.copyWith(color: p.ink3)),
        const SizedBox(height: 6),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: Spacing.x3),
        Text('Booking page', style: AppType.caption.copyWith(color: p.ink3)),
        const SizedBox(height: 6),
        TextField(
          controller: _slug,
          autocorrect: false,
          onChanged: (_) => _slugTouched = true,
          decoration: InputDecoration(
            prefixText: '${Uri.parse(AppConfig.publicOrigin).host}/',
            prefixStyle: AppType.body.copyWith(color: p.ink3),
          ),
        ),
        const SizedBox(height: 6),
        _SlugHint(check: _check, checking: _checking),
        const SizedBox(height: Spacing.x3),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Timezone', style: AppType.caption.copyWith(color: p.ink3)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _timezone,
                    isExpanded: true,
                    items: [
                      for (final zone in _commonZones)
                        DropdownMenuItem(
                          value: zone,
                          child: Text(zone, overflow: TextOverflow.ellipsis),
                        ),
                    ],
                    onChanged: (v) => setState(() => _timezone = v ?? _timezone),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Spacing.x3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Currency', style: AppType.caption.copyWith(color: p.ink3)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    initialValue: _currency,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'PHP', child: Text('PHP ₱')),
                      DropdownMenuItem(value: 'USD', child: Text(r'USD $')),
                      DropdownMenuItem(value: 'EUR', child: Text('EUR €')),
                      DropdownMenuItem(value: 'SGD', child: Text(r'SGD S$')),
                    ],
                    onChanged: (v) => setState(() => _currency = v ?? _currency),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.x3),
        Text('Address', style: AppType.caption.copyWith(color: p.ink3)),
        const SizedBox(height: 6),
        TextField(
          controller: _address,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            hintText: '12 Esteban Abada St, Loyola Heights, QC',
          ),
        ),
      ],
    );
  }

  /// The zones a Philippine venue actually needs, with the device's own in
  /// case it is somewhere else. The full list is in venue settings.
  static List<String> get _commonZones {
    final zones = {
      'Asia/Manila',
      AppTime.deviceZone,
      'Asia/Singapore',
      'Asia/Hong_Kong',
      'Asia/Tokyo',
      'Australia/Sydney',
      'Europe/Madrid',
      'Europe/London',
      'America/Los_Angeles',
      'America/New_York',
      'UTC',
    };
    return zones.toList();
  }
}

class _SlugHint extends StatelessWidget {
  const _SlugHint({required this.check, required this.checking});

  final SlugCheck? check;
  final bool checking;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    if (checking) {
      return Text(
        'Checking…',
        style: AppType.caption.copyWith(color: p.ink3),
      );
    }
    if (check == null) {
      return Text(
        'Letters, numbers and dashes',
        style: AppType.caption.copyWith(color: p.ink3),
      );
    }
    return Row(
      children: [
        Icon(
          check!.available ? Icons.check_rounded : Icons.close_rounded,
          size: 14,
          color: check!.available ? p.pine : p.clayInk,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            check!.available
                ? 'Available — letters, numbers and dashes'
                : check!.reason ?? 'That address is taken.',
            style: AppType.caption.copyWith(
              color: check!.available ? p.pineInk : p.clayInk,
            ),
          ),
        ),
      ],
    );
  }
}
