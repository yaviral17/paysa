import 'dart:developer';

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/new/Controllers/navigation_controller.dart';
import 'package:paysa/new/Views/settings/setting_view.dart';
import 'package:paysa/utils/constants/colors.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final navigationController = Get.put(NavigationController());

  List<FlashyTabBarItem> bottomItem = [
    FlashyTabBarItem(
      icon: const Icon(
        Iconsax.home,
      ),
      title: const Text('Home'),
    ),
    FlashyTabBarItem(
      icon: const Icon(Iconsax.chart_1),
      title: const Text('Stats'),
    ),
    FlashyTabBarItem(
      icon: const Icon(Iconsax.wallet),
      title: const Text('Wallet'),
    ),
    FlashyTabBarItem(
      icon: const Icon(Iconsax.setting_2),
      title: const Text('Settings'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pageController =
        PageController(initialPage: navigationController.currentIndex);
    return Scaffold(
      backgroundColor: TColors.background(context),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            child: const Center(
              child: Text('Home'),
            ),
          ),
          Container(
            child: const Center(
              child: Text('Stats'),
            ),
          ),
          Container(
            child: const Center(
              child: Text('Wallet'),
            ),
          ),
          const SettingsView(),
        ],
      ),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: TColors.background(context),
        selectedIndex: navigationController.currentIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          log('index: $index');
          navigationController.changePage(index);
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }),
        shadows: [
          BoxShadow(
            color: TColors.background(context),
            blurRadius: 10.0,
          ),
        ],
        items: bottomItem.map((e) {
          return FlashyTabBarItem(
            icon: e.icon,
            title: e.title,
            inactiveColor: TColors.bottomNavItemInactive(context),
            activeColor: TColors.bottomNavItemActive(context),
          );
        }).toList(),
      ),
    );
  }
}
