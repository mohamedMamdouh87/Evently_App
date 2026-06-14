import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/evently_assets.dart';
import 'package:flutter/material.dart';
class EventlyResources {
static List<String> TexthomeListView=['all','book_club','sport','birthday','meeting','exhibition'];
static List<String> AddEventListView=['book_club','sport','birthday','meeting','exhibition'];
  static List<Widget> SelectedhomeListViewIcons=[
    Icon(Icons.all_inclusive_outlined,color: EventlyColors.white_color,size: 30),
    Icon(Icons.menu_book_outlined,color: EventlyColors.white_color,size: 30),
    Icon(Icons.directions_bike_outlined,color: EventlyColors.white_color,size: 30),
    Icon(Icons.cake_outlined,color: EventlyColors.white_color,size: 30),
    Icon(Icons.meeting_room_outlined,color: EventlyColors.white_color,size: 30),
    Icon(Icons.museum_outlined,color: EventlyColors.white_color,size: 30)
  ];
static List<Widget> SelectedAddEventListViewIcons=[
  Icon(Icons.menu_book_outlined,color: EventlyColors.white_color,size: 30),
  Icon(Icons.directions_bike_outlined,color: EventlyColors.white_color,size: 30),
  Icon(Icons.cake_outlined,color: EventlyColors.white_color,size: 30),
  Icon(Icons.meeting_room_outlined,color: EventlyColors.white_color,size: 30),
  Icon(Icons.museum_outlined,color: EventlyColors.white_color,size: 30)
];
  static List<Widget> UnselectedhomeListViewIcons=[
    Icon(Icons.all_inclusive_outlined,color: EventlyColors.main_blue,size: 30),
    Icon(Icons.menu_book_outlined,color: EventlyColors.main_blue,size: 30),
    Icon(Icons.directions_bike_outlined,color: EventlyColors.main_blue,size: 30),
    Icon(Icons.cake_outlined,color: EventlyColors.main_blue,size: 30),
    Icon(Icons.meeting_room_outlined,color: EventlyColors.main_blue,size: 30),
    Icon(Icons.museum_outlined,color: EventlyColors.main_blue,size: 30)
  ];
static List<Widget> UnselectedAddEventListViewIcons=[
  Icon(Icons.menu_book_outlined,color: EventlyColors.main_blue,size: 30),
  Icon(Icons.directions_bike_outlined,color: EventlyColors.main_blue,size: 30),
  Icon(Icons.cake_outlined,color: EventlyColors.main_blue,size: 30),
  Icon(Icons.meeting_room_outlined,color: EventlyColors.main_blue,size: 30),
  Icon(Icons.museum_outlined,color: EventlyColors.main_blue,size: 30)
];
  static List<Widget> UnselectedDarkhomeListViewIcons=[
    Icon(Icons.all_inclusive_outlined,color: EventlyColors.main_dark_blue,size: 30),
    Icon(Icons.menu_book_outlined,color: EventlyColors.main_dark_blue,size: 30),
    Icon(Icons.directions_bike_outlined,color: EventlyColors.main_dark_blue,size: 30),
    Icon(Icons.cake_outlined,color: EventlyColors.main_dark_blue,size: 30),
    Icon(Icons.meeting_room_outlined,color: EventlyColors.main_dark_blue,size: 30),
    Icon(Icons.museum_outlined,color: EventlyColors.main_dark_blue,size: 30)
  ];
static List<Widget> UnselectedDarkAddEventListViewIcons=[
  Icon(Icons.menu_book_outlined,color: EventlyColors.main_dark_blue,size: 30),
  Icon(Icons.directions_bike_outlined,color: EventlyColors.main_dark_blue,size: 30),
  Icon(Icons.cake_outlined,color: EventlyColors.main_dark_blue,size: 30),
  Icon(Icons.meeting_room_outlined,color: EventlyColors.main_dark_blue,size: 30),
  Icon(Icons.museum_outlined,color: EventlyColors.main_dark_blue,size: 30)
];

  static List<String> Addimages=[
    EventlyAssets.bookClub,
    EventlyAssets.sport,
    EventlyAssets.birthday,
    EventlyAssets.meeting,
    EventlyAssets.exhibition,
  ];
static List<String> AddDarkimages=[
  EventlyAssets.dark_bookClub,
  EventlyAssets.dark_sport,
  EventlyAssets.dark_birthday,
  EventlyAssets.dark_meeting,
  EventlyAssets.dark_exhibition,
];
static List<String> langTextList=[
  'language'.tr(),
  'arabic'.tr()
];
}