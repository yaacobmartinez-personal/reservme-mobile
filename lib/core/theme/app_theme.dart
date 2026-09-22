import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

import 'palette.dart';
import 'spacing.dart';
import 'typography.dart';

/// Light and dark themes built from one [AppPalette] each. Widgets read
/// colours through `context.palette`; the Material theme below exists so the
/// stock widgets (dialogs, pickers, snackbars) match without per-use styling.
///
/// [accent] lets a customer-facing screen re-tint the accent to the venue's
/// theme (see `venue_accent.dart`); everything else stays.
abstract final class AppTheme {
  static ThemeData light({AppPalette? palette}) => _build(palette ?? AppPalette.light);
  static ThemeData dark({AppPalette? palette}) => _build(palette ?? AppPalette.dark);

  static ThemeData _build(AppPalette p) {
    final scheme = ColorScheme(
      brightness: p.brightness,
      primary: p.pine,
      onPrimary: p.onPine,
      primaryContainer: p.pineSoft,
      onPrimaryContainer: p.pineInk,
      secondary: p.clay,
      onSecondary: p.isDark ? p.onPine : Colors.white,
      secondaryContainer: p.claySoft,
      onSecondaryContainer: p.clayInk,
      tertiary: p.warn,
      onTertiary: p.paper,
      tertiaryContainer: p.warnSoft,
      onTertiaryContainer: p.warn,
      error: p.danger,
      onError: p.isDark ? p.onPine : Colors.white,
      errorContainer: p.dangerSoft,
      onErrorContainer: p.danger,
      surface: p.card,
      onSurface: p.ink,
      onSurfaceVariant: p.ink2,
      outline: p.rule,
      outlineVariant: p.rule,
      surfaceContainerHighest: p.paper3,
      surfaceContainerHigh: p.paper3,
      surfaceContainer: p.paper2,
      surfaceContainerLow: p.paper,
      surfaceContainerLowest: p.card,
      inverseSurface: p.ink,
      onInverseSurface: p.paper,
      inversePrimary: p.pineInk,
      shadow: p.shadow,
      scrim: p.band,
    );

    final text = AppType.textTheme(p.ink, p.ink2);
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: AppType.family,
      textTheme: text,
      scaffoldBackgroundColor: p.paper,
      splashFactory: InkSparkle.splashFactory,
      extensions: [p],
      // Shared-axis pushes on Android; iOS keeps its swipe-back Cupertino push.
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: p.paper,
          ),
          TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: const CupertinoPageTransitionsBuilder(),
        },
      ),
    );

    final card = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Radii.card),
      side: BorderSide(color: p.rule),
    );
    final sheet = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.sheet)),
    );
    OutlineInputBorder inputBorder(Color color, [double width = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: color, width: width),
        );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: p.paper,
        foregroundColor: p.ink,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppType.displayS.copyWith(color: p.ink, fontSize: 20),
        iconTheme: IconThemeData(color: p.ink),
      ),
      cardTheme: CardThemeData(
        color: p.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: card,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.card,
        contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.x4, vertical: 14),
        border: inputBorder(p.rule),
        enabledBorder: inputBorder(p.rule),
        focusedBorder: inputBorder(p.pine, 2),
        errorBorder: inputBorder(p.danger),
        focusedErrorBorder: inputBorder(p.danger, 2),
        disabledBorder: inputBorder(p.rule),
        labelStyle: AppType.label.copyWith(color: p.ink2),
        floatingLabelStyle: AppType.label.copyWith(color: p.ink2),
        hintStyle: AppType.bodyL.copyWith(color: p.ink3),
        helperStyle: AppType.caption.copyWith(color: p.ink3),
        errorStyle: AppType.caption.copyWith(color: p.danger),
        prefixStyle: AppType.bodyL.copyWith(color: p.ink3),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: p.pine,
          foregroundColor: p.onPine,
          disabledBackgroundColor: p.paper3,
          disabledForegroundColor: p.ink3,
          minimumSize: const Size.fromHeight(48),
          shape: const StadiumBorder(),
          textStyle: AppType.button,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: p.ink,
          backgroundColor: p.card,
          minimumSize: const Size.fromHeight(48),
          side: BorderSide(color: p.rule),
          shape: const StadiumBorder(),
          textStyle: AppType.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: p.pine,
          shape: const StadiumBorder(),
          textStyle: AppType.button,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: p.ink),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: p.pine,
        foregroundColor: p.onPine,
        elevation: 4,
        highlightElevation: 2,
        shape: const StadiumBorder(),
        extendedTextStyle: AppType.button,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        side: BorderSide(color: p.ruleStrong, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.pine : Colors.transparent,
        ),
        checkColor: WidgetStateProperty.all(p.onPine),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(p.card),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.pine : p.ruleStrong,
        ),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? p.pine : p.ruleStrong,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          // Material defaults the selected fill to secondaryContainer (clay);
          // the design calls for pine-soft.
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? p.pineSoft : p.card,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? p.pineInk : p.ink2,
          ),
          side: WidgetStateProperty.all(BorderSide(color: p.rule)),
          textStyle: WidgetStateProperty.all(AppType.buttonS),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: p.paper2,
        selectedColor: p.ink,
        labelStyle: AppType.buttonS.copyWith(color: p.ink),
        secondaryLabelStyle: AppType.buttonS.copyWith(color: p.paper),
        shape: const StadiumBorder(),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: Spacing.x3, vertical: Spacing.x2),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: p.ink,
        contentTextStyle: AppType.bodyStrong.copyWith(color: p.paper, fontSize: 14),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
        insetPadding: const EdgeInsets.all(Spacing.gutter),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.paper,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.xl)),
        titleTextStyle: AppType.displayM.copyWith(color: p.ink, fontSize: 22),
        contentTextStyle: AppType.body.copyWith(color: p.ink2),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.paper,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: p.paper,
        shape: sheet,
        showDragHandle: true,
        dragHandleColor: p.ruleStrong,
        dragHandleSize: const Size(40, 4),
        clipBehavior: Clip.antiAlias,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: p.card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.lg),
          side: BorderSide(color: p.rule),
        ),
        textStyle: AppType.body.copyWith(color: p.ink),
      ),
      dividerTheme: DividerThemeData(color: p.rule, space: 1, thickness: 1),
      listTileTheme: ListTileThemeData(
        iconColor: p.ink3,
        textColor: p.ink,
        titleTextStyle: AppType.bodyStrong.copyWith(color: p.ink),
        subtitleTextStyle: AppType.caption.copyWith(color: p.ink3),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: p.pine,
        linearTrackColor: p.rule,
        circularTrackColor: Colors.transparent,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: p.paper,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.xl)),
        headerBackgroundColor: p.pineInk,
        headerForegroundColor: p.paper,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: p.paper,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.xl)),
        hourMinuteShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
        dayPeriodShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: p.ink,
          borderRadius: BorderRadius.circular(Radii.sm),
        ),
        textStyle: AppType.bodyS.copyWith(color: p.paper),
      ),
    );
  }
}
