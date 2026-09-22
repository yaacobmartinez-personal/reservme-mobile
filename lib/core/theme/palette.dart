import 'package:flutter/material.dart';

/// The colour tokens from the design canvas (Foundations · Colour and
/// Foundations · Dark mode), one instance per brightness. Widgets read them
/// through `context.palette`, never as constants, so a screen looks right in
/// both themes without knowing which one is active.
///
/// "Pine on warm paper": a warm off-white ground, near-black warm ink, a deep
/// pine accent, clay as the secondary/caution colour.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.brightness,
    required this.paper,
    required this.paper2,
    required this.paper3,
    required this.card,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.rule,
    required this.ruleStrong,
    required this.pine,
    required this.pineHover,
    required this.pineInk,
    required this.pineSoft,
    required this.pineLine,
    required this.onPine,
    required this.clay,
    required this.clayInk,
    required this.claySoft,
    required this.clayLine,
    required this.danger,
    required this.dangerSoft,
    required this.warn,
    required this.warnSoft,
    required this.band,
    required this.bandInk,
    required this.bandMuted,
    required this.shadow,
  });

  final Brightness brightness;

  /// Scaffold ground, a secondary surface, the deepest neutral fill.
  final Color paper;
  final Color paper2;
  final Color paper3;

  /// Cards and sheets.
  final Color card;

  /// Text: primary, secondary, tertiary (tertiary still clears 4.5:1 on paper-3).
  final Color ink;
  final Color ink2;
  final Color ink3;

  /// Hairlines and stronger dividers / knob outlines.
  final Color rule;
  final Color ruleStrong;

  /// The accent. [onPine] is the text colour on a pine fill: white in light,
  /// ink-dark in dark mode (the lifted dark pine fails with white text).
  final Color pine;
  final Color pineHover;
  final Color pineInk;
  final Color pineSoft;
  final Color pineLine;
  final Color onPine;

  /// Secondary, used sparingly: caution chips, no-show, peak prices.
  final Color clay;
  final Color clayInk;
  final Color claySoft;
  final Color clayLine;

  final Color danger;
  final Color dangerSoft;
  final Color warn;
  final Color warnSoft;

  /// The near-black band used for hero covers and summary cards, with its own
  /// ink and muted text.
  final Color band;
  final Color bandInk;
  final Color bandMuted;

  /// The one soft warm shadow for floating things (FAB, toast).
  final Color shadow;

  bool get isDark => brightness == Brightness.dark;

  /// Scrim over hero photos so titles stay legible.
  List<Color> get scrim => const [Color(0x000B0A09), Color(0xE60B0A09), Color(0xFF0B0A09)];

  static const light = AppPalette(
    brightness: Brightness.light,
    paper: Color(0xFFFBFAF7),
    paper2: Color(0xFFF7F5F0),
    paper3: Color(0xFFEEEBE4),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF2A2620),
    ink2: Color(0xFF605B53),
    ink3: Color(0xFF77726A),
    rule: Color(0xFFE3E0DA),
    ruleStrong: Color(0xFFD3CFC6),
    pine: Color(0xFF167A57),
    pineHover: Color(0xFF0E6A4A),
    pineInk: Color(0xFF0B4D36),
    pineSoft: Color(0xFFE3F3EB),
    pineLine: Color(0xFFBFE3D1),
    onPine: Color(0xFFFFFFFF),
    clay: Color(0xFFC8744A),
    clayInk: Color(0xFF9A4F2B),
    claySoft: Color(0xFFF8E9E0),
    clayLine: Color(0xFFF0D3C2),
    danger: Color(0xFF9A2C2C),
    dangerSoft: Color(0xFFF9E5E5),
    warn: Color(0xFF8A6A2F),
    warnSoft: Color(0xFFFBF1DC),
    band: Color(0xFF1C1A17),
    bandInk: Color(0xFFFBFAF7),
    bandMuted: Color(0xFFB8B3A9),
    shadow: Color(0x2E2A2620),
  );

  static const dark = AppPalette(
    brightness: Brightness.dark,
    paper: Color(0xFF161412),
    paper2: Color(0xFF1C1A17),
    paper3: Color(0xFF262320),
    card: Color(0xFF1F1C19),
    ink: Color(0xFFF3EFE7),
    ink2: Color(0xFFB8B3A9),
    ink3: Color(0xFF948E84),
    rule: Color(0xFF2F2B27),
    ruleStrong: Color(0xFF3B3632),
    pine: Color(0xFF3FA37A),
    pineHover: Color(0xFF55B88E),
    pineInk: Color(0xFF9FD4BB),
    pineSoft: Color(0xFF17342A),
    pineLine: Color(0xFF2A5A46),
    onPine: Color(0xFF0B1F17),
    clay: Color(0xFFD98A5E),
    clayInk: Color(0xFFF0B58F),
    claySoft: Color(0xFF33241B),
    clayLine: Color(0xFF4A3225),
    danger: Color(0xFFE07A7A),
    dangerSoft: Color(0xFF3A1E1E),
    warn: Color(0xFFD8B466),
    warnSoft: Color(0xFF332B18),
    band: Color(0xFF0B0A09),
    bandInk: Color(0xFFF3EFE7),
    bandMuted: Color(0xFF948E84),
    shadow: Color(0x66000000),
  );

  @override
  AppPalette copyWith({
    Brightness? brightness,
    Color? paper,
    Color? paper2,
    Color? paper3,
    Color? card,
    Color? ink,
    Color? ink2,
    Color? ink3,
    Color? rule,
    Color? ruleStrong,
    Color? pine,
    Color? pineHover,
    Color? pineInk,
    Color? pineSoft,
    Color? pineLine,
    Color? onPine,
    Color? clay,
    Color? clayInk,
    Color? claySoft,
    Color? clayLine,
    Color? danger,
    Color? dangerSoft,
    Color? warn,
    Color? warnSoft,
    Color? band,
    Color? bandInk,
    Color? bandMuted,
    Color? shadow,
  }) =>
      AppPalette(
        brightness: brightness ?? this.brightness,
        paper: paper ?? this.paper,
        paper2: paper2 ?? this.paper2,
        paper3: paper3 ?? this.paper3,
        card: card ?? this.card,
        ink: ink ?? this.ink,
        ink2: ink2 ?? this.ink2,
        ink3: ink3 ?? this.ink3,
        rule: rule ?? this.rule,
        ruleStrong: ruleStrong ?? this.ruleStrong,
        pine: pine ?? this.pine,
        pineHover: pineHover ?? this.pineHover,
        pineInk: pineInk ?? this.pineInk,
        pineSoft: pineSoft ?? this.pineSoft,
        pineLine: pineLine ?? this.pineLine,
        onPine: onPine ?? this.onPine,
        clay: clay ?? this.clay,
        clayInk: clayInk ?? this.clayInk,
        claySoft: claySoft ?? this.claySoft,
        clayLine: clayLine ?? this.clayLine,
        danger: danger ?? this.danger,
        dangerSoft: dangerSoft ?? this.dangerSoft,
        warn: warn ?? this.warn,
        warnSoft: warnSoft ?? this.warnSoft,
        band: band ?? this.band,
        bandInk: bandInk ?? this.bandInk,
        bandMuted: bandMuted ?? this.bandMuted,
        shadow: shadow ?? this.shadow,
      );

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      brightness: t < 0.5 ? brightness : other.brightness,
      paper: c(paper, other.paper),
      paper2: c(paper2, other.paper2),
      paper3: c(paper3, other.paper3),
      card: c(card, other.card),
      ink: c(ink, other.ink),
      ink2: c(ink2, other.ink2),
      ink3: c(ink3, other.ink3),
      rule: c(rule, other.rule),
      ruleStrong: c(ruleStrong, other.ruleStrong),
      pine: c(pine, other.pine),
      pineHover: c(pineHover, other.pineHover),
      pineInk: c(pineInk, other.pineInk),
      pineSoft: c(pineSoft, other.pineSoft),
      pineLine: c(pineLine, other.pineLine),
      onPine: c(onPine, other.onPine),
      clay: c(clay, other.clay),
      clayInk: c(clayInk, other.clayInk),
      claySoft: c(claySoft, other.claySoft),
      clayLine: c(clayLine, other.clayLine),
      danger: c(danger, other.danger),
      dangerSoft: c(dangerSoft, other.dangerSoft),
      warn: c(warn, other.warn),
      warnSoft: c(warnSoft, other.warnSoft),
      band: c(band, other.band),
      bandInk: c(bandInk, other.bandInk),
      bandMuted: c(bandMuted, other.bandMuted),
      shadow: c(shadow, other.shadow),
    );
  }
}

extension PaletteContext on BuildContext {
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ??
      (Theme.of(this).brightness == Brightness.dark ? AppPalette.dark : AppPalette.light);
}
