// light_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import ' summer_colors.dart';
import 'summer_text_style.dart';

class LightTheme {
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: SummerColors.primary,
        onPrimary: SummerColors.textLight,
        primaryContainer: SummerColors.primaryLight,
        onPrimaryContainer: SummerColors.primaryDark,
        secondary: SummerColors.secondary,
        onSecondary: SummerColors.textLight,
        secondaryContainer: SummerColors.color6,
        onSecondaryContainer: SummerColors.textPrimary,
        background: SummerColors.background,
        onBackground: SummerColors.textPrimary,
        surface: SummerColors.surface,
        onSurface: SummerColors.textPrimary,
        surfaceVariant: SummerColors.surfaceVariant,
        onSurfaceVariant: SummerColors.textSecondary,
        error: SummerColors.error,
        onError: SummerColors.textLight,
        outline: SummerColors.borderLight,
        outlineVariant: SummerColors.borderDark,
      ),
      textTheme: _buildTextTheme(),
      appBarTheme: _buildAppBarTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      cardTheme: _buildCardTheme(),
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(),
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(),
      snackBarTheme: _buildSnackBarTheme(),
      dialogTheme: _buildDialogTheme(),
      chipTheme: _buildChipTheme(),
      dividerTheme: _buildDividerTheme(),
      progressIndicatorTheme: _buildProgressIndicatorTheme(),
    );
  }

  static TextTheme _buildTextTheme() {
    // ignore: prefer_const_constructors
    return TextTheme(
      displayLarge: SummerTextStyle.displayLarge,
      displayMedium: SummerTextStyle.displayMedium,
      displaySmall: SummerTextStyle.displaySmall,
      headlineLarge: SummerTextStyle.headingLarge,
      headlineMedium: SummerTextStyle.headingMedium,
      headlineSmall: SummerTextStyle.headingSmall,
      titleLarge: SummerTextStyle.headingSmall,
      titleMedium: SummerTextStyle.bodyLarge,
      titleSmall: SummerTextStyle.bodyMedium,
      bodyLarge: SummerTextStyle.bodyLarge,
      bodyMedium: SummerTextStyle.bodyMedium,
      bodySmall: SummerTextStyle.bodySmall,
      labelLarge: SummerTextStyle.labelLarge,
      labelMedium: SummerTextStyle.labelMedium,
      labelSmall: SummerTextStyle.labelSmall,
    );
  }

  static AppBarTheme _buildAppBarTheme() {
    return AppBarTheme(
      backgroundColor: SummerColors.primary,
      foregroundColor: SummerColors.textLight,
      elevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: SummerColors.textLight,
      ),
      iconTheme: IconThemeData(
        size: 16.sp,
        color: SummerColors.textLight,
      ),
      actionsIconTheme: IconThemeData(
        size: 16.sp,
        color: SummerColors.textLight,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: SummerColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: SummerColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: SummerColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: SummerColors.primary, width: 2),
      ),
      labelStyle: SummerTextStyle.bodyMedium.copyWith(
        color: SummerColors.textSecondary,
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: SummerColors.primary,
        foregroundColor: SummerColors.textLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: SummerTextStyle.buttonLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: SummerColors.primary,
        textStyle: SummerTextStyle.buttonMedium.copyWith(
          color: SummerColors.primary,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: SummerColors.primary,
        side: const BorderSide(color: SummerColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static CardThemeData _buildCardTheme() {
    return CardThemeData(
      color: SummerColors.surface,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static BottomNavigationBarThemeData _buildBottomNavigationBarTheme() {
    return const BottomNavigationBarThemeData(
      backgroundColor: SummerColors.surface,
      selectedItemColor: SummerColors.primary,
      unselectedItemColor: SummerColors.textSecondary,
      elevation: 8,
    );
  }

  static FloatingActionButtonThemeData _buildFloatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: SummerColors.accent,
      foregroundColor: SummerColors.textPrimary,
    );
  }

  static SnackBarThemeData _buildSnackBarTheme() {
    return SnackBarThemeData(
      backgroundColor: SummerColors.primary,
      contentTextStyle: SummerTextStyle.bodyMedium.copyWith(
        color: SummerColors.textLight,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static DialogThemeData _buildDialogTheme() {
    return DialogThemeData(
      backgroundColor: SummerColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: SummerTextStyle.headingMedium,
      contentTextStyle: SummerTextStyle.bodyMedium,
    );
  }

  static ChipThemeData _buildChipTheme() {
    return ChipThemeData(
      backgroundColor: SummerColors.color8,
      selectedColor: SummerColors.primary,
      labelStyle: SummerTextStyle.labelMedium,
      secondaryLabelStyle: SummerTextStyle.labelMedium.copyWith(
        color: SummerColors.textLight,
      ),
    );
  }

  static DividerThemeData _buildDividerTheme() {
    return const DividerThemeData(
      color: SummerColors.borderLight,
      thickness: 1,
      space: 1,
    );
  }

  static ProgressIndicatorThemeData _buildProgressIndicatorTheme() {
    return const ProgressIndicatorThemeData(
      color: SummerColors.primary,
      linearTrackColor: SummerColors.color8,
    );
  }
}
