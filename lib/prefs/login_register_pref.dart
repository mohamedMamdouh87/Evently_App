import 'package:shared_preferences/shared_preferences.dart';

class LoginRegisterPref {
  static const loginRegisterKey='login_registerKey';

  static Future<void> setLoginRegister(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loginRegisterKey, value);
  }


  static Future<bool?> isSeenLoginRegister() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginRegisterKey)??false;
  }
}