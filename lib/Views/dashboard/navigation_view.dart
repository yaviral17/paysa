import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/navigation_controller.dart';
import 'package:paysa/Utils/theme/colors.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final navigationController = Get.put(NavigationController());

  final PageController pageController = PageController();

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
      backgroundColor: PColors.background(context),
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
            padding:
                const EdgeInsets.only(left: 15, top: 9, right: 15, bottom: 15),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              color: PColors.bottomBar(context),
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
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 39, 100, 85)),
              child: const Icon(Iconsax.add, color: PColors.white),
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
      duration: const Duration(milliseconds: 100),
      height: TSizes.displayHeight(context) * 0.005,
      width: isActived ? TSizes.displayWidth(context) * 0.05 : 0,
      margin: const EdgeInsets.only(bottom: 3),
      decoration: const BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: PColors.primary),
    );
  }
}
