import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/event.dart';
import 'package:evently/utils/evently_size.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import 'event_item.dart';
class DisplayEventList extends StatefulWidget {
 final int selectedIndex;

const DisplayEventList({super.key,required this.selectedIndex});

  @override
  State<DisplayEventList> createState() => _DisplayEventListState();
}

class _DisplayEventListState extends State<DisplayEventList> {
   List<Event> eventList=[];
   List<Event> favouriteList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayEvents();
  }
  @override
  void didUpdateWidget(covariant DisplayEventList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      displayEvents();
    }
  }
  @override
  Widget build(BuildContext context) {
    return eventList.isEmpty?Center(child: Text('no_events_found'.tr(),style: Theme.of(context).textTheme.bodyLarge,)):
    ListView.separated(itemBuilder: (context, index) {
       return EventItem(event: eventList[index],onFavouriteToggle: updateIsFavourite,);
    }
        , separatorBuilder:(context, index) =>  SizedBox(height: context.height*0.03)
        , itemCount: eventList.length);
  }

  Future<List<Event>> getALLEvents() async{
    var userProvider=Provider.of<UserProvider>(context,listen: false);
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
    var querySnapshots= await FirebaseUtils.getEventsCollection(userProvider.currentUser!.id).orderBy('eventDate').where('selectedIndex',isEqualTo: index).get();
    eventList=querySnapshots.docs.map((event) =>event.data() ,).toList();
    setState(() {

    });
    return eventList;
  }
  Future<List<Event>> displayEvents(){
     if(widget.selectedIndex==0){
       return getALLEvents();
     }else{
       return filterEvents(widget.selectedIndex-1);
     }
  }
  void updateIsFavourite(Event event){
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    FirebaseUtils.getEventsCollection(userProvider.currentUser!.id).doc(event.id).update({'isFavourite':!event.isFavourite}).then((value){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('event_updated_successfully'.tr())));
      widget.selectedIndex==0 ?
         getALLEvents()  :
         filterEvents(widget.selectedIndex-1);
      getFavouriteList();
    });

}
  Future<List<Event>> getFavouriteList() async{
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    var snapQuerry = await FirebaseUtils.getEventsCollection(userProvider.currentUser!.id).orderBy('eventDate').where('isFavourite',isEqualTo: true).get();
 favouriteList = snapQuerry.docs.map((doc) => doc.data() ,).toList();
 setState(() {

 });
 return favouriteList;
}
}
