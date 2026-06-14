import 'package:shared_preferences/shared_preferences.dart';
class LangPref {
  static const String langKey='lang_key';
  static Future<void> saveLang(bool isArabic) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(langKey, isArabic);
  }
  static Future<bool?> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(langKey);
  }
}