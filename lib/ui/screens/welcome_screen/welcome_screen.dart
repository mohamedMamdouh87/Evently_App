import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/screens/welcome_screen/model/welcome_model.dart';
import 'package:evently/ui/widgets/welcome_screen_item.dart';
import 'package:evently/utils/evently_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../prefs/welcome_pref.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/evently_assets.dart';
import '../../../utils/evently_size.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  bool _personalizationComplete = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.height * 0.04, horizontal: context.width * 0.04),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: _currentPageIndex >= 2
                          ? _buildBackButton(isDark)
                          : const SizedBox(),
                    ),
                  ),
                  isDark
                      ? Image.asset(EventlyAssets.dark_evently, height: 40)
                      : Image.asset(EventlyAssets.evently, height: 40),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: (_currentPageIndex == 1 || _currentPageIndex == 2)
                          ? _buildSkipButton(isDark)
                          : const SizedBox(),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      physics: _personalizationComplete
                          ? null
                          : const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                      itemCount: _personalizationComplete
                          ? WelcomeModel.welcomeList.length - 1
                          : WelcomeModel.welcomeList.length,
                      itemBuilder: (context, index) {
                        int modelIndex = _personalizationComplete ? index + 1 : index;

                        return WelcomeScreenItem(
                          welcomeModel: isDark
                              ? WelcomeModel.dark_welcomeList[modelIndex]
                              : WelcomeModel.welcomeList[modelIndex],
                          selectedIndex: modelIndex,
                          onNext: () async {
                            if (modelIndex == 0) {
                              setState(() {
                                _personalizationComplete = true;
                                _currentPageIndex = 0;
                              });
                              _pageController.jumpToPage(0);
                            } else if (modelIndex < WelcomeModel.welcomeList.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              await WelcomePref.setWelcome(true);
                              Navigator.of(context)
                                  .pushReplacementNamed(EventlyRoutes.loginScreen);
                            }
                          },
                        );
                      },
                    ),
                    if (_personalizationComplete)
                      Positioned(
                        top: context.height * 0.4 + context.height * 0.03, // Increased gap
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: WelcomeModel.welcomeList.length - 1,
                            effect: ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 8,
                              activeDotColor: isDark
                                  ? EventlyColors.main_dark_blue
                                  : EventlyColors.main_blue,
                              dotColor: EventlyColors.disable,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(bool isDark) {
    return GestureDetector(
      onTap: () {
        _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isDark
                    ? EventlyColors.dark_stroke
                    : EventlyColors.lightStroke),
            color: isDark ? EventlyColors.dark_listTile : EventlyColors.white_color),
        child: Icon(
            Directionality.of(context) == TextDirection.RTL
                ? Icons.arrow_forward_ios
                : Icons.arrow_back_ios_new,
            size: 20,
            color: isDark ? Colors.white : EventlyColors.main_blue),
      ),
    );
  }

  Widget _buildSkipButton(bool isDark) {
    return GestureDetector(
      onTap: () async {
        await WelcomePref.setWelcome(true);
        Navigator.of(context).pushReplacementNamed(EventlyRoutes.loginScreen);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isDark
                    ? EventlyColors.dark_stroke
                    : EventlyColors.lightStroke),
            color: isDark ? EventlyColors.dark_listTile : EventlyColors.white_color),
        child: Text('skip'.tr(),
            style: TextStyle(
                color: isDark ? Colors.white : EventlyColors.main_blue,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
      ),
    );
  }
}
