import 'package:flutter/material.dart';
import ' summer_colors.dart';

class SummerTextStyle {
  // Static versions for ThemeData (without context)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: SummerColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: SummerColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.2,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: SummerColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle headingLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: SummerColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: SummerColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: SummerColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: SummerColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: SummerColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: SummerColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: SummerColors.textLight,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: SummerColors.textSecondary,
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: SummerColors.textSecondary,
    height: 1.4,
  );

  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: SummerColors.textLight,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: SummerColors.textLight,
    height: 1.4,
    letterSpacing: 0.3,
  );

  // Responsive versions for widgets (with context)
  static TextStyle responsiveDisplayLarge(BuildContext context) {
    final baseSize = _isTablet(context) ? 42.0 : 36.0;
    return displayLarge.copyWith(fontSize: baseSize);
  }

  static TextStyle responsiveDisplayMedium(BuildContext context) {
    final baseSize = _isTablet(context) ? 32.0 : 28.0;
    return displayMedium.copyWith(fontSize: baseSize);
  }

  static TextStyle responsiveDisplaySmall(BuildContext context) {
    final baseSize = _isTablet(context) ? 26.0 : 22.0;
    return displaySmall.copyWith(fontSize: baseSize);
  }

  static TextStyle responsiveHeadingLarge(BuildContext context) {
    final baseSize = _isTablet(context) ? 24.0 : 20.0;
    return headingLarge.copyWith(fontSize: baseSize);
  }

  static TextStyle responsiveHeadingMedium(BuildContext context) {
    final baseSize = _isTablet(context) ? 20.0 : 18.0;
    return headingMedium.copyWith(fontSize: baseSize);
  }

  static TextStyle responsiveHeadingSmall(BuildContext context) {
    final baseSize = _isTablet(context) ? 18.0 : 16.0;
    return headingSmall.copyWith(fontSize: baseSize);
  }

  static TextStyle responsiveBodyLarge(BuildContext context) {
    final baseSize = _isTablet(context) ? 17.0 : 16.0;
    return bodyLarge.copyWith(fontSize: baseSize);
  }

  static TextStyle responsiveBodyMedium(BuildContext context) {
    final baseSize = _isTablet(context) ? 15.0 : 14.0;
    return bodyMedium.copyWith(fontSize: baseSize);
  }

  static TextStyle responsiveBodySmall(BuildContext context) {
    final baseSize = _isTablet(context) ? 13.0 : 12.0;
    return bodySmall.copyWith(fontSize: baseSize);
  }

  static bool _isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }
}
