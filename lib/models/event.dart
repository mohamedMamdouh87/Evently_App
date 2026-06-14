class Event {
  static const String collectionName='events';
  String id;
  int selectedIndex;
  DateTime eventDate;
  String eventTime;
  bool isFavourite;
  String title;
  String description;
  Event({ this.id='',required this.selectedIndex,required this.eventDate,required this.eventTime, this.isFavourite=false,required this.title,required this.description});
  //todo:change to Json
Map<String,dynamic> toJson(){
  return{
    'id':id,
    'selectedIndex':selectedIndex,
    'eventDate':eventDate.millisecondsSinceEpoch,
    'eventTime':eventTime,
    'isFavourite':isFavourite,
    'title':title,
    'description':description,
  };
}
//todo:change from Json
Event.fromJson(Map<String,dynamic> data):this(
  title:data['title'] ,
  description: data['description'],
  eventDate: DateTime.fromMillisecondsSinceEpoch(data['eventDate']),
  selectedIndex:data['selectedIndex'] ,
  eventTime: data['eventTime'],
  id: data['id'],
  isFavourite: data['isFavourite'],
);
}