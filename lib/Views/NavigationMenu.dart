import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Views/DailySpendings/DailySpending.dart';
import 'package:paysa/Views/Home/GroupsScreen.dart';
import 'package:paysa/new/Views/settings/setting_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int selectedIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: selectedIndex,
          // enableFeedback: false,

          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
              pageController.jumpToPage(index);
            });
          },

          items: <SalomonBottomBarItem>[
            SalomonBottomBarItem(
              icon: const Icon(Iconsax.chart_1),
              title: const Text('Daily Spendings'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Iconsax.chart),
              title: const Text('Friends'),
            ),
            // SalomonBottomBarItem(
            //   icon: Icon(Iconsax.chart_1),
            //   title: Text('Monthly Insights'),
            // ),
            SalomonBottomBarItem(
              icon: const Icon(Iconsax.user),
              title: const Text('Profile'),
            ),
          ],
        ),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            DailySpendingScreen(),
            GroupsScreen(),

            // Container(
            //   child: Center(
            //     child: Text('Insight'),
            //   ),
            // ),
            SettingsView(),
          ],
        ),
      ),
    );
  }
}
