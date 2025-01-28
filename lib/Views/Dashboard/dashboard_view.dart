import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:paysa/APIs/firebase_api.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Controllers/dashboard_controller.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/NewSpending/new_spending_view.dart';
import 'package:paysa/Views/Dashboard/chat/chat_screen.dart';
import 'package:paysa/Views/Dashboard/home/home_view.dart';
import 'package:paysa/Views/Dashboard/home/profile/profile_view.dart';
import 'package:paysa/Views/Dashboard/widget/paysa_navbar_icon_widget.dart';
import 'package:paysa/app.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'cards/cards_view.dart';
import 'stats/stats_view.dart';

class DashMenuView extends StatefulWidget {
  const DashMenuView({super.key});

  @override
  State<DashMenuView> createState() => _DashMenuViewState();
}

class _DashMenuViewState extends State<DashMenuView> with RouteAware {
  final DashboardController dashboardController =
      Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Register this widget as a route observer
    final ModalRoute? route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
    // status bar and navigation bar theme set
    PHelper.systemUIOverlayStyle(context);
  }

  @override
  void dispose() {
    // Unregister this widget as a route observer
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when the current route has been popped off, and the previous route shows up
    log('didPopNext');
    PHelper.systemUIOverlayStyle(context);
  }

  @override
  Widget build(BuildContext context) {
    // status bar and navigation bar theme set

    bool isPlatformIos = PHelper.isPlatformIos(context);

    log('didPopNext');
    PHelper.systemUIOverlayStyle(context);
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          dashboardController.currentIndex.value = index;
        },
        controller: dashboardController.pageController,
        physics: PageScrollPhysics(),
        children: [
          !isPlatformIos ? const SafeArea(child: HomeView()) : const HomeView(),
          !isPlatformIos
              ? const SafeArea(child: ChatScreen())
              : const ChatScreen(),
          !isPlatformIos
              ? const SafeArea(child: StatisticsView())
              : const StatisticsView(),
          !isPlatformIos
              ? const SafeArea(child: ProfileView())
              : const ProfileView(),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          final navBar = Container(
            padding: const EdgeInsets.only(bottom: 12.0, top: 12.0),
            decoration: BoxDecoration(
              color: PColors.background(context),
              boxShadow: [
                BoxShadow(
                  color: PColors.background(context),
                  spreadRadius: 4.0,
                  blurRadius: 8.0,
                  // offset: const Offset(0, -10),
                ),
              ],
            ),
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
                // PaysaNavbarIcon(
                //   label: 'Cards',
                //   onPressed: () {
                //     dashboardController.changePage(1);
                //   },
                //   icon: HugeIcons.strokeRoundedCreditCard,
                //   isActive: dashboardController.currentIndex.value == 1,
                // ),
                PaysaNavbarIcon(
                  label: 'Chats',
                  onPressed: () {
                    dashboardController.changePage(1);
                  },
                  icon: HugeIcons.strokeRoundedBubbleChatNotification,
                  isActive: dashboardController.currentIndex.value == 1,
                ),
                ZoomTapAnimation(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    PNavigate.to(const NewSpendingView());
                  },
                  child: GlowContainer(
                    glowColor: PColors.primary(context).withOpacity(0.5),
                    spreadRadius: 0.0,
                    borderRadius: BorderRadius.circular(100.0),
                    blurRadius: 2.0,
                    child: CircleAvatar(
                      backgroundColor: PColors.color1,
                      radius: PSize.arw(context, 30),
                      child: Icon(
                        HugeIcons.strokeRoundedPlusSign,
                        color: PColors.primaryText(context),
                        // glowColor: PColors.primary(context),
                        // blurRadius: 10.0,
                        // offset: const Offset(0, 0),
                      ),
                    ),
                  ),
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
                  label: 'Preferences',
                  onPressed: () {
                    dashboardController.changePage(3);
                  },
                  icon: HugeIcons.strokeRoundedSettings04,
                  isActive: dashboardController.currentIndex.value == 3,
                ),
              ],
            ),
          );

          return !isPlatformIos ? SafeArea(child: navBar) : navBar;
        },
      ),
    );
  }
}
