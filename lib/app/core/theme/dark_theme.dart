// dark_theme.dart
import 'package:flutter/material.dart';
import ' summer_colors.dart';
import 'summer_text_style.dart';

class DarkTheme {
  // Dark theme color variations based on your pattern
  static const Color _darkPrimary = SummerColors.color4;
  static const Color _darkPrimaryContainer = SummerColors.color6;
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkSurfaceVariant = Color(0xFF2D2D2D);
  static const Color _darkTextPrimary = Color(0xFFE0E0E0);
  static const Color _darkTextSecondary = Color(0xFFA0A0A0);

  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimary,
        onPrimary: _darkBackground,
        primaryContainer: _darkPrimaryContainer,
        onPrimaryContainer: _darkTextPrimary,
        secondary: SummerColors.color5,
        onSecondary: _darkBackground,
        background: _darkBackground,
        onBackground: _darkTextPrimary,
        surface: _darkSurface,
        onSurface: _darkTextPrimary,
        surfaceVariant: _darkSurfaceVariant,
        onSurfaceVariant: _darkTextSecondary,
        error: Color(0xFFCF6679),
      ),
      textTheme: _buildTextTheme(),
      appBarTheme: _buildAppBarTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      cardTheme: _buildCardTheme(),
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(),
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      displayLarge: SummerTextStyle.displayLarge.copyWith(
        color: _darkTextPrimary,
      ),
      displayMedium: SummerTextStyle.displayMedium.copyWith(
        color: _darkTextPrimary,
      ),
      displaySmall: SummerTextStyle.displaySmall.copyWith(
        color: _darkTextPrimary,
      ),
      headlineLarge: SummerTextStyle.headingLarge.copyWith(
        color: _darkTextPrimary,
      ),
      headlineMedium: SummerTextStyle.headingMedium.copyWith(
        color: _darkTextPrimary,
      ),
      headlineSmall: SummerTextStyle.headingSmall.copyWith(
        color: _darkTextPrimary,
      ),
      titleLarge: SummerTextStyle.headingSmall.copyWith(
        color: _darkTextPrimary,
      ),
      titleMedium: SummerTextStyle.bodyLarge.copyWith(
        color: _darkTextPrimary,
      ),
      titleSmall: SummerTextStyle.bodyMedium.copyWith(
        color: _darkTextPrimary,
      ),
      bodyLarge: SummerTextStyle.bodyLarge.copyWith(
        color: _darkTextPrimary,
      ),
      bodyMedium: SummerTextStyle.bodyMedium.copyWith(
        color: _darkTextPrimary,
      ),
      bodySmall: SummerTextStyle.bodySmall.copyWith(
        color: _darkTextSecondary,
      ),
      labelLarge: SummerTextStyle.labelLarge.copyWith(
        color: _darkTextSecondary,
      ),
      labelMedium: SummerTextStyle.labelMedium.copyWith(
        color: _darkTextSecondary,
      ),
      labelSmall: SummerTextStyle.labelSmall.copyWith(
        color: _darkTextSecondary,
      ),
    );
  }

  static AppBarTheme _buildAppBarTheme() {
    return const AppBarTheme(
      backgroundColor: _darkSurface,
      foregroundColor: _darkTextPrimary,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _darkTextPrimary,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: _darkSurfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkPrimary, width: 2),
      ),
      labelStyle: SummerTextStyle.bodyMedium.copyWith(
        color: _darkTextSecondary,
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkPrimary,
        foregroundColor: _darkBackground,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: SummerTextStyle.buttonLarge.copyWith(
          color: _darkBackground,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static CardThemeData _buildCardTheme() {
    return CardThemeData(
      color: _darkSurfaceVariant,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static BottomNavigationBarThemeData _buildBottomNavigationBarTheme() {
    return const BottomNavigationBarThemeData(
      backgroundColor: _darkSurface,
      selectedItemColor: _darkPrimary,
      unselectedItemColor: _darkTextSecondary,
    );
  }
}
