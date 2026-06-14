import 'package:evently/utils/evently_assets.dart';
import 'package:evently/utils/evently_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
class CustomizedElevatedButton extends StatelessWidget {
  VoidCallback? onPressed;
  Widget child;
 CustomizedElevatedButton({super.key,this.onPressed,required this.child});
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    return SizedBox(width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.main_dark_blue),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            )),
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
              horizontal: context.width*0.01,
              vertical: context.height*0.012,
            ))
          ),
          onPressed:onPressed , child: child),
    );
  }
}
class CustomizedElevatedButton2 extends StatelessWidget {
  VoidCallback? onPressed;
  Widget child;
  CustomizedElevatedButton2({super.key,this.onPressed,required this.child});
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    return SizedBox(width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(themeProvider.themeMode==ThemeMode.light?EventlyColors.white_color:EventlyColors.dark_listTile),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                )
              )),
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                horizontal: context.width*0.01,
                vertical: context.height*0.012,
              ))
          ),
          onPressed:onPressed , child: child),
    );
  }
}