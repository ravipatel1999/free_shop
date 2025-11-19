import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferenceUtil {
  static SharedPreferences? _prefs;

  static Future<bool> init() async {
    _prefs = await SharedPreferences.getInstance();
    return true;
  }

  static Future clear() async {
    if (_prefs != null) {
      await _prefs!.clear();
    }
  }

  static Future<bool> setBool(String key, bool value) async {
    if (_prefs == null) await init();
    return _prefs?.setBool(key, value) ?? Future.value(false);
  }

  static bool getBool(String key) {
    if (_prefs == null) return false;
    return _prefs?.getBool(key) ?? false;
  }

  static Future<bool> setString(String key, String value) async {
    if (_prefs == null) await init();
    return _prefs?.setString(key, value) ?? Future.value(false);
  }

  static String getString(String key) {
    if (_prefs == null) return "";
    return _prefs?.getString(key) ?? "";
  }

  static Future<bool> setInt(String key, int value) async {
    if (_prefs == null) await init();
    return _prefs?.setInt(key, value) ?? Future.value(false);
  }

  static int getInt(String key) {
    if (_prefs == null) return 0;
    return _prefs?.getInt(key) ?? 0;
  }

  static Future<bool> setDouble(String key, double value) async {
    if (_prefs == null) await init();
    return _prefs?.setDouble(key, value) ?? Future.value(false);
  }

  static double getDouble(String key) {
    if (_prefs == null) return 0;
    return _prefs?.getDouble(key) ?? 0;
  }

  static Future<bool> setThemeData(String value) async {
    if (_prefs == null) await init();
    return _prefs?.setString('themeData', value) ?? Future.value(false);
  }

  static String getThemeData() {
    if (_prefs == null) return 'primary';
    return _prefs?.getString('themeData') ?? 'primary';
  }
}
