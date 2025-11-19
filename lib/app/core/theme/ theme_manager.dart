// theme_manager.dart
import 'package:flutter/material.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

enum AppTheme { light, dark, blue }

class ThemeManager with ChangeNotifier {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  AppTheme _currentTheme = AppTheme.light;

  AppTheme get currentTheme => _currentTheme;

  void setTheme(AppTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  void toggleTheme() {
    _currentTheme =
        _currentTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    notifyListeners();
  }

  ThemeData get currentThemeData {
    switch (_currentTheme) {
      case AppTheme.light:
        return LightTheme.themeData;
      case AppTheme.dark:
        return DarkTheme.themeData;

      case AppTheme.blue:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
