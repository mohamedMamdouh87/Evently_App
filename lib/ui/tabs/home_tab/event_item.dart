import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/event.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/evently_assets.dart';
import '../../../utils/evently_resources.dart';
import '../../../utils/evently_routes.dart';
import '../../../utils/evently_size.dart';
class EventItem extends StatelessWidget {
final  Event event;
final Function(Event) onFavouriteToggle;
 const  EventItem({super.key,required this.event,required this.onFavouriteToggle});
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
  String eventImage=themeProvider.themeMode==ThemeMode.light?EventlyResources.Addimages[event.selectedIndex]:EventlyResources.AddDarkimages[event.selectedIndex];
    return  GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(EventlyRoutes.eventDetailsScreen,
            arguments: event);
      },
      child: Container(
        height: context.height*0.3,
        width: context.width*0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border:Border.all(
              color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
            ),
            image: DecorationImage(image: AssetImage(eventImage),
                fit: BoxFit.fill)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: context.width*0.02,
                vertical: context.width*0.02,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: context.height*0.01,
                    horizontal: context.width*0.01
                ),
                decoration: BoxDecoration(
                    color: themeProvider.themeMode==ThemeMode.light?EventlyColors.bg_color:EventlyColors.darkBg_color,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                    )
                ),
                child: Text(DateFormat('d MMM').format(event.eventDate),
                  style: Theme.of(context).textTheme.displayLarge,),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.width*0.02,
                vertical: context.width*0.02,),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: context.height*0.01,
                    horizontal: context.width*0.01
                ),
                decoration: BoxDecoration(
                    color: themeProvider.themeMode==ThemeMode.light?EventlyColors.bg_color:EventlyColors.darkBg_color,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(event.title,
                        maxLines: 4,
                        style: Theme.of(context).textTheme.displayLarge,),
                    ),
                    IconButton(
                        onPressed: (){
                          onFavouriteToggle(event);
                        },
                        icon: Icon(event.isFavourite?Icons.favorite:
                          Icons.favorite_outline,
                          color:themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.main_dark_blue,size: 30,))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
