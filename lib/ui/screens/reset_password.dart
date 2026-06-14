import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/widgets/customized_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/evently_assets.dart';
import '../../utils/evently_routes.dart';
import '../../utils/evently_size.dart';
import '../../utils/evently_styles.dart';
class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    var args=ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        body: Padding(
            padding:  EdgeInsets.symmetric(
                horizontal:context.width*0.04 ,
                vertical: context.height*0.06
            ),
            child: SingleChildScrollView(
              child: Column(
                  children: [
              Row(
              children: [
              GestureDetector(
              onTap: (){
                          Navigator.of(context).pushReplacementNamed(EventlyRoutes.loginScreen);
                          },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width*0.02,
                    vertical: context.height*0.01
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color:themeProvider.themeMode==ThemeMode.light?EventlyColors.white_color:EventlyColors.dark_listTile,
                    border: Border.all(
                      color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                    )
                ),
                child: Icon(Icons.arrow_back_ios_new_outlined,
                  color:themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.white_color,
                ),
              ),
                          ),
                          SizedBox(width: context.width*0.17,),
                          Text('forget_password'.tr(),style: Theme.of(context).textTheme.displayMedium,),
                          ],
                        ),
                    SizedBox(height: context.height*0.06,),
                    Image.asset(themeProvider.themeMode==ThemeMode.light?EventlyAssets.reset: EventlyAssets.dark_reset),
                    SizedBox(height: context.height*0.04,),
                    CustomizedElevatedButton(child: Text('reset_password'.tr(),
                    style: EventlyStyles.bold20white.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                    )),
                    onPressed: ()async{
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: args);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('reset_password_successfully'.tr())),
                    );
                    Navigator.of(context).pushReplacementNamed(EventlyRoutes.loginScreen);
                    },)
                    ]
              ),
            )
        )
    );
  }
}
