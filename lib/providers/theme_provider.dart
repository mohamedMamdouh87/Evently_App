import 'package:evently/prefs/theme_pref.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode;
  ThemeProvider({required this.themeMode});
  void ChangeThemeMode(ThemeMode newMode) {
    if(newMode==themeMode)
    {
      return;
    }
    themeMode=newMode;
    ThemePref.saveTheme(newMode==ThemeMode.dark);
    notifyListeners();
  }
}