import 'package:shared_preferences/shared_preferences.dart';

class ThemePref {
  static const String themeKey = "isDark";


  static Future<void> saveTheme(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDark);
  }


  static Future<bool?> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey);
  }
}
