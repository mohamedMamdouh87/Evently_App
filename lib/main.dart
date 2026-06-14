import 'package:easy_localization/easy_localization.dart';
import 'package:evently/prefs/lang_pref.dart';
import 'package:evently/prefs/login_register_pref.dart';
import 'package:evently/prefs/theme_pref.dart';
import 'package:evently/prefs/welcome_pref.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/screens/add_event_screen.dart';
import 'package:evently/ui/screens/edit_event_screen.dart';
import 'package:evently/ui/screens/event_details_screen.dart';
import 'package:evently/ui/screens/home_screen.dart';
import 'package:evently/ui/screens/login_screen.dart';
import 'package:evently/ui/screens/register_screen.dart';
import 'package:evently/ui/screens/reset_password.dart';
import 'package:evently/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:evently/utils/evently_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final isDark = await ThemePref.getTheme();
  final lang = await LangPref.getLang();
  final isSeenWelcome = await WelcomePref.isSeenWelcome();
  final isSeenLoginRegister = await LoginRegisterPref.isSeenLoginRegister();
  runApp( EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LanguageProvider(lang: lang == true ? 'ar' : 'en')),
            ChangeNotifierProvider(create: (context) => ThemeProvider(themeMode:isDark == true ? ThemeMode.dark : ThemeMode.light,)),
            ChangeNotifierProvider(create: (context) => EventProvider()),
            ChangeNotifierProvider(create: (context) => UserProvider()),
          ],
          child: MyApp(isSeenWelcome: isSeenWelcome!,
          isSeenLoginRegister: isSeenLoginRegister!,))));
}

class MyApp extends StatelessWidget {
 final bool isSeenWelcome;
 final bool isSeenLoginRegister;
  const MyApp({super.key,required this.isSeenWelcome,required this.isSeenLoginRegister});
  @override
  Widget build(BuildContext context) {
    var langProvider=Provider.of<LanguageProvider>(context);
    var themeProvider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: langProvider.lang=='en'?Locale('en'):Locale('ar'),
      initialRoute: firsScreen(),
      routes: {
        EventlyRoutes.welcomeScreen: (context) =>  WelcomeScreen(),
        EventlyRoutes.homeScreen: (context) => const HomeScreen(),
        EventlyRoutes.addEventScreen: (context) => AddEventScreen(),
        EventlyRoutes.loginScreen: (context) =>  LoginScreen(),
        EventlyRoutes.registerScreen: (context) =>  RegisterScreen(),
        EventlyRoutes.eventDetailsScreen: (context) =>  EventDetailsScreen(),
        EventlyRoutes.editEventScreen: (context) =>  EditEventScreen(),
        EventlyRoutes.resetPassword: (context) =>  ResetPassword(),
      },
      theme:lightTheme ,
      darkTheme:darkTheme ,
      themeMode:themeProvider.themeMode ,
    );
  }
  String firsScreen(){
    if(isSeenWelcome){
      if(isSeenLoginRegister){
       return EventlyRoutes.homeScreen;
      }else{
      return  EventlyRoutes.loginScreen;
      }
    }
    return EventlyRoutes.welcomeScreen;
  }
}