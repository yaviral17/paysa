import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/dashboard_controller.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/home/home_view.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class DashMenuView extends StatefulWidget {
  const DashMenuView({super.key});

  @override
  State<DashMenuView> createState() => _DashMenuViewState();
}

class _DashMenuViewState extends State<DashMenuView> {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  final PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeView(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PaysaNavbarIcon(
                label: 'Home',
                onPressed: () {
                  dashboardController.changePage(0);
                },
                icon: HugeIcons.strokeRoundedHome06,
                isActive: dashboardController.currentIndex.value == 0,
              ),
              PaysaNavbarIcon(
                label: 'Cards',
                onPressed: () {
                  dashboardController.changePage(1);
                },
                icon: HugeIcons.strokeRoundedCreditCard,
                isActive: dashboardController.currentIndex.value == 1,
              ),
              PaysaNavbarIcon(
                label: 'Stats',
                onPressed: () {
                  dashboardController.changePage(2);
                },
                icon: HugeIcons.strokeRoundedBitcoinGraph,
                isActive: dashboardController.currentIndex.value == 2,
              ),
              PaysaNavbarIcon(
                label: 'Chats',
                onPressed: () {
                  dashboardController.changePage(3);
                },
                icon: HugeIcons.strokeRoundedBubbleChatNotification,
                isActive: dashboardController.currentIndex.value == 3,
              ),
              PaysaNavbarIcon(
                label: 'Profile',
                onPressed: () {
                  dashboardController.changePage(4);
                },
                icon: HugeIcons.strokeRoundedUserCircle,
                isActive: dashboardController.currentIndex.value == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaysaNavbarIcon extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final String label;
  final bool isActive;
  const PaysaNavbarIcon({
    super.key,
    required this.icon,
    this.onPressed,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      begin: 1.0,
      end: 0.9,
      onTap: () {
        HapticFeedback.lightImpact();
        onPressed?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlowIcon(
            icon,
            blurRadius: 10.0,
            glowColor: isActive
                ? PColors.bottomNavIconActive(context)
                : Colors.transparent,
            color: isActive
                ? PColors.bottomNavIconActive(context)
                : PColors.bottomNavIconInactive(context),
            size: PSize.arw(context, 27),
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? PColors.bottomNavIconActive(context)
                  : PColors.bottomNavIconInactive(context),
              fontSize: PSize.arw(context, 12),
            ),
          ),
        ],
      ),
    );
  }
}
