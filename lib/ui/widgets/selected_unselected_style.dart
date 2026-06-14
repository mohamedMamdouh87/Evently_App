import 'dart:ui';

import 'package:flutter/material.dart';

import '../../providers/theme_provider.dart';
import '../../utils/evently_assets.dart';
import '../../utils/evently_resources.dart';
import '../../utils/evently_styles.dart';

Color selectedItem(int index,ThemeProvider themeProvider,int selectedIndex) {
  if (selectedIndex == index) {
    if (themeProvider.themeMode == ThemeMode.light) {
      return EventlyColors.main_blue;
    } else {
      return EventlyColors.main_dark_blue;
    }
  }
  return themeProvider.themeMode == ThemeMode.light ? EventlyColors
      .white_color : EventlyColors.dark_stroke;
}
Widget selectedIcon(int index,ThemeProvider themeProvider,int selectedIndex) {
  if (selectedIndex == index) {
    return EventlyResources.SelectedhomeListViewIcons[index];
  } else {
    if (themeProvider.themeMode == ThemeMode.light) {
      return EventlyResources.UnselectedhomeListViewIcons[index];
    } else {
      return EventlyResources.UnselectedDarkhomeListViewIcons[index];
    }
  }
}
TextStyle selectedText(int index,ThemeProvider themeProvider,int selectedIndex) {
  if (selectedIndex == index) {
    return EventlyStyles.medium16white;
  }else {
    if(themeProvider.themeMode==ThemeMode.light){
      return EventlyStyles.medium16black;
    }else{
      return EventlyStyles.medium16white;
    }
  }
}
Widget selectedAddIcon(int index,ThemeProvider themeProvider,int selectedIndex) {
  if (selectedIndex == index) {
    return EventlyResources.SelectedAddEventListViewIcons[index];
  } else {
    if (themeProvider.themeMode == ThemeMode.light) {
      return EventlyResources.UnselectedAddEventListViewIcons[index];
    } else {
      return EventlyResources.UnselectedDarkAddEventListViewIcons[index];
    }
  }
}
Color selectedItem1(int index,ThemeProvider themeProvider,int selectedIndex) {
  if (selectedIndex == index) {
    if (themeProvider.themeMode == ThemeMode.light) {
      return EventlyColors.main_blue;
    } else {
      return EventlyColors.main_dark_blue;
    }
  }
  return themeProvider.themeMode == ThemeMode.light ? EventlyColors
      .white_color : EventlyColors.dark_listTile;
}