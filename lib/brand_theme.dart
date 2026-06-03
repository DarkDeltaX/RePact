import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'brand_config.dart';

class BrandTheme {
  /// Custom Focus Outline Border
  static OutlinedBorder focusBorder(BuildContext context) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
      side: BorderSide(color: BrandColors.focus, width: 2.5),
    );
  }

  /// Visual Focus Ring Decoration for Custom Widgets
  static BoxDecoration focusDecoration(bool hasFocus) {
    return BoxDecoration(
      border: hasFocus
          ? Border.all(color: BrandColors.focus, width: 2.5)
          : Border.all(color: Colors.transparent, width: 2.5),
      borderRadius: BorderRadius.circular(4),
    );
  }

  /// Generates the Light Theme
  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: ColorScheme.light(
        primary: BrandColors.primary,
        secondary: BrandColors.secondary,
        surface: BrandColors.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: BrandColors.textMain,
        error: BrandColors.alert,
      ),
      scaffoldBackgroundColor: BrandColors.background,
      focusColor: BrandColors.focus,

      // Accessibility configuration: Custom Button Themes
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: BrandColors.textMain,
          side: BorderSide(color: BrandColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BrandColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: BrandColors.primary,
          padding: const EdgeInsets.all(8),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),

      // Configure Card Themes
      cardTheme: CardThemeData(
        color: BrandColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: BrandColors.textMuted.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),

      // Set up premium typography
      textTheme: TextTheme(
        // Luxury serif display for headlines
        displayLarge: GoogleFonts.playfairDisplay(
          color: BrandColors.textMain,
          fontWeight: FontWeight.w700,
          fontSize: 48,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          color: BrandColors.textMain,
          fontWeight: FontWeight.w600,
          fontSize: 36,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          color: BrandColors.textMain,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),
        // Modern geometric sans-serif for UI
        titleLarge: GoogleFonts.outfit(
          color: BrandColors.textMain,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 0.5,
        ),
        titleMedium: GoogleFonts.outfit(
          color: BrandColors.textMain,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          letterSpacing: 0.5,
        ),
        titleSmall: GoogleFonts.outfit(
          color: BrandColors.textMain,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        // Body typography using Inter for ultra-readability
        bodyLarge: GoogleFonts.inter(
          color: BrandColors.textMain,
          fontSize: 16,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          color: BrandColors.textMuted,
          fontSize: 14,
          height: 1.5,
        ),
        bodySmall: GoogleFonts.inter(
          color: BrandColors.textMuted,
          fontSize: 12,
        ),
      ),
    );
  }

  /// Generates the Dark Theme (Optional toggle for high contrast/dark mode users)
  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      colorScheme: ColorScheme.dark(
        primary: BrandColors.primaryDark,
        secondary: BrandColors.secondaryDark,
        surface: BrandColors.surfaceDark,
        onPrimary: BrandColors.backgroundDark,
        onSecondary: BrandColors.backgroundDark,
        onSurface: BrandColors.textMainDark,
        error: BrandColors.alert,
      ),
      scaffoldBackgroundColor: BrandColors.backgroundDark,
      focusColor: BrandColors.focus,

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: BrandColors.textMainDark,
          side: BorderSide(color: BrandColors.primaryDark, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BrandColors.primaryDark,
          foregroundColor: BrandColors.backgroundDark,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: BrandColors.primaryDark,
          padding: const EdgeInsets.all(8),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),

      cardTheme: CardThemeData(
        color: BrandColors.surfaceDark,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: BrandColors.textMutedDark.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),

      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          color: BrandColors.textMainDark,
          fontWeight: FontWeight.w700,
          fontSize: 48,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          color: BrandColors.textMainDark,
          fontWeight: FontWeight.w600,
          fontSize: 36,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          color: BrandColors.textMainDark,
          fontWeight: FontWeight.w600,
          fontSize: 28,
        ),
        titleLarge: GoogleFonts.outfit(
          color: BrandColors.textMainDark,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 0.5,
        ),
        titleMedium: GoogleFonts.outfit(
          color: BrandColors.textMainDark,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          letterSpacing: 0.5,
        ),
        titleSmall: GoogleFonts.outfit(
          color: BrandColors.textMainDark,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        bodyLarge: GoogleFonts.inter(
          color: BrandColors.textMainDark,
          fontSize: 16,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          color: BrandColors.textMutedDark,
          fontSize: 14,
          height: 1.5,
        ),
        bodySmall: GoogleFonts.inter(
          color: BrandColors.textMutedDark,
          fontSize: 12,
        ),
      ),
    );
  }
}
