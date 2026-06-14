import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/screens/welcome_screen/model/welcome_model.dart';
import 'package:evently/ui/widgets/customized_elevated_button.dart';
import 'package:evently/utils/evently_styles.dart';
import 'package:evently/utils/evently_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/evently_assets.dart';
import '../../utils/evently_size.dart';

class WelcomeScreenItem extends StatelessWidget {
  final WelcomeModel welcomeModel;
  final int selectedIndex;
  final VoidCallback onNext;

  const WelcomeScreenItem({
    super.key,
    required this.welcomeModel,
    required this.selectedIndex,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var langProvider = Provider.of<LanguageProvider>(context);
    bool isDark = themeProvider.themeMode == ThemeMode.dark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              welcomeModel.image_path,
              height: context.height * 0.4,
              fit: BoxFit.contain,
            ),
          ),
          
          // Gap for the fixed indicator sitting in the parent Stack
          if (selectedIndex > 0) 
            SizedBox(height: context.height * 0.06),

          Text(
            welcomeModel.title,
            style: isDark ? EventlyStyles.bold20white : EventlyStyles.bold20black,
          ),
          SizedBox(height: context.height * 0.02),
          Text(
            welcomeModel.description,
            style: isDark ? EventlyStyles.regular16dark_grey : EventlyStyles.regular16grey,
          ),
          if (selectedIndex == 0) ...[
            SizedBox(height: context.height * 0.04),
            Row(
              children: [
                Text(
                  'language'.tr(),
                  style: EventlyStyles.medium18black.copyWith(
                    color: isDark ? EventlyColors.main_dark_blue : EventlyColors.main_blue,
                  ),
                ),
                const Spacer(),
                _buildToggleButton(
                  context: context,
                  text: "english".tr(),
                  isSelected: langProvider.lang == 'en',
                  onTap: () {
                    langProvider.changeLang('en');
                    context.setLocale(const Locale('en'));
                  },
                ),
                SizedBox(width: context.width * 0.02),
                _buildToggleButton(
                  context: context,
                  text: "arabic".tr(),
                  isSelected: langProvider.lang == 'ar',
                  onTap: () {
                    langProvider.changeLang('ar');
                    context.setLocale(const Locale('ar'));
                  },
                ),
              ],
            ),
            SizedBox(height: context.height * 0.02),
            Row(
              children: [
                Text(
                  'theme'.tr(),
                  style: EventlyStyles.medium18black.copyWith(
                    color: isDark ? EventlyColors.main_dark_blue : EventlyColors.main_blue,
                  ),
                ),
                const Spacer(),
                _buildToggleButton(
                  context: context,
                  icon: Icons.wb_sunny_outlined,
                  isSelected: !isDark,
                  onTap: () => themeProvider.ChangeThemeMode(ThemeMode.light),
                ),
                SizedBox(width: context.width * 0.02),
                _buildToggleButton(
                  context: context,
                  icon: Icons.nightlight_round_outlined,
                  isSelected: isDark,
                  onTap: () => themeProvider.ChangeThemeMode(ThemeMode.dark),
                ),
              ],
            ),
          ],
          SizedBox(height: context.height * 0.04),
          CustomizedElevatedButton(
            onPressed: onNext,
            child: Text(
              selectedIndex == 0
                  ? 'lets_start'.tr()
                  : (selectedIndex == 3 ? 'get_started'.tr() : 'next'.tr()),
              style: EventlyStyles.medium18white.copyWith(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required BuildContext context,
    String? text,
    IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.themeMode == ThemeMode.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.04, vertical: context.height * 0.01),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? EventlyColors.main_dark_blue : EventlyColors.main_blue)
              : (isDark ? EventlyColors.dark_listTile : EventlyColors.white_color),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isDark ? EventlyColors.dark_stroke : EventlyColors.lightStroke,
              width: 1.5),
        ),
        child: text != null
            ? Text(
                text,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : (isDark ? EventlyColors.white_color : EventlyColors.main_blue),
                  fontWeight: FontWeight.w500,
                ),
              )
            : Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : (isDark ? EventlyColors.white_color : EventlyColors.main_blue),
                size: 20,
              ),
      ),
    );
  }
}
