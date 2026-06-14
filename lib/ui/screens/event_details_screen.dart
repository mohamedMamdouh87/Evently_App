import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/evently_assets.dart';
import '../../utils/evently_resources.dart';
import '../../utils/evently_size.dart';
import '../../utils/firebase_utils.dart';
class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});
  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}
class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    var langProvider=Provider.of<LanguageProvider>(context);
    var args=ModalRoute.of(context)!.settings.arguments as Event?;
    var userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(
            horizontal:context.width*0.04 ,
            vertical: context.height*0.06
        ),
        child: Column(
          children: [
            Row(
              spacing: context.width*0.02,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacementNamed(EventlyRoutes.homeScreen);
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
                SizedBox(width: langProvider.lang=='en'? context.width*0.13:context.width*0.15,),
                Text('event_details'.tr(),style: Theme.of(context).textTheme.displayMedium,),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    //todo:edit event
                    Navigator.of(context).pushReplacementNamed(EventlyRoutes.editEventScreen,
                    arguments:args);
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
                    child: Icon(Icons.edit,
                      color:themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.white_color,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    //todo:delete event
                   FirebaseUtils.deleteEvent(args!.id,userProvider.currentUser!.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('event_deleted_successfully'.tr())),
                    );
                    Navigator.of(context).pushReplacementNamed(EventlyRoutes.homeScreen);
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
                    child: Icon(Icons.delete,
                      color:Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.height*0.02,),
            Container(
              height: context.height*0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  image:DecorationImage(fit: BoxFit.fill,
                      image: AssetImage(themeProvider.themeMode==ThemeMode.light?EventlyResources.Addimages[args!.selectedIndex]:EventlyResources.AddDarkimages[args!.selectedIndex])),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                    color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                  )
              ),
            ),
            SizedBox(height:context.height*0.02,),
            Align(alignment: langProvider.lang=='en'? Alignment.centerLeft:Alignment.centerRight,
                child: Text(args.title,style: Theme.of(context).textTheme.displayMedium,)),
            SizedBox(height:context.height*0.01,),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: context.height*0.02,
              ),
              decoration: BoxDecoration(
                color: themeProvider.themeMode==ThemeMode.light?EventlyColors.white_color:EventlyColors.dark_listTile,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                border: Border.all(
                  color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                )
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: context.width*0.02,),
              child: Row(
                spacing: context.width*0.04,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.width*0.02,
                        vertical: context.height*0.01
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color:themeProvider.themeMode==ThemeMode.light?EventlyColors.bg_color:EventlyColors.dark_listTile,
                        border: Border.all(
                          color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                        )
                    ),
                    child: Icon(Icons.calendar_month_outlined,
                      color:themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.main_dark_blue,
                    ),
                  ),
                  Column(children: [
                    Text(DateFormat('dd MMMM').format(args.eventDate),style: Theme.of(context).textTheme.headlineSmall),
                    Text(args.eventTime,style: Theme.of(context).textTheme.labelLarge),
                  ],)
                ],
              ),
            ),
            ),
            SizedBox(height:context.height*0.02,),
            Align(alignment: langProvider.lang=='en'? Alignment.centerLeft:Alignment.centerRight,
                child: Text('description'.tr(),
                  style: Theme.of(context).textTheme.bodySmall,)),
            SizedBox(height:context.height*0.01,),
            Container(
              width: double.infinity,
                height: context.height*0.2,
                padding: EdgeInsets.symmetric(
                  horizontal: context.width*0.02,
                  vertical: context.height*0.02,
                ),
                decoration: BoxDecoration(
                    color: themeProvider.themeMode==ThemeMode.light?EventlyColors.white_color:EventlyColors.dark_listTile,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    border: Border.all(
                      color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                    )
                ),
                child: Text(
                  args.description,style: Theme.of(context).textTheme.bodyMedium,)),
          ],
        ),
      ),
    );
  }
}