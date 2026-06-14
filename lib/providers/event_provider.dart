import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  int selectedIndex=0;
  void updateIndex(int index){
    selectedIndex=index;
    notifyListeners();
  }
}