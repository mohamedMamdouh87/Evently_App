import 'package:easy_localization/easy_localization.dart';
import '../../../../utils/evently_assets.dart';

class WelcomeModel {
  String title;
  String description;
  String image_path;
  WelcomeModel({required this.title,required this.description,required this.image_path});

  static List<WelcomeModel> get welcomeList => [
    WelcomeModel(title: 'welcome_title1'.tr(), description: 'welcome_desc1'.tr(), image_path: EventlyAssets.beingCreative),
    WelcomeModel(title: 'welcome_title2'.tr(), description: "welcome_desc2".tr(), image_path: EventlyAssets.hot_trending),
    WelcomeModel(title: 'welcome_title3'.tr(), description: "welcome_desc3".tr(), image_path: EventlyAssets.manager_disk),
    WelcomeModel(title: 'welcome_title4'.tr(), description: "welcome_desc4".tr(), image_path: EventlyAssets.social),
  ];

  static List<WelcomeModel> get dark_welcomeList => [
    WelcomeModel(title: 'welcome_title1'.tr(), description: 'welcome_desc1'.tr(), image_path: EventlyAssets.dark_being_creative),
    WelcomeModel(title: 'welcome_title2'.tr(), description: "welcome_desc2".tr(), image_path: EventlyAssets.dark_hot_trending),
    WelcomeModel(title: 'welcome_title3'.tr(), description: "welcome_desc3".tr(), image_path: EventlyAssets.dark_manager_disk),
    WelcomeModel(title: 'welcome_title4'.tr(), description: "welcome_desc4".tr(), image_path: EventlyAssets.dark_social),
  ];
}
