import 'package:evently/utils/evently_assets.dart';
import 'package:evently/utils/evently_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/evently_size.dart';
typedef OnClicked = void Function();
class EventDateTime extends StatelessWidget{
      IconData icon;
      String text;
      String text1;
      OnClicked? onPressed;
      final bool isError;
      EventDateTime({required this.icon, required this.text,required this.text1,this.onPressed,this.isError=false});
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
      return Row( spacing: context.width*0.01,
      children: [
      Icon(icon,
      color:themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.main_dark_blue ,size: 30,),
      Text(text,
      style: Theme.of(context).textTheme.bodySmall,),
      Spacer(),
      TextButton(onPressed: onPressed,
      child: Text(text1,
      style: TextStyle(
        decoration: TextDecoration.underline,
        decorationColor: isError
            ? Colors.red
            : (themeProvider.themeMode == ThemeMode.light
            ? EventlyColors.main_blue
            : EventlyColors.main_dark_blue),
        decorationThickness: 2,
        decorationStyle: TextDecorationStyle.solid,
        color: isError
            ? Colors.red
            : (themeProvider.themeMode == ThemeMode.light
            ? EventlyColors.main_blue
            : EventlyColors.main_dark_blue),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ))),
      ],
      );
  }
}