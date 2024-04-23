import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/DailySpendingsController.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Views/DailySpendings/DailySpending.dart';
import 'package:paysa/Views/Home/GroupsScreen.dart';
import 'package:paysa/Views/Profile/profile.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int selectedIndex = 0;
  PageController pageController = PageController();

  DailySpendingController dailySpendingsController =
      Get.put(DailySpendingController());

  @override
  void initState() {
    super.initState();

    fetchSplits();
  }

  fetchSplits() async {
    log('Fetching Splits');
    List<Map<String, dynamic>> lst =
        await FireStoreRef.fetchSplitsFromDailySpending(true);
    log('Fetched Splits ${lst.toString()}');
    for (Map<String, dynamic> item in lst) {
      log('Adding Daily Spending');

      Map<String, dynamic>? data =
          await FireStoreRef.fetchSplitDataById(item['id']);
      if (data != null) {
        dailySpendingsController.dailySplits
            .add(DailySpendingModel.fromJson(data));
      }

      log('Daily Spending Added ${dailySpendingsController.dailySplits.map((element) => element.toJson().toString())}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: selectedIndex,
          // enableFeedback: false,

          selectedItemColor: TColors.primary,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
              pageController.jumpToPage(index);
            });
          },

          items: <SalomonBottomBarItem>[
            SalomonBottomBarItem(
              icon: Icon(Iconsax.chart),
              title: Text('Groups'),
            ),
            SalomonBottomBarItem(
              icon: Icon(Iconsax.chart_1),
              title: Text('Daily Spendings'),
            ),
            // SalomonBottomBarItem(
            //   icon: Icon(Iconsax.chart_1),
            //   title: Text('Monthly Insights'),
            // ),
            SalomonBottomBarItem(
              icon: Icon(Iconsax.user),
              title: const Text('Profile'),
            ),
          ],
        ),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const GroupsScreen(),
            DailySpendingScreen(),
            // Container(
            //   child: Center(
            //     child: Text('Insight'),
            //   ),
            // ),
            const ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
