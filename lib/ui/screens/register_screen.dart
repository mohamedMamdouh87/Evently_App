import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/widgets/customed_text_form_field.dart';
import 'package:evently/ui/widgets/customized_elevated_button.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/show_dialogue_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/myuser.dart';
import '../../prefs/login_register_pref.dart';
import '../../providers/event_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/evently_assets.dart';
import '../../utils/evently_size.dart';
import '../../utils/evently_styles.dart';
import '../../utils/evently_routes.dart';
import '../../utils/sign_in.dart';
class RegisterScreen extends StatefulWidget {
   const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  bool isHidden=true;
  bool isHidden1=true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var langProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.height * 0.08, horizontal: context.width * 0.04),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: context.height * 0.02,
                children: [
                  themeProvider.themeMode == ThemeMode.light
                      ? Image.asset(EventlyAssets.evently)
                      : Image.asset(EventlyAssets.dark_evently),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  Align(
                    alignment: langProvider.lang == 'en'
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      'create_account'.tr(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  CustomedTextFormField(
                    textEditingController:nameController ,
                      onValidator: (text){
                      if(text==null||text.trim().isEmpty){
                        return 'enter_name'.tr();
                      }
                      return null;
                      },
                      hintText: 'enter_name'.tr(),
                      prefixIcon: Icon(
                        Icons.person_outline,
                      )),
                      CustomedTextFormField(
                        textEditingController:emailController ,
                        textInputType: TextInputType.emailAddress ,
                        onValidator: (text){
                          if(text==null||text.trim().isEmpty){
                            return 'enter_email'.tr();
                          }
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'enter_valid_email'.tr();
                          }
                          return null;

                        },
                        hintText: 'enter_email'.tr(),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                      ),
                  CustomedTextFormField(
                    hide: isHidden,
                    textEditingController:passwordController ,
                    onValidator: (text){
                      if(text==null||text.trim().isEmpty){
                        return 'enter_password'.tr();
                      }
                      final bool passwordValid =
                      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(text);
                      if (!passwordValid) {
                        return 'enter_valid_password'.tr();
                      }
                      return null;
                    },
                    hintText: 'enter_password'.tr(),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                    ),
                    suffixIcon: IconButton(
                      onPressed: (){
                        isHidden=!isHidden;
                        setState(() {
                        });
                      },
                      icon: isHidden? Icon(Icons.visibility_off_outlined):Icon(Icons.visibility_outlined),
                    ),
                  ),
                  CustomedTextFormField(
                    hide: isHidden1,
                    textEditingController: confirmPasswordController,
                    onValidator: (text){
                      if(text==null||text.trim().isEmpty){
                        return 'enter_password'.tr();
                      }
                      if(text!=passwordController.text){
                        return 'password_match'.tr();
                      }
                      return null;
                    },
                    hintText: 'confirm_password'.tr(),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                    ),
                    suffixIcon: IconButton(
                      onPressed: (){
                        isHidden1=!isHidden1;
                        setState(() {
                        });
                      },
                      icon: isHidden1? Icon(Icons.visibility_off_outlined):Icon(Icons.visibility_outlined),
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  CustomizedElevatedButton(
                    onPressed: register,
                      child: Text(
                        'sign_up'.tr(),
                        style: EventlyStyles.bold20white.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('already_have_account'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed((EventlyRoutes.loginScreen));
                          },
                          style: TextButton.styleFrom(
                            padding:  EdgeInsets.symmetric(horizontal: context.width*0.01),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: Size.zero,
                          ),
                          child: Text(
                            'login'.tr(),
                            style: themeProvider.themeMode == ThemeMode.light
                                ? EventlyStyles.regular14main_blue.copyWith(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold)
                                : EventlyStyles.regular14main_dark_blue.copyWith(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Divider(
                        color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                        endIndent: context.width*0.04,
                      )),
                      Text('or'.tr(),
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.w500
                        ),),
                      Expanded(child: Divider(
                        color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                        indent: context.width*0.04,
                      ))
                    ],
                  ),
                  CustomizedElevatedButton2(
                      onPressed: signInWithGoogle,
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: context.width*0.04,
                    children: [
                      Image.asset(EventlyAssets.google),
                      Text('sign_up_with_google'.tr(),
                        style: EventlyStyles.bold20white.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 16,
                            color: themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.main_dark_blue),)
                    ],
                  )
              ),
              ]
              ),
            ),
          )
        ),
      ),
    );
  }
  void register() async{
    UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);
    EventProvider eventProvider=Provider.of<EventProvider>(context,listen: false);
    if(formKey.currentState?.validate()==true){
      ShowDialogueUtils.showLoading(context);
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser user=MyUser(id: credential.user?.uid??'', name: nameController.text, email: emailController.text);
        await FirebaseUtils.addUser(user);
        ShowDialogueUtils.hideLoading(context);
        ShowDialogueUtils.showMessage(context, 'register_successfully'.tr(),
       action:  () {
         eventProvider.selectedIndex=0;
          Navigator.of(context).pushReplacementNamed(EventlyRoutes.homeScreen);
        },);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ShowDialogueUtils.hideLoading(context);
          ShowDialogueUtils.showMessage(context, 'weak_password'.tr());
        } else if (e.code == 'email-already-in-use') {
          ShowDialogueUtils.hideLoading(context);
          ShowDialogueUtils.showMessage(context, 'email_already_in_use'.tr());
        }
      } catch (e) {
        ShowDialogueUtils.hideLoading(context);
        ShowDialogueUtils.showMessage(context, 'something_went_wrong'.tr());
      }
    }
    LoginRegisterPref.setLoginRegister(true);
  }
  Future<void> signInWithGoogle() async {
    try {
      User? user = await GoogleAuthUtils.signInWithGoogle(context);
      if (user == null) return;
      final myUser = MyUser(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );
      await FirebaseUtils.addUser(myUser);
      UserProvider userProvider =
      Provider.of<UserProvider>(context, listen: false);
      EventProvider eventProvider=Provider.of<EventProvider>(context,listen: false);
      userProvider.setUser(myUser);
      eventProvider.selectedIndex=0;
      LoginRegisterPref.setLoginRegister(true);
      Navigator.of(context).pushReplacementNamed(
        EventlyRoutes.homeScreen,
      );

    } catch (e) {
      ShowDialogueUtils.showMessage(context, e.toString());
    }
  }
}

