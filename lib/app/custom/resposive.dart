import 'package:flutter/material.dart';

class ResponsiveTextScale {
  static double getTextScaleFactor(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width < 400) return 0.8; // Small mobile
    if (width < 600) return 1.0; // Normal mobile
    if (width < 900) return 1.2; // Large mobile/Tablet
    if (width < 1200) return 1.4; // Small desktop/Tablet
    return 1.6; // Large desktop
  }

  static double getScaledFontSize(BuildContext context, double baseSize) {
    return baseSize * getTextScaleFactor(context);
  }

  // Screen size breakpoints
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;
}
