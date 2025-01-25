import 'dart:developer';

import 'package:card_slider/card_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Utils/constants/flags.dart';
import 'package:paysa/Utils/constants/hero_tags.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/cards/widgets/circle_flag_widget.dart';
import 'package:paysa/Views/Dashboard/home/profile/profile_view.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  PageController _pageController = PageController();
  int _cardIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(initialPage: _cardIndex);
    // FirestoreAPIs.getCurrencyRates().then((value) {
    //   for (var i in value.keys) {
    //     log(i.toString());
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  final authController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: PSize.arh(context, 12),
          ),

          // Header AppBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: PColors.containerSecondary(context),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const CircleFlagWidget(
                        countryCode: Flag.IN,
                        radius: 12,
                      ),
                      SizedBox(
                        width: PSize.arw(context, 12),
                      ),
                      Text(
                        "INR",
                        style: TextStyle(
                          fontSize: PSize.arw(context, 16),
                          fontWeight: FontWeight.w700,
                          color: PColors.primaryText(context),
                        ),
                      ),
                      SizedBox(
                        width: PSize.arw(context, 6),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: PColors.primaryText(context),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: HugeIcon(
                    icon: Iconsax.search_normal_1,
                    color: PColors.primary(context),
                  ),
                ),
                ZoomTapAnimation(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: PColors.containerSecondary(context),
                    ),
                    child: HugeIcon(
                      icon: Iconsax.notification,
                      color: PColors.primary(context),
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: HugeIcon(
                //     icon: HugeIcons.strokeRoundedQrCode,
                //     color: PColors.primary(context),
                //   ),
                // ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: PSize.arh(context, 12)),
            child: Text(
              "Cards",
              style: TextStyle(
                fontSize: PSize.arw(context, 24),
                fontWeight: FontWeight.w700,
                color: PColors.primaryText(context),
              ),
            ),
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AccountCardWidget(),
                AccountCardWidget(),
              ],
            ),
          ),
          // Container(
          //   height: PSize.arh(context, 200),
          //   width: PSize.displayWidth(context),
          //   margin: const EdgeInsets.only(left: 12, right: 12),
          //   decoration: BoxDecoration(
          //     color: PColors.primary(context).withAlpha(200),
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          // ),

          SizedBox(
            height: PSize.arh(context, 20),
          ),

          // btn row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconBtn(icon: Iconsax.add4),
              CustomIconBtn(icon: Iconsax.send),
              CustomIconBtn(icon: Iconsax.received),
              CustomIconBtn(icon: Iconsax.setting_4),
            ],
          ),

          SizedBox(
            height: PSize.arh(context, 20),
          ),
          // Recent transactions row
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: PSize.arh(context, 12)),
            child: Row(
              children: [
                Text(
                  "Recent Transactions",
                  style: TextStyle(
                    fontSize: PSize.arw(context, 20),
                    fontWeight: FontWeight.w600,
                    color: PColors.primaryText(context),
                  ),
                ),
                const Spacer(),
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: PSize.arw(context, 14),
                    fontWeight: FontWeight.w700,
                    color: PColors.primary(context),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: PSize.arh(context, 0),
          ),

          // Recent transactions list
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const RecentTransTile();
                }),
          ),
        ],
      ),
    );
  }
}

class CustomIconBtn extends StatelessWidget {
  IconData icon;
  CustomIconBtn({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PSize.arh(context, 50),
      width: PSize.arw(context, 90),
      decoration: BoxDecoration(
        color: PColors.color1,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Icon(
          size: 24,
          icon,
          color: PColors.primaryText(context),
        ),
      ),
    );
  }
}

class RecentTransTile extends StatelessWidget {
  const RecentTransTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: PColors.primary(context),
            child: RandomAvatar(
              Flag.SJ,
            ),
          ),
          SizedBox(
            width: PSize.arw(context, 12),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dominos",
                style: TextStyle(
                  fontSize: PSize.arw(context, 18),
                  fontWeight: FontWeight.w700,
                  color: PColors.primaryText(context),
                ),
              ),
              Text(
                "12:24 PM",
                style: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  fontWeight: FontWeight.w600,
                  color: PColors.secondaryText(context),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "-₹1,000.0",
                style: TextStyle(
                  fontSize: PSize.arw(context, 18),
                  fontWeight: FontWeight.w600,
                  color: PColors.primaryText(context),
                ),
              ),
              Text(
                "Success",
                style: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  fontWeight: FontWeight.w600,
                  color: PColors.bottomNavIconActiveDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AccountCardWidget extends StatelessWidget {
  const AccountCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PSize.arh(context, 190),
      width: PSize.arw(context, 280),
      margin: const EdgeInsets.only(left: 6, right: 6),
      decoration: BoxDecoration(
        color: PColors.primary(context).withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: HugeIcon(
                    icon: Iconsax.menu,
                    color: PColors.primaryText(context),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Balance",
                  style: TextStyle(
                    fontSize: PSize.arw(context, 18),
                    fontWeight: FontWeight.w500,
                    color: PColors.primaryText(context),
                  ),
                ),
                Text(
                  "₹1,53,642.0",
                  style: TextStyle(
                    fontSize: PSize.arw(context, 30),
                    fontWeight: FontWeight.w600,
                    color: PColors.primaryText(context),
                  ),
                ),
                Text(
                  "last used ~ 2 days ago",
                  style: TextStyle(
                    fontSize: PSize.arw(context, 12),
                    fontWeight: FontWeight.w600,
                    color: PColors.primaryText(context),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
