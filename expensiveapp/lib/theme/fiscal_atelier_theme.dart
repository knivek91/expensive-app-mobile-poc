import 'package:flutter/material.dart';

/// Fiscal Atelier Design System Theme
///
/// A financial-focused design system emphasizing clarity, spaciousness,
/// and tonal differentiation over borders and dividers.
///
/// Color Palette:
/// - Primary: #0a8d6a (growth/positive)
/// - Secondary: #597f6e (expense/negative)
/// - Accent: #c4645b (highlight)
/// - Neutral base: #737874
///
/// Key Design Principles:
/// - Tonal layering instead of borders
/// - Floating card design with fully rounded corners
/// - 8px spacing system
/// - No dividers between list items
/// - No pure black text
/// - Editorial numeric input style
class FiscalAtelierTheme {
  FiscalAtelierTheme._();

  // ============================================================
  // COLOR PALETTE
  // ============================================================

  /// Primary color - Represents growth/positive financial states
  /// Usage: Primary actions, positive amounts, income indicators
  static const Color primary = Color(0xFF0a8d6a);

  /// Secondary color - Represents expense/negative financial states
  /// Usage: Secondary actions, expenses, negative balances
  static const Color secondary = Color(0xFF597f6e);

  /// Accent color - Highlights and calls to action
  /// Usage: Accents, warnings, important indicators
  static const Color accent = Color(0xFFc4645b);

  /// Neutral base - Core neutral for text and backgrounds
  static const Color neutralBase = Color(0xFF737874);

  // ============================================================
  // TONAL PALETTE - Derived colors for layering
  // ============================================================

  // Primary tones
  static const Color primaryLight = Color(0xFFa3d9c2);
  static const Color primaryLighter = Color(0xFFd4ede3);
  static const Color primaryDark = Color(0xFF067a53);
  static const Color primaryDarker = Color(0xFF045739);

  // Secondary tones
  static const Color secondaryLight = Color(0xFFb5c9bf);
  static const Color secondaryLighter = Color(0xFFd9e5de);
  static const Color secondaryDark = Color(0xFF3e6151);
  static const Color secondaryDarker = Color(0xFF2c473b);

  // Accent tones
  static const Color accentLight = Color(0xFFdec4c1);
  static const Color accentLighter = Color(0xFFefe1df);
  static const Color accentDark = Color(0xFFa3463c);
  static const Color accentDarker = Color(0xFF7a362e);

  // Neutral tones - Avoid pure black (#000000)
  static const Color neutral100 = Color(0xFFf5f6f6);
  static const Color neutral200 = Color(0xFFe8e9ea);
  static const Color neutral300 = Color(0xFFcdced0);
  static const Color neutral400 = Color(0xFFa8a9ac);
  static const Color neutral500 = Color(0xFF7a7b7e);
  static const Color neutral600 = Color(0xFF5c5d60);
  static const Color neutral700 = Color(0xFF404244);
  static const Color neutral800 = Color(0xFF2b2c2e);
  static const Color neutral900 = Color(0xFF1a1b1c);

  // Semantic colors
  static const Color success = primary;
  static const Color error = secondary;
  static const Color warning = accent;
  static const Color info = Color(0xFF4a7c94);

  // Background colors for card layering
  static const Color surfaceElevated = Color(0xFFffffff);
  static const Color surfaceRaised = Color(0xFFfafbfb);
  static const Color surfaceSubtle = Color(0xFFf3f4f4);
  static const Color surfaceDefault = neutral100;
  static const Color surfaceMuted = neutral200;

  // ============================================================
  // TYPOGRAPHY SCALE
  // ============================================================

  /// Font family for the design system
  static const String fontFamily = 'Inter';

  /// Hero balances - Large display for financial totals
  /// Usage: Main balance display on balance screen
  /// Scale: display-md (36sp), display-lg (45sp)
  static const TextStyle displaySm = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle displayMd = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle displayLg = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
    height: 1.1,
  );

  /// Titles - Section headers and screen titles
  /// Usage: Screen titles, section headers
  /// Scale: headline-sm (24sp)
  static const TextStyle headlineSm = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
  );

  static const TextStyle headlineMd = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
  );

  static const TextStyle headlineLg = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
  );

  /// Transactions - Amount and transaction details
  /// Usage: Transaction amounts, expense details
  /// Scale: title-sm (16sp)
  static const TextStyle titleSm = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const TextStyle titleMd = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const TextStyle titleLg = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
  );

  /// Body text - General content
  static const TextStyle bodySm = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.5,
  );

  static const TextStyle bodyMd = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
    height: 1.5,
  );

  static const TextStyle bodyLg = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
    height: 1.5,
  );

  /// Metadata - Labels, timestamps,辅助信息
  /// Usage: Labels, dates, small辅助信息
  /// Scale: label-md (12sp)
  static const TextStyle labelSm = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static const TextStyle labelMd = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static const TextStyle labelLg = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // ============================================================
  // SPACING SYSTEM - 8px base
  // ============================================================

  /// Base unit for spacing system
  static const double spaceUnit = 8.0;

  /// Spacing values following 8px grid
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space56 = 56.0;
  static const double space64 = 64.0;
  static const double space80 = 80.0;
  static const double space96 = 96.0;

  /// Common layout paddings
  static const double paddingScreenHorizontal = 20.0;
  static const double paddingScreenVertical = 24.0;
  static const double paddingCard = 16.0;
  static const double paddingItem = 12.0;

  /// Common gaps
  static const double gapListItem = 12.0;
  static const double gapSection = 32.0;
  static const double gapCard = 16.0;

  // ============================================================
  // BORDER RADIUS - Floating card design
  // ============================================================

  /// Fully rounded (pill-like) corners for floating cards
  static const double radiusFull = 999.0;

  /// Large radius for cards
  static const double radiusLg = 24.0;

  /// Medium radius for inputs and buttons
  static const double radiusMd = 16.0;

  /// Small radius for small elements
  static const double radiusSm = 12.0;

  /// Extra small radius
  static const double radiusXs = 8.0;

  // ============================================================
  // SHADOWS - Elevation through shadows, not borders
  // ============================================================

  /// Subtle elevation for cards on surface
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: neutral900.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  /// Floating card with more elevation
  static List<BoxShadow> get floatingCardShadow => [
    BoxShadow(
      color: neutral900.withValues(alpha: 0.12),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  /// Elevated items (FAB, dialogs)
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: neutral900.withValues(alpha: 0.16),
      blurRadius: 32,
      offset: const Offset(0, 12),
    ),
  ];

  // ============================================================
  // THEME DATA - Flutter ThemeData
  // ============================================================

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: Colors.white,
        primaryContainer: primaryLighter,
        onPrimaryContainer: primaryDarker,
        secondary: secondary,
        onSecondary: Colors.white,
        secondaryContainer: secondaryLighter,
        onSecondaryContainer: secondaryDarker,
        tertiary: accent,
        onTertiary: Colors.white,
        tertiaryContainer: accentLighter,
        onTertiaryContainer: accentDarker,
        error: error,
        onError: Colors.white,
        surface: surfaceDefault,
        onSurface: neutral800,
        surfaceContainerHighest: surfaceElevated,
        onSurfaceVariant: neutral600,
        outline: neutral300,
        outlineVariant: neutral200,
      ),

      // Scaffold
      scaffoldBackgroundColor: surfaceDefault,

      // AppBar - Minimal, tonal design
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: surfaceDefault,
        foregroundColor: neutral800,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: headlineSm.copyWith(color: neutral800),
        iconTheme: const IconThemeData(color: neutral700),
      ),

      // Card - Floating design, no borders
      cardTheme: CardThemeData(
        elevation: 0,
        color: surfaceElevated,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        margin: EdgeInsets.zero,
      ),

      // Elevated card - For interactive items
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return primaryDark;
            } else if (states.contains(WidgetState.hovered)) {
              return primaryDark;
            } else if (states.contains(WidgetState.disabled)) {
              return neutral300;
            }
            return primary;
          }),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusMd),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            titleSm.copyWith(color: Colors.white),
          ),
        ),
      ),

      // Filled button (primary action)
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: titleSm.copyWith(color: Colors.white),
          elevation: 0,
        ),
      ),

      // Soft container button (secondary action) - handled via button style
      // Use FilledButton.tonal for secondary actions in widgets

      // Outlined button (secondary outline)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          side: const BorderSide(color: primaryLight, width: 1.5),
          textStyle: titleSm.copyWith(color: primary),
        ),
      ),

      // Text button (tertiary action)
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: titleSm.copyWith(color: primary),
        ),
      ),

      // Input decoration - Editorial numeric style
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceSubtle,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: space20,
          vertical: space16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        labelStyle: bodyMd.copyWith(color: neutral500),
        hintStyle: bodyMd.copyWith(color: neutral400),
        errorStyle: labelMd.copyWith(color: error),
      ),

      // List tile - No dividers, use spacing
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: space20,
          vertical: space8,
        ),
        minVerticalPadding: space12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        tileColor: Colors.transparent,
      ),

      // Floating action button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceElevated,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        titleTextStyle: headlineSm.copyWith(color: neutral800),
        contentTextStyle: bodyMd.copyWith(color: neutral600),
      ),

      // Bottom sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surfaceElevated,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: neutral800,
        contentTextStyle: bodyMd.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Divider - AVOID using; use spacing instead
      // This is set to transparent to discourage use
      dividerTheme: const DividerThemeData(
        color: Colors.transparent,
        thickness: 0,
        space: 0,
      ),

      // Icon
      iconTheme: const IconThemeData(color: neutral600, size: 24),

      // Text theme
      textTheme: TextTheme(
        displayLarge: displayLg.copyWith(color: neutral800),
        displayMedium: displayMd.copyWith(color: neutral800),
        displaySmall: displaySm.copyWith(color: neutral800),
        headlineLarge: headlineLg.copyWith(color: neutral800),
        headlineMedium: headlineMd.copyWith(color: neutral800),
        headlineSmall: headlineSm.copyWith(color: neutral800),
        titleLarge: titleLg.copyWith(color: neutral800),
        titleMedium: titleMd.copyWith(color: neutral800),
        titleSmall: titleSm.copyWith(color: neutral800),
        bodyLarge: bodyLg.copyWith(color: neutral700),
        bodyMedium: bodyMd.copyWith(color: neutral700),
        bodySmall: bodySm.copyWith(color: neutral600),
        labelLarge: labelLg.copyWith(color: neutral600),
        labelMedium: labelMd.copyWith(color: neutral500),
        labelSmall: labelSm.copyWith(color: neutral500),
      ),
    );
  }

  // ============================================================
  // HELPER METHODS
  // ============================================================

  /// Get tonal background color for card elevation level
  static Color getCardBackgroundColor(int elevation) {
    switch (elevation) {
      case 0:
        return surfaceElevated;
      case 1:
        return surfaceRaised;
      case 2:
        return surfaceSubtle;
      default:
        return surfaceElevated;
    }
  }

  /// Get financial amount color based on positive/negative
  static Color getAmountColor(bool isPositive) {
    return isPositive ? primary : secondary;
  }

  /// Format currency amount for display
  static String formatCurrency(int amountInCents, {String symbol = '\$'}) {
    final amount = amountInCents / 100;
    final isNegative = amount < 0;
    final absAmount = amount.abs();
    final formatted = absAmount.toStringAsFixed(2);
    return isNegative ? '-$symbol$formatted' : '$symbol$formatted';
  }
}
