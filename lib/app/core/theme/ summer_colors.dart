// summer_colors.dart
import 'package:flutter/material.dart';

class SummerColors {
  // Your provided color pattern
  static const Color color0 = Color(0xFF0d47a1);
  static const Color color1 = Color(0xFF295aac);
  static const Color color2 = Color(0xFF406db6);
  static const Color color3 = Color(0xFF577fc0);
  static const Color color4 = Color(0xFF6e91ca);
  static const Color color5 = Color(0xFF85a3d3);
  static const Color color6 = Color(0xFF9db5dc);
  static const Color color7 = Color(0xFFb5c7e5);
  static const Color color8 = Color(0xFFcddaee);
  static const Color color9 = Color(0xFFe6ecf7);

  // Semantic color mapping
  static const Color primaryDark = color0;
  static const Color primary = color2;
  static const Color primaryLight = color4;
  static const Color secondary = color3;
  static const Color accent = color5;
  static const Color background = color9;
  static const Color surface = Colors.white;
  static const Color surfaceVariant = color8;

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Colors.white;

  // Functional Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = color2;

  // Border Colors
  static const Color borderLight = color7;
  static const Color borderDark = color5;

  // Get all colors as list
  static List<Color> get colorPalette => [
        color0,
        color1,
        color2,
        color3,
        color4,
        color5,
        color6,
        color7,
        color8,
        color9,
      ];

  // Gradients
  static LinearGradient get primaryGradient {
    return const LinearGradient(
      colors: [primaryDark, primaryLight],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient get accentGradient {
    return const LinearGradient(
      colors: [color2, color5, color7],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static LinearGradient get fullSpectrumGradient {
    return const LinearGradient(
      colors: [color0, color2, color4, color6, color8],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
