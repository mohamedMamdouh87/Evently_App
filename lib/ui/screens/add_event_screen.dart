import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/ui/widgets/customed_text_form_field.dart';
import 'package:evently/ui/widgets/event_date_time.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/evently_assets.dart';
import '../../utils/evently_resources.dart';
import '../../utils/evently_size.dart';
import '../../utils/evently_styles.dart';
import '../widgets/customized_elevated_button.dart';
import '../widgets/selected_unselected_style.dart';
class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});
  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}
class _AddEventScreenState extends State<AddEventScreen> {
  int selectedIndex=0;
  DateTime? eventDate;
  String dateFormatted='';
  TimeOfDay? eventTime;
  String timeFormatted='';
  String title='';
  String description='';
  bool isDateValid=true;
  bool isTimeValid=true;
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeProvider>(context);
    var langProvider=Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal:context.width*0.04 ,
          vertical: context.height*0.06
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
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
                    SizedBox(width: context.width*0.25,),
                    Text('add_event'.tr(),style: Theme.of(context).textTheme.displayMedium,),
                  ],
                ),
                SizedBox(height: context.height*0.02,),
                Container(
                  height: context.height*0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image:DecorationImage(fit: BoxFit.fill,
                        image: AssetImage(themeProvider.themeMode==ThemeMode.light?EventlyResources.Addimages[selectedIndex]:EventlyResources.AddDarkimages[selectedIndex])),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    border: Border.all(
                      color: themeProvider.themeMode==ThemeMode.light?EventlyColors.lightStroke:EventlyColors.dark_stroke,
                    )
                  ),
                ),
                SizedBox(height:context.height*0.02,),
                SizedBox(
                  height: context.height*0.05,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            selectedIndex=index;
                            setState(() {
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: context.height*0.01,
                                horizontal: context.width*0.02
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                color:selectedItem(index, themeProvider,selectedIndex)
                            ),
                            child: Row(
                              spacing: context.width*0.02,
                              children: [
                                selectedAddIcon(index, themeProvider,selectedIndex),
                                Text(EventlyResources.AddEventListView[index].tr(),
                                    style: selectedText(index, themeProvider,selectedIndex))
                              ],
                            ),
                          ),
                        );
                      }
                      , separatorBuilder:(context, index) => SizedBox(
                    width: context.width*0.02,
                  )
                      , itemCount: EventlyResources.AddEventListView.length),
                ),
                SizedBox(height:context.height*0.02,),
                Align(alignment: langProvider.lang=='en'? Alignment.centerLeft:Alignment.centerRight,
                    child: Text('title'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,)),
                SizedBox(height:context.height*0.01,),
                CustomedTextFormField(hintText: 'event_title'.tr(),
                onChanged: (text){
                  title=text;
                },
                onValidator: (text){
                  if(text==null||text.trim().isEmpty){
                    return 'please_enter_title'.tr();
                  }else{
                    return null;
                  }
                },),
                SizedBox(height:context.height*0.02,),
                Align(alignment: langProvider.lang=='en'? Alignment.centerLeft:Alignment.centerRight,
                    child: Text('description'.tr(),
                      style: Theme.of(context).textTheme.bodySmall,)),
                SizedBox(height:context.height*0.01,),
                CustomedTextFormField(hintText: 'event_description'.tr(),maxLines: 4,
                onChanged: (text){
                  description=text;
                },
                  onValidator: (text){
                    if(text==null||text.trim().isEmpty){
                      return 'please_enter_description'.tr();
                    }else{
                      return null;
                    }
                  },),
                SizedBox(height:context.height*0.01,),
               EventDateTime(isError: !isDateValid
                   ,icon: Icons.calendar_month_outlined,text:'event_date'.tr(), text1:  eventDate == null
                   ? (isDateValid ? 'choose_date'.tr() : 'please_select_date'.tr())
                   : dateFormatted,onPressed: () {
                setEventDate();
               }),
                SizedBox(height:context.height*0.01,),
                EventDateTime(isError: !isTimeValid
                ,icon: Icons.access_time_outlined,text: 'event_time'.tr(),text1:eventTime == null
                    ? (isTimeValid ? 'choose_time'.tr() : 'please_select_time'.tr())
                    : timeFormatted,onPressed:setEventTime),
                SizedBox(height: context.height*0.01,),
                CustomizedElevatedButton(onPressed:addEvent
                  ,child: Text('add_event'.tr(),
                  style: EventlyStyles.bold20white.copyWith(
                      fontWeight: FontWeight.w500,
                    fontSize: 16
                  ),
                ),),

              ],
            ),
          ),
        ),
      ),
    );
  }
  void setEventDate() async{
 var date=await showDatePicker(context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)));
 eventDate=date;
 isDateValid=true;
if(eventDate!=null){
  dateFormatted=DateFormat('d MMM yyyy').format(eventDate!);
}
setState(() {

});
  }
  void setEventTime() async{
var time= await showTimePicker(context: context, initialTime: TimeOfDay.now());
eventTime=time ;
isTimeValid=true;
if(eventTime!=null){
  timeFormatted=time!.format(context);
}
setState(() {

});
  }
  void addEvent() async {
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    setState(() {
      isDateValid = eventDate != null;
      isTimeValid = eventTime != null;
    });

    bool isFormValid = formKey.currentState?.validate() ?? false;

    if (!isFormValid || !isDateValid || !isTimeValid) {
      return;
    }
    if (formKey.currentState?.validate()==true) {
      Event event = Event(
        selectedIndex: selectedIndex,
        eventDate: eventDate!,
        eventTime: timeFormatted,
        description: description,
        title: title,
      );
      FirebaseUtils.addEvent(event,userProvider.currentUser!.id).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('event_added_successfully'.tr())),
        );
        Navigator.of(context).pushReplacementNamed(EventlyRoutes.homeScreen);
      });
    }
  }
}