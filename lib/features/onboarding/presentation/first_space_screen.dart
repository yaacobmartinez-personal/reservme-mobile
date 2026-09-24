import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/model/enums.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/kind_placeholder.dart';
import '../../../core/widgets/async_view.dart';
import '../application/onboarding_controller.dart';
import '../domain/onboarding_input.dart';
import 'widgets/onboarding_shell.dart';

/// O4 · Add your first space, with the optional photo (O4b once one is
/// picked). A space with no photo is not a hole in the page — every surface
/// shows the kind placeholder instead.
class FirstSpaceScreen extends ConsumerStatefulWidget {
  const FirstSpaceScreen({super.key});

  @override
  ConsumerState<FirstSpaceScreen> createState() => _FirstSpaceScreenState();
}

class _FirstSpaceScreenState extends ConsumerState<FirstSpaceScreen> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  SpaceKind _kind = SpaceKind.court;
  int _slotMinutes = 60;
  String? _photoPath;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    super.dispose();
  }

  FirstSpaceInput get _input => FirstSpaceInput(
        name: _name.text,
        kind: _kind,
        slotMinutes: _slotMinutes,
        priceCents: _cents(_price.text),
        photoPath: _photoPath,
      );

  /// "350" and "350.50" both mean centavos, the way the web's `toCents` reads
  /// a price field.
  static int _cents(String input) {
    final value = double.tryParse(input.replaceAll(RegExp(r'[^\d.]'), ''));
    if (value == null || value < 0) return 0;
    return (value * 100).round();
  }

  Future<void> _pick(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        // Resized on the way in, so the upload is a photo and not a payload.
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 82,
      );
      if (picked != null && mounted) setState(() => _photoPath = picked.path);
    } catch (e) {
      if (mounted) setState(() => _error = AsyncView.messageFor(e));
    }
  }

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
      await ref.read(onboardingProvider.notifier).createSpace(_input);
      if (mounted) context.go(Routes.hours);
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
      step: OnboardingStep.space,
      title: 'Add your first space',
      subtitle: 'A space is anything a customer books: a court, a room, a '
          'studio, a table, a boat.',
      onBack: () => context.pop(),
      busy: _busy,
      error: _error,
      primaryLabel: 'Set opening hours',
      onPrimary: _submit,
      children: [
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: Spacing.x2,
          crossAxisSpacing: Spacing.x2,
          childAspectRatio: 1.35,
          children: [
            for (final kind in SpaceKind.values)
              _KindTile(
                kind: kind,
                selected: _kind == kind,
                onTap: () => setState(() => _kind = kind),
              ),
          ],
        ),
        const SizedBox(height: Spacing.x4),
        Text('Name', style: AppType.caption.copyWith(color: p.ink3)),
        const SizedBox(height: 6),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(hintText: '${_kind.label} 1'),
        ),
        const SizedBox(height: Spacing.x3),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Slot length', style: AppType.caption.copyWith(color: p.ink3)),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    initialValue: _slotMinutes,
                    isExpanded: true,
                    items: [
                      for (final minutes in FirstSpaceInput.slotChoices)
                        DropdownMenuItem(
                          value: minutes,
                          child: Text('$minutes min'),
                        ),
                    ],
                    onChanged: (v) => setState(() => _slotMinutes = v ?? _slotMinutes),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Spacing.x3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price per slot',
                    style: AppType.caption.copyWith(color: p.ink3),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _price,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(prefixText: '₱ ', hintText: '350'),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.x4),
        _PhotoBlock(
          kind: _kind,
          path: _photoPath,
          onCamera: () => _pick(ImageSource.camera),
          onGallery: () => _pick(ImageSource.gallery),
          onRemove: () => setState(() => _photoPath = null),
        ),
      ],
    );
  }
}

class _KindTile extends StatelessWidget {
  const _KindTile({
    required this.kind,
    required this.selected,
    required this.onTap,
  });

  final SpaceKind kind;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: selected ? p.pineSoft : p.card,
      borderRadius: BorderRadius.circular(Radii.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.md),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.md),
            border: Border.all(
              color: selected ? p.pine : p.rule,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                KindPlaceholder.iconFor(kind),
                size: 22,
                color: selected ? p.pineInk : p.ink2,
              ),
              const SizedBox(height: 6),
              Text(
                kind.label,
                style: AppType.captionStrong.copyWith(
                  color: selected ? p.pineInk : p.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The optional photo. Empty it is an invitation; filled it previews how the
/// space will look on the booking page.
class _PhotoBlock extends StatelessWidget {
  const _PhotoBlock({
    required this.kind,
    required this.path,
    required this.onCamera,
    required this.onGallery,
    required this.onRemove,
  });

  final SpaceKind kind;
  final String? path;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    if (path != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Radii.card),
            child: Image.file(
              File(path!),
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  KindPlaceholder(kind: kind, width: double.infinity, height: 150),
            ),
          ),
          Positioned(
            top: Spacing.x2,
            right: Spacing.x2,
            child: Row(
              children: [
                TextButton(onPressed: onGallery, child: const Text('Replace')),
                IconButton(
                  onPressed: onRemove,
                  tooltip: 'Remove photo',
                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(Spacing.x3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Radii.card),
        border: Border.all(color: p.pineLine, style: BorderStyle.solid),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KindPlaceholder(kind: kind, width: 96, height: 96),
          const SizedBox(width: Spacing.x3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add a photo', style: AppType.bodyStrong.copyWith(color: p.ink)),
                const SizedBox(height: 4),
                Text(
                  'Optional — spaces with a photo get booked more. Until then '
                  'customers see this placeholder.',
                  style: AppType.caption.copyWith(color: p.ink3),
                ),
                const SizedBox(height: Spacing.x2),
                Wrap(
                  spacing: Spacing.x2,
                  children: [
                    OutlinedButton.icon(
                      onPressed: onCamera,
                      icon: const Icon(Icons.photo_camera_outlined, size: 16),
                      label: const Text('Camera'),
                    ),
                    OutlinedButton.icon(
                      onPressed: onGallery,
                      icon: const Icon(Icons.photo_library_outlined, size: 16),
                      label: const Text('Gallery'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
