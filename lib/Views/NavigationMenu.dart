import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Views/Groups/GroupsScreen.dart';
import 'package:paysa/Views/Profile/profile.dart';
import 'package:paysa/utils/constants/colors.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Text('Insights'),
          ),
          SalomonBottomBarItem(
            icon: Icon(Iconsax.user),
            title: Text('Profile'),
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const GroupsScreen(),
            Container(
              child: Center(
                child: Text('Insight'),
              ),
            ),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
