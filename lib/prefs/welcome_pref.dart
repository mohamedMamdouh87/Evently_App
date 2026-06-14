import 'package:shared_preferences/shared_preferences.dart';

class WelcomePref {
  static const welcomeKey='welcome_key';

  static Future<void> setWelcome(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(welcomeKey, value);
  }


  static Future<bool?> isSeenWelcome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(welcomeKey)??false;
  }
}