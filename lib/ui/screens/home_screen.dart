import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/ui/tabs/Favourite_tab/favourite_tab.dart';
import 'package:evently/ui/tabs/home_tab/home_tab.dart';
import 'package:evently/ui/tabs/profile_tab/profile_tab.dart';
import 'package:evently/utils/evently_assets.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/evently_size.dart';
import '../../utils/evently_styles.dart';
class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  List<Widget>tabs=[
    const HomeTab(),
    const FavouriteTab(),
    const ProfileTab(),
  ];
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<UserProvider>().initUser();
    });
  }
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    var langProvider=Provider.of<LanguageProvider>(context);
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
        ),
        child: BottomNavigationBar(
            selectedLabelStyle:EventlyStyles.regular14grey.copyWith(
                fontSize: 12,
                color: themeProvider.themeMode==ThemeMode.dark?EventlyColors.main_dark_blue:EventlyColors.main_blue
            ) ,
            unselectedLabelStyle:EventlyStyles.regular14grey.copyWith(
                fontSize: 12,
                color: EventlyColors.disable
            ) ,
            currentIndex:selectedIndex ,
            onTap: (index) {
              selectedIndex=index;
              setState(() {
              });
            },
            items: [
              buildBottomNavigationBarItem(Icon(Icons.home), Icon(Icons.home_outlined), 'home'.tr()),
              buildBottomNavigationBarItem(Icon(Icons.favorite), Icon(Icons.favorite_outline), 'favorites'.tr()),
              buildBottomNavigationBarItem(Icon(Icons.person), Icon(Icons.person_outline), 'profile'.tr()),
            ]),
      ) ,
      body: SafeArea(
        child: Stack(
          children: [
            tabs[selectedIndex],
            Align(alignment:langProvider.lang=='en'? AlignmentGeometry.bottomRight:AlignmentGeometry.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.height*0.02,
                    horizontal: context.width*0.06
                  ),
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    backgroundColor: themeProvider.themeMode==ThemeMode.dark?EventlyColors.main_dark_blue:EventlyColors.main_blue ,
                    child: Icon(Icons.add,
                    color: EventlyColors.white_color,
                    size: 30,),
                      onPressed: (){
                    Navigator.of(context).pushReplacementNamed(EventlyRoutes.addEventScreen);
                  }),
                )),
          ],
        ),
      ),
    );
  }
  BottomNavigationBarItem buildBottomNavigationBarItem(Widget selectedIcon,Widget unselectedIcon,String label){
    return BottomNavigationBarItem(
      icon: unselectedIcon,
      activeIcon: selectedIcon,
      label: label,
    );
  }
}