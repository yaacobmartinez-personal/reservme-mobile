import 'package:flutter/material.dart';

/// The type scale from the design canvas (Foundations · Typography):
/// Fraunces for display (upright, weight 400 — never italic), Instrument Sans
/// for everything else, JetBrains Mono for references and codes. All three
/// ship as variable fonts, so styles carry the `wght` axis as well as
/// [FontWeight].
abstract final class AppType {
  static const display = 'Fraunces';
  static const family = 'Instrument Sans';
  static const mono = 'JetBrains Mono';

  static TextStyle _sans(
    double size,
    int weight, {
    double? spacing,
    double? height,
  }) =>
      TextStyle(
        fontFamily: family,
        fontSize: size,
        fontWeight: FontWeight.values[(weight ~/ 100) - 1],
        fontVariations: [FontVariation.weight(weight.toDouble())],
        letterSpacing: spacing,
        height: height,
      );

  static TextStyle _serif(double size, {double? spacing, double height = 1.05}) =>
      TextStyle(
        fontFamily: display,
        fontSize: size,
        fontWeight: FontWeight.w400,
        fontVariations: const [FontVariation.weight(400), FontVariation('opsz', 96)],
        letterSpacing: spacing,
        height: height,
      );

  // ---- display (Fraunces) ------------------------------------------------

  /// "Where are you playing?" — welcome and onboarding titles.
  static final displayXl = _serif(44, spacing: -0.9, height: 1.02);

  /// Screen titles: "Today", "Katipunan Courts".
  static final displayL = _serif(32, spacing: -0.6, height: 1.05);

  /// Big values on tickets and summaries.
  static final displayM = _serif(24, spacing: -0.3, height: 1.1);

  /// Card titles: "Court 1".
  static final displayS = _serif(19, height: 1.1);

  /// KPI numbers.
  static final numeral = _serif(24, height: 1).copyWith(
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  // ---- body (Instrument Sans) -------------------------------------------

  static final bodyL = _sans(16, 400, height: 1.5);
  static final body = _sans(14, 400, height: 1.45);
  static final bodyStrong = _sans(15, 600, height: 1.3);
  static final bodyS = _sans(13, 400, height: 1.4);

  /// Field labels.
  static final label = _sans(13, 500, height: 1.3);

  /// Buttons, chips, tab labels.
  static final button = _sans(15, 600, height: 1.2);
  static final buttonS = _sans(13, 600, height: 1.2);

  static final caption = _sans(12, 400, height: 1.4);
  static final captionStrong = _sans(11, 600, height: 1.2);

  /// "RECENT VENUES" — uppercase by convention at the call site.
  static final eyebrow = _sans(11, 600, spacing: 1.2, height: 1.2);

  // ---- mono --------------------------------------------------------------

  /// "KTP-7H4M".
  static const reference = TextStyle(
    fontFamily: mono,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontVariations: [FontVariation.weight(500)],
    letterSpacing: 0.8,
  );

  /// A Material [TextTheme] built from the scale so default widgets
  /// (dialogs, list tiles, app bars) speak the same language.
  static TextTheme textTheme(Color ink, Color muted) => TextTheme(
        displayLarge: displayXl.copyWith(color: ink),
        displayMedium: displayL.copyWith(color: ink),
        displaySmall: displayM.copyWith(color: ink),
        headlineLarge: displayL.copyWith(color: ink, fontSize: 28),
        headlineMedium: displayM.copyWith(color: ink),
        headlineSmall: displayS.copyWith(color: ink, fontSize: 20),
        titleLarge: displayS.copyWith(color: ink),
        titleMedium: bodyStrong.copyWith(color: ink),
        titleSmall: label.copyWith(color: ink),
        bodyLarge: bodyL.copyWith(color: ink),
        bodyMedium: body.copyWith(color: ink),
        bodySmall: bodyS.copyWith(color: muted),
        labelLarge: button.copyWith(color: ink),
        labelMedium: caption.copyWith(color: muted),
        labelSmall: eyebrow.copyWith(color: muted),
      );
}
