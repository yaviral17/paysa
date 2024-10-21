import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/new/Controllers/navigation_controller.dart';
import 'package:paysa/new/Views/Home/home_view.dart';
import 'package:paysa/new/Views/settings/setting_view.dart';
import 'package:paysa/new/Views/statistics/statistics_view.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

import '../../../main.dart';
import '../../Models/menu.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final navigationController = Get.put(NavigationController());
  Menu selectedBottomNav = bottomNavItems.first;

  final PageController pageController =
      PageController(); // Create PageController

  void updateSelectedBtmNav(Menu menu, int index) {
    if (selectedBottomNav != menu) {
      setState(() {
        selectedBottomNav = menu;
        pageController
            .jumpToPage(index); // Update PageController to change the page
        navigationController.currentIndex = index; // Sync controller index
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeView(),
            StatisticsView(),
            SettingsView(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  SafeArea buildBottomNavBar(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: TSizes.displayHeight(context) * 0.07,
            width: TSizes.displayWidth(context) * 0.7,
            padding: EdgeInsets.only(left: 15, top: 9, right: 15, bottom: 15),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: TColors.lightDarkBackground,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(bottomNavItems.length, (i) {
                Menu navBar = bottomNavItems[i];
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    updateSelectedBtmNav(
                        navBar, i); // Pass index to update page
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimateBar(
                          isActived: selectedBottomNav == navBar,
                        ),
                        Icon(
                          bottomNavItems[i].icon,
                          color: selectedBottomNav == navBar
                              ? bottomNavItems[i].iconActiveColor
                              : bottomNavItems[i].iconColor,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pushNamed('/spending-numpad');
            },
            child: Container(
              height: TSizes.displayHeight(context) * 0.07,
              width: TSizes.displayWidth(context) * 0.15,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 39, 100, 85)),
              child: Icon(Iconsax.add, color: TColors.white),
            ),
          )
        ],
      ),
    );
  }
}

class AnimateBar extends StatelessWidget {
  AnimateBar({
    required this.isActived,
    super.key,
  });

  bool isActived = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: TSizes.displayHeight(context) * 0.005,
      width: isActived ? TSizes.displayWidth(context) * 0.05 : 0,
      margin: EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFF8184FF)),
    );
  }
}
