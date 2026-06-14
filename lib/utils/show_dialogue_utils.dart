import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/evently_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'evently_assets.dart';

class ShowDialogueUtils {
static void showLoading(BuildContext context){
  showDialog(context: context,
      barrierDismissible: false,
      builder: (context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
        return AlertDialog(
          content: Row(
            spacing: context.width*0.08,
            children: [
              CircularProgressIndicator(
                color: themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.main_dark_blue,
              ),
              Text('loading...'.tr(),
              style: Theme.of(context).textTheme.displayLarge,
              )
            ],
          ),
        );
      },);
}
static void hideLoading(BuildContext context){
  Navigator.of(context).pop();
}
static void showMessage(BuildContext context,String message,{VoidCallback? action}){
  showDialog(context: context,
      barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content:Text(message,
        style: Theme.of(context).textTheme.displayLarge,),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
            if(action!=null){
              action();
            }
          }, child: Text('ok'.tr(),
            style: Theme.of(context).textTheme.displayLarge
      ))
        ],
      );
    },);
}
}