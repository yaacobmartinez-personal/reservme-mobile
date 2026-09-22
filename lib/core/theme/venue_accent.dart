import 'package:flutter/material.dart';

import '../model/enums.dart';
import 'app_theme.dart';
import 'palette.dart';

/// The six white-label accents a venue can pick (`venue.theme`), as the web
/// `--color-swatch-*` tokens converted to sRGB. Customer-facing screens wrap
/// themselves in [VenueAccent] so the accent follows the venue while
/// everything else — paper, ink, clay — stays ReservMe.
abstract final class VenueAccents {
  static const _light = {
    VenueTheme.pine: (Color(0xFF167A57), Color(0xFF0B4D36), Color(0xFFE3F3EB), Color(0xFFBFE3D1)),
    VenueTheme.ocean: (Color(0xFF1B6E9A), Color(0xFF104B6B), Color(0xFFE2F0F8), Color(0xFFBBDBEC)),
    VenueTheme.violet: (Color(0xFF6B3FB5), Color(0xFF4A2A80), Color(0xFFEFE8F9), Color(0xFFD6C6F0)),
    VenueTheme.sunset: (Color(0xFFC86A2A), Color(0xFF8F4A1B), Color(0xFFFBEBE0), Color(0xFFF3CFB6)),
    VenueTheme.rose: (Color(0xFFB8455C), Color(0xFF832F41), Color(0xFFFAE7EB), Color(0xFFF0C4CD)),
    VenueTheme.slate: (Color(0xFF4B5361), Color(0xFF2F3540), Color(0xFFEBEDF0), Color(0xFFCDD2DA)),
  };

  static const _dark = {
    VenueTheme.pine: (Color(0xFF3FA37A), Color(0xFF9FD4BB), Color(0xFF17342A), Color(0xFF2A5A46)),
    VenueTheme.ocean: (Color(0xFF4A9BC8), Color(0xFFA9D3EA), Color(0xFF16303F), Color(0xFF265470)),
    VenueTheme.violet: (Color(0xFF9B76D9), Color(0xFFCDB8F0), Color(0xFF2A2140), Color(0xFF473770)),
    VenueTheme.sunset: (Color(0xFFE08D52), Color(0xFFF2C2A0), Color(0xFF3A2618), Color(0xFF66412A)),
    VenueTheme.rose: (Color(0xFFD9707F), Color(0xFFF0B4BE), Color(0xFF3B1F25), Color(0xFF6B3641)),
    VenueTheme.slate: (Color(0xFF8C97A8), Color(0xFFC5CCD6), Color(0xFF242830), Color(0xFF3E4550)),
  };

  /// [base] re-tinted for [theme]. Pine returns [base] unchanged.
  static AppPalette apply(AppPalette base, VenueTheme theme) {
    if (theme == VenueTheme.pine) return base;
    final (pine, pineInk, pineSoft, pineLine) =
        (base.isDark ? _dark : _light)[theme] ?? _light[VenueTheme.pine]!;
    return base.copyWith(
      pine: pine,
      pineHover: Color.lerp(pine, base.isDark ? Colors.white : Colors.black, 0.12),
      pineInk: pineInk,
      pineSoft: pineSoft,
      pineLine: pineLine,
      onPine: base.isDark ? const Color(0xFF12100E) : Colors.white,
    );
  }

  /// The swatch colour for a theme picker dot.
  static Color swatch(VenueTheme theme, {bool dark = false}) =>
      (dark ? _dark : _light)[theme]!.$1;
}

/// Re-themes its subtree with the venue's accent. Used on the venue page,
/// slot picker, booking form and booking detail.
class VenueAccent extends StatelessWidget {
  const VenueAccent({super.key, required this.theme, required this.child});

  final VenueTheme theme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (theme == VenueTheme.pine) return child;
    final base = context.palette;
    final palette = VenueAccents.apply(base, theme);
    return Theme(
      data: base.isDark ? AppTheme.dark(palette: palette) : AppTheme.light(palette: palette),
      child: child,
    );
  }
}
