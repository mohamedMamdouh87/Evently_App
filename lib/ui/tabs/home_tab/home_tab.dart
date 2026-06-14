import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/tabs/home_tab/display_event_list.dart';
import 'package:evently/utils/evently_resources.dart';
import 'package:evently/utils/evently_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/event_provider.dart';
import '../../../providers/language_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/evently_assets.dart';
import '../../../utils/evently_routes.dart';
import '../../../utils/evently_size.dart';
import '../../widgets/selected_unselected_style.dart';
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<HomeTab> createState() => _HomeTabState();
}
class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    var langProvider=Provider.of<LanguageProvider>(context);
    var eventProvider=Provider.of<EventProvider>(context);
    var userProvider=Provider.of<UserProvider>(context);
    if(userProvider.currentUser==null){
      return Center(child: CircularProgressIndicator(
        color: themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.main_dark_blue,
      ),);
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.width*0.04
      ),
      child: Column(
        children: [
          SizedBox(height: context.height*0.05,),
          Row(
            children: [
              Column(
                spacing: context.height*0.008,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('welcome_back'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,),
                  Text(userProvider.currentUser!.name,
                  style: Theme.of(context).textTheme.bodyLarge,),
                ],
              ),
              Spacer(),
              themeProvider.themeMode==ThemeMode.light?Icon(Icons.light_mode_outlined,size: 30,color: EventlyColors.main_blue,):Icon(Icons.dark_mode_outlined,size: 30,color:EventlyColors.main_dark_blue ,),
              SizedBox(width: context.width*0.02,),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width*0.02,
                  vertical: context.height*0.01
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.main_dark_blue,
                ),
                child: Text(langProvider.lang=='en'?'EN':'AR',
                style: EventlyStyles.bold20white.copyWith(
                  fontSize: 14
                ),),
              )
            ],
          ),
          SizedBox(height:context.height*0.05,),
          SizedBox(
            height: context.height*0.05,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
           return GestureDetector(
                onTap: (){
                  eventProvider.updateIndex(index);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: context.height*0.01,
                    horizontal: context.width*0.02
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color:selectedItem(index, themeProvider,eventProvider.selectedIndex)
                  ),
                  child: Row(
                    spacing: context.width*0.02,
                    children: [
                     selectedIcon(index, themeProvider,eventProvider.selectedIndex),
                      Text(EventlyResources.TexthomeListView[index].tr(),
                      style: selectedText(index, themeProvider, eventProvider.selectedIndex))
                    ],
                  ),
                ),
              );
            }
                , separatorBuilder:(context, index) => SizedBox(
                  width: context.width*0.02,
                )
                , itemCount: EventlyResources.TexthomeListView.length),
          ),
          SizedBox(height: context.height*0.05,),
          Expanded(child: DisplayEventList(selectedIndex: eventProvider.selectedIndex,))
        ],
      ),
    );
  }
}