import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/event.dart';
import 'package:evently/ui/tabs/home_tab/event_item.dart';
import 'package:evently/ui/widgets/customed_text_form_field.dart';
import 'package:evently/utils/evently_size.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/event_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/evently_assets.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  List<Event> favouriteList = [];
  List<Event> eventList = [];
  late EventProvider eventProvider;
  var searchController=TextEditingController();
  @override
  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      getFavouriteList();
    });

    Future.microtask(() {
      getFavouriteList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    eventProvider=Provider.of<EventProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width*0.02,
        vertical: context.height*0.02,
      ),
      child: Column(
        children: [
          SizedBox(height:context.height*0.04 ,),
        CustomedTextFormField(
          textEditingController:searchController ,
          hintText: 'search_for_event'.tr(),suffixIcon: Icon(Icons.search),
        iconColor:themeProvider.themeMode==ThemeMode.light?EventlyColors.main_blue:EventlyColors.main_dark_blue ,
        ),
     SizedBox(height:context.height*0.04 ,),
     Expanded(
       child: favouriteList.isEmpty?Center(child: Text('no_events_found'.tr(),style: Theme.of(context).textTheme.bodyLarge,)):
      ListView.separated(itemBuilder: (context, index) {
        return EventItem(event: favouriteList[index],onFavouriteToggle: updateIsFavourite,);
           }
          , separatorBuilder:(context, index) =>  SizedBox(height: context.height*0.03)
          , itemCount: favouriteList.length),
     )
        ],
      ),
    );
  }
  Future<List<Event>> getALLEvents() async{
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    if (userProvider.currentUser == null) return [];
    var querySnapshot= await FirebaseUtils.getEventsCollection(userProvider.currentUser!.id).orderBy('eventDate').get();
    eventList= querySnapshot.docs.map((event) {
      return event.data();
    },).toList();
    setState(() {

    });
    return eventList;
  }
  Future<List<Event>> filterEvents(int index) async{
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    if (userProvider.currentUser == null) return [];
    var querySnapshots= await FirebaseUtils.getEventsCollection(userProvider.currentUser!.id).orderBy('eventDate').where('selectedIndex',isEqualTo: index).get();
    eventList=querySnapshots.docs.map((event) =>event.data() ,).toList();
    setState(() {

    });
    return eventList;
  }
  void updateIsFavourite(Event event) {
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    if (userProvider.currentUser == null) return;
    FirebaseUtils
        .getEventsCollection(userProvider.currentUser!.id)
        .doc(event.id)
        .update({'isFavourite': !event.isFavourite}).then ((value) {
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('event_updated_successfully'.tr())),
        );
        eventProvider.selectedIndex==0 ?
        getALLEvents()  :
        filterEvents(eventProvider.selectedIndex-1);
        getFavouriteList();
      }
        },);
  }
  Future<void> getFavouriteList() async {
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    if (userProvider.currentUser == null) return;
    var snapQuery = await FirebaseUtils
        .getEventsCollection(userProvider.currentUser!.id)
        .where('isFavourite', isEqualTo: true)
        .orderBy('eventDate')
        .get();

    List<Event> allFavourites =
    snapQuery.docs.map((doc) => doc.data()).toList();

    setState(() {
      if (searchController.text.isEmpty) {
        favouriteList = allFavourites;
      } else {
        favouriteList = allFavourites.where((event) {
          return event.title
              .toLowerCase()
              .contains(searchController.text.toLowerCase());
        }).toList();
      }
    });
  }
}