import 'package:flutter/material.dart';
import '../prefs/lang_pref.dart';
class LanguageProvider extends ChangeNotifier {
  String lang;
  LanguageProvider({required this.lang});
  void changeLang(String newLang){
    if(newLang==lang)
      {
        return;
      }
    lang=newLang;
    LangPref.saveLang(lang=='ar');
    notifyListeners();
  }
}