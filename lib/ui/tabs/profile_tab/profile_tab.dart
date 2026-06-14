import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/evently_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../../providers/event_provider.dart';
import '../../../providers/language_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/evently_routes.dart';
import '../../../utils/evently_size.dart';
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    var langProvider=Provider.of<LanguageProvider>(context);
    var themeProvider=Provider.of<ThemeProvider>(context);
    var userProvider=Provider.of<UserProvider>(context);
    var eventProvider=Provider.of<EventProvider>(context);
    if(userProvider.currentUser==null){
      return Center(child: CircularProgressIndicator(
        color: themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.main_dark_blue,
      ),);
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.height*0.05,
        horizontal: context.width*0.05
      ),
      child: Column(
        spacing: context.height*0.01,
        children: [
          CircleAvatar(backgroundImage: AssetImage(EventlyAssets.route),
          radius: 50,
          ),
          Text(userProvider.currentUser!.name,
          style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(userProvider.currentUser!.email,
          style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: context.height*0.05,),
          Container(
            decoration: BoxDecoration(
              color: themeProvider.themeMode==ThemeMode.light?EventlyColors.white_color:EventlyColors.dark_listTile,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color:themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.main_dark_blue,
              )
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: context.width*0.02
              ),
              title: Text('dark_mode'.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
            ),
              trailing: Switch(
                activeThumbColor:EventlyColors.white_color ,
                activeTrackColor:EventlyColors.main_dark_blue ,
                inactiveThumbColor:EventlyColors.white_color ,
                inactiveTrackColor: EventlyColors.switch_grey,
                trackOutlineColor:  WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return EventlyColors.switch_grey;
                  }
                  return Colors.transparent;
                }),
                value: themeProvider.themeMode==ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.themeMode==ThemeMode.dark?themeProvider.ChangeThemeMode(ThemeMode.light):themeProvider.ChangeThemeMode(ThemeMode.dark);
                }
              )
          )
          ),
          SizedBox(height: context.height*0.008),
          Container(
              decoration: BoxDecoration(
                  color: themeProvider.themeMode==ThemeMode.light?EventlyColors.white_color:EventlyColors.dark_listTile,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.main_dark_blue,
                  )
              ),
              child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: context.width*0.02
                  ),
                  title: Text('language'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: DropdownButton<String>(
                    icon: Icon(Icons.arrow_forward_ios_rounded,
                    color: EventlyColors.main_dark_blue,),
                    underline: SizedBox(),
                    value: langProvider.lang=='en'? 'English':'Arabic',
                    selectedItemBuilder: (context) {
                      return [
                        Visibility(
                          visible: false,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Text('English'),
                        ),
                        Visibility(
                          visible: false,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Text('Arabic'),
                        ),
                      ];
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'English',
                        child: Text('english'.tr(),
                        )),
                      DropdownMenuItem(
                          value: 'Arabic',
                          child: Text('arabic'.tr())),
                    ], onChanged: (String? value) { 
                      if(value=='English'){
                        langProvider.changeLang('en');
                        context.setLocale(Locale('en'));
                      }else{
                        langProvider.changeLang('ar');
                        context.setLocale(Locale('ar'));
                      }
                  },
                  )
              )
          ),
          SizedBox(height: context.height*0.008),
          Container(
              decoration: BoxDecoration(
                  color: themeProvider.themeMode==ThemeMode.light?EventlyColors.white_color:EventlyColors.dark_listTile,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.main_dark_blue,
                  )
              ),
              child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: context.width*0.02
                  ),
                  title: Text('logout'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: IconButton(
                    onPressed: (){
                      userProvider.currentUser = null;
                      eventProvider.selectedIndex=0;
                      signOut(context);
                      Navigator.of(context).pushReplacementNamed(EventlyRoutes.loginScreen);
                    },
                    icon:Icon( Icons.logout,
                  color: Colors.red,))
              )
          )
        ],
      ),
    );
  }
  Future<void> signOut(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    await GoogleSignIn.instance.signOut();
  }
}