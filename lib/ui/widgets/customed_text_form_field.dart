import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/evently_assets.dart';
import '../../utils/evently_size.dart';
typedef OnChanged = void Function(String);
typedef OnValidator = String? Function(String?)? ;
class CustomedTextFormField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final OnChanged? onChanged;
  final OnValidator? onValidator;
  final int? maxLines;
  final Color iconColor;
  TextEditingController? textEditingController;
  TextInputType textInputType;
  bool hide;
  String obscuringCharacter;

  CustomedTextFormField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.onChanged,
    this.maxLines,
    this.iconColor = EventlyColors.disable,
    this.onValidator,
    this.textEditingController,
    this.textInputType=TextInputType.text,
    this.hide=false,
    this.obscuringCharacter='*'
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return TextFormField(
      obscuringCharacter: obscuringCharacter,
      obscureText:hide ,
      keyboardType:textInputType ,
      controller:textEditingController ,
      maxLines: maxLines ?? 1,
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: onChanged,
      validator:onValidator ,
      decoration: InputDecoration(
        filled: true,
        fillColor: themeProvider.themeMode == ThemeMode.light
            ? EventlyColors.white_color
            : EventlyColors.dark_listTile,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.width*0.02,
          vertical: context.height*0.02,
        ),
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        hintText: hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color:  themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke
            )
        ) ,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color:  themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke
            )
        ) ,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color:  themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke
            )
        ) ,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color:  Colors.red
            ),
        ) ,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color:  Colors.red
          ),
        ) ,
        prefixIcon:prefixIcon ,
        suffixIcon: suffixIcon,
        prefixIconColor:iconColor ,
        suffixIconColor:iconColor ,
      ) ,
      cursorRadius:Radius.circular(16) ,
      autocorrect: true,
      cursorColor:themeProvider.themeMode==ThemeMode.light?EventlyColors.sec_text:EventlyColors.dark_sec_text ,
      cursorErrorColor:Colors.red ,
    );
  }
}