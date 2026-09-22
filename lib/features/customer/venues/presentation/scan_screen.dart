import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/router/deep_link_parser.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/primitives.dart';

/// C2 · Scan a venue QR. Accepts whatever a venue's poster carries: the
/// booking-page link, a manage link, or the bare slug.
class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final _controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _handled = false;
  String? _unknown;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    for (final barcode in capture.barcodes) {
      final raw = barcode.rawValue?.trim();
      if (raw == null || raw.isEmpty) continue;

      final uri = Uri.tryParse(raw.contains('://') ? raw : 'https://$raw');
      final target = uri == null ? const UnknownLink() : DeepLinkParser.parse(uri);
      final location = switch (target) {
        VenueLink(:final location) => location,
        SpaceLink(:final location) => location,
        ManageLink(:final location) => location,
        _ => null,
      };
      if (location != null) {
        _handled = true;
        context.pushReplacement(location);
        return;
      }
      setState(() => _unknown = "That QR isn't a ReservMe venue link.");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final top = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: p.band,
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),
          const _Reticle(),
          Positioned(
            top: top + Spacing.x2,
            left: Spacing.x4,
            right: Spacing.x4,
            child: Row(
              children: [
                RoundIconButton(
                  icon: Icons.close_rounded,
                  tooltip: 'Close',
                  onBand: true,
                  onPressed: () => context.pop(),
                ),
                Expanded(
                  child: Text(
                    'Scan a venue QR',
                    textAlign: TextAlign.center,
                    style: AppType.bodyStrong.copyWith(color: p.bandInk),
                  ),
                ),
                RoundIconButton(
                  icon: Icons.flashlight_on_rounded,
                  tooltip: 'Torch',
                  onBand: true,
                  onPressed: () => _controller.toggleTorch(),
                ),
              ],
            ),
          ),
          Positioned(
            left: Spacing.gutter,
            right: Spacing.gutter,
            bottom: Spacing.x10,
            child: Column(
              children: [
                Text(
                  _unknown ??
                      "Point at the QR on the venue's poster or booking page",
                  textAlign: TextAlign.center,
                  style: AppType.bodyStrong.copyWith(
                    color: _unknown == null ? p.bandInk : p.clayInk,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Links that start with reservme.pro/ open here',
                  textAlign: TextAlign.center,
                  style: AppType.caption.copyWith(color: p.bandMuted),
                ),
                const SizedBox(height: Spacing.x5),
                OutlinedButton(
                  onPressed: () => context.pushReplacement(Routes.customerFind),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: p.bandInk.withValues(alpha: 0.14),
                    foregroundColor: p.bandInk,
                    side: BorderSide.none,
                  ),
                  child: const Text('Enter a code instead'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Reticle extends StatelessWidget {
  const _Reticle();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Center(
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          border: Border.all(color: p.pineLine, width: 3),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(color: p.band.withValues(alpha: 0.55), spreadRadius: 999),
          ],
        ),
      ),
    );
  }
}
