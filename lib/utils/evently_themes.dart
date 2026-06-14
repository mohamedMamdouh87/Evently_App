import 'package:evently/utils/evently_assets.dart';
import 'package:evently/utils/evently_styles.dart';
import 'package:flutter/material.dart';
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: EventlyColors.bg_color,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: EventlyColors.white_color,
    selectedItemColor: EventlyColors.main_blue,
    unselectedItemColor: EventlyColors.disable,
  ),
  textTheme: TextTheme(
    bodyLarge: EventlyStyles.bold20black,
    bodyMedium: EventlyStyles.regular14grey,
    bodySmall: EventlyStyles.medium16black,
    displayLarge: EventlyStyles.bold16main_blue,
    displayMedium: EventlyStyles.medium18black,
    displaySmall: EventlyStyles.bold24main,
    headlineLarge: EventlyStyles.regular16grey,
    headlineMedium: EventlyStyles.medium18main,
    headlineSmall: EventlyStyles.medium16black,
    labelLarge: EventlyStyles.medium16disable
  )
);
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor:EventlyColors.darkBg_color,
 bottomNavigationBarTheme: BottomNavigationBarThemeData(
  backgroundColor: EventlyColors.darkBg_color,
  selectedItemColor: EventlyColors.main_dark_blue,
  unselectedItemColor: EventlyColors.disable,
),
    textTheme: TextTheme(
        bodyLarge: EventlyStyles.bold20white,
        bodyMedium: EventlyStyles.regular14dark_grey,
      bodySmall: EventlyStyles.medium16white,
      displayLarge: EventlyStyles.bold16main_dark_blue,
      displayMedium: EventlyStyles.medium18white,
      displaySmall: EventlyStyles.bold24white,
      headlineLarge: EventlyStyles.regular16dark_grey,
      headlineMedium: EventlyStyles.medium18white,
      headlineSmall: EventlyStyles.medium16main_dark_blue,
        labelLarge: EventlyStyles.medium16dark_sec
    )
);