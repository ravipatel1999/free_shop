// lib/core/utils/logger.dart
import 'dart:developer';

class AppLogger {
  static void info(String message) {
    assert(() {
      log('ℹ️ $message');
      return true;
    }());
  }

  static void error(String message) {
    assert(() {
      log('❌ $message');
      return true;
    }());
  }

  static void debug(String message) {
    assert(() {
      log('🐛 $message');
      return true;
    }());
  }

  static void warning(String message) {
    assert(() {
      log('⚠️ $message');
      return true;
    }());
  }
}
