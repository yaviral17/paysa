import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/home/widget/chart_widget.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../Controllers/contact_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final authController = Get.find<AuthenticationController>();
  final contactController = Get.put(ContactsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: PSize.arh(context, 12),
                ),

                // Header AppBar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: HugeIcon(
                        icon: Iconsax.search_normal_1,
                        color: PColors.primary(context),
                      ),
                    ),
                    Container(
                      height: PSize.arw(context, 36),
                      // width: PSize.arw(context, 80),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: PColors.containerSecondary(context),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: PColors.primary(context),
                            size: PSize.arw(context, 24),
                          ),
                          Text(
                            // currency symbol flag icon
                            ' ₹ INR 🇮🇳',
                            style: TextStyle(
                              fontSize: PSize.arw(context, 16),
                              color:
                                  PColors.primaryText(context).withAlpha(200),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: HugeIcon(
                        icon: Iconsax.notification,
                        color: PColors.primary(context),
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

                SizedBox(
                  height: PSize.arh(context, 16),
                ),

                firstBgBalanceCard(context),

                SizedBox(
                  height: PSize.arh(context, 18),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Goals',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 18),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: PColors.primaryText(context),
                        ),
                      ),
                      ZoomTapAnimation(
                        onTap: () {
                          HapticFeedback.lightImpact();
                        },
                        child: Row(
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 14),
                                color: PColors.primary(context),
                              ),
                            ),
                            SizedBox(
                              width: PSize.arw(context, 4),
                            ),
                            Icon(
                              HugeIcons.strokeRoundedArrowRight01,
                              color: PColors.primary(context),
                              size: PSize.arw(context, 14),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: PSize.arh(context, 8),
                ),
                const GoalTileWidget(
                  label: 'Goal 1',
                  totalAmount: 1000,
                  currentAmount: 500,
                ),
                SizedBox(
                  height: PSize.arh(context, 8),
                ),
                const GoalTileWidget(
                  label: 'Goal 2',
                  totalAmount: 2000,
                  currentAmount: 1000,
                ),

                SizedBox(
                  height: PSize.arh(context, 16),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Splits',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 18),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: PColors.primaryText(context),
                        ),
                      ),
                      ZoomTapAnimation(
                        onTap: () {
                          HapticFeedback.lightImpact();
                        },
                        child: Row(
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 14),
                                color: PColors.primary(context),
                              ),
                            ),
                            SizedBox(
                              width: PSize.arw(context, 4),
                            ),
                            Icon(
                              HugeIcons.strokeRoundedArrowRight01,
                              color: PColors.primary(context),
                              size: PSize.arw(context, 14),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: PSize.arh(context, 4),
                ),

                Row(
                  children: [
                    Expanded(
                      child: SmoothContainer(
                        padding: const EdgeInsets.all(12),
                        borderRadius: BorderRadius.circular(10),
                        color: PColors.containerSecondary(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total Splits You Lent',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 14),
                                color: PColors.secondaryText(context),
                              ),
                            ),
                            SizedBox(
                              height: PSize.arh(context, 4),
                            ),
                            Text(
                              '\$ 120.0',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 20),
                                fontWeight: FontWeight.w700,
                                color: PColors.primary(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: PSize.arw(context, 12),
                    ),
                    Expanded(
                      child: SmoothContainer(
                        padding: const EdgeInsets.all(12),
                        // margin: const EdgeInsets.all(12),
                        borderRadius: BorderRadius.circular(10),
                        color: PColors.containerSecondary(context),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total Splits You Owe',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 14),
                                color: PColors.secondaryText(context),
                              ),
                            ),
                            SizedBox(
                              height: PSize.arh(context, 4),
                            ),
                            Text(
                              '\$ 120.0',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 20),
                                fontWeight: FontWeight.w700,
                                color: PColors.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: PSize.arh(context, 4),
                ),
                ...List.generate(
                  2,
                  (index) {
                    return SmoothContainer(
                      width: PSize.displayWidth(context),
                      height: PSize.arh(context, 80),
                      color: PColors.containerSecondary(context),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      borderRadius: BorderRadius.circular(10),
                      smoothness: 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "B'day Party",
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 18),
                                    color: PColors.primaryText(context),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: PSize.arh(context, 4),
                                ),
                                Text(
                                  '+ \$ 120.0 ',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 20),
                                    fontWeight: FontWeight.w600,
                                    color: PColors.primary(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: PSize.arw(context, 36),
                            width: PSize.arw(context, 100),
                            child: AvatarStack(
                              height: PSize.arw(context, 40),
                              borderColor: PColors.primaryText(context),
                              borderWidth: 2,
                              avatars: List.generate(
                                6,
                                (index) => const NetworkImage(
                                  "https://avatars.githubusercontent.com/u/58760825?s=400&u=735ec2d81037c15adfbeea61a5a3112aef3afb85&v=4",
                                ),
                              ),
                              infoWidgetBuilder: (surplus) =>
                                  BorderedCircleAvatar(
                                border: BorderSide(
                                  color: PColors.primary(context),
                                  width: 2,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: CircleAvatar(
                                    radius: PSize.arw(context, 16),
                                    backgroundColor: PColors.primary(context),
                                    child: Text(
                                      '+$surplus',
                                      style: TextStyle(
                                        fontSize: PSize.arw(context, 14),
                                        color: PColors.primaryText(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: PSize.arh(context, 12),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 18),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: PColors.primaryText(context),
                        ),
                      ),
                      ZoomTapAnimation(
                        onTap: () {
                          HapticFeedback.lightImpact();
                        },
                        child: Row(
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 14),
                                color: PColors.primary(context),
                              ),
                            ),
                            SizedBox(
                              width: PSize.arw(context, 4),
                            ),
                            Icon(
                              HugeIcons.strokeRoundedArrowRight01,
                              color: PColors.primary(context),
                              size: PSize.arw(context, 14),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: PSize.arh(context, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget firstBgBalanceCard(BuildContext context) {
    return FittedBox(
      child: Container(
        width: PSize.displayWidth(context),
        // padding: const EdgeInsets.only(
        //   bottom: 12,
        //   left: 12,
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: PColors.background(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: PSize.arh(context, 10),
                  ),
                  Text(
                    'TOTAL BALANCE',
                    style: TextStyle(
                      fontSize: PSize.arw(context, 16),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: PColors.secondaryText(context),
                    ),
                  ),
                  SizedBox(
                    height: PSize.arh(context, 2),
                  ),
                  Text(
                    '\$12,000.00',
                    style: TextStyle(
                      fontSize: PSize.arw(context, 40),
                      color: PColors.primaryText(context),
                      letterSpacing: -1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 14),
                          color: PColors.primary(context),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedArrowRight01,
                          color: PColors.primary(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: PSize.arw(context, 16),
            ),
            Expanded(
              child: SizedBox(
                height: PSize.arw(context, 180),
                width: PSize.arw(context, 200),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   color: PColors.containerSecondary(context),
                // ),
                child: LineChartSample4(),
              ),
            ),

            // Spacer(),
          ],
        ),
      ),
    );
  }
}

class GoalTileWidget extends StatelessWidget {
  final String label;
  final double totalAmount;
  final double currentAmount;
  const GoalTileWidget({
    super.key,
    this.label = 'Goal',
    this.totalAmount = 1000,
    this.currentAmount = 500,
  });

  @override
  Widget build(BuildContext context) {
    const double progressBarWidth = 320;
    return SmoothContainer(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      width: PSize.displayWidth(context),
      // height: PSize.arw(context, 200),
      borderRadius: BorderRadius.circular(18),
      color: PColors.containerSecondary(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  fontWeight: FontWeight.w600,
                  letterSpacing: -1,
                  color: PColors.secondaryText(context),
                ),
              ),
              const Spacer(),
              Text(
                '\$$currentAmount',
                style: TextStyle(
                  fontSize: PSize.arw(context, 12),
                  color: PColors.secondaryText(context),
                ),
              ),
              Text(
                ' / \$$totalAmount',
                style: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  color: PColors.primaryText(context),
                ),
              ),
            ],
          ),
          SizedBox(
            height: PSize.arh(context, 8),
          ),
          // progress bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  height: PSize.arw(context, 8),
                  width: PSize.arw(context, progressBarWidth),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PColors.containerSecondary(context),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: PSize.arw(context,
                            (currentAmount * progressBarWidth) / totalAmount),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: PColors.primary(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: PSize.arw(context, 8),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: PSize.arw(context, 18),
                  child: FittedBox(
                    child: Text(
                      '${(currentAmount * 100) / totalAmount}%',
                      style: TextStyle(
                        fontSize: PSize.arw(context, 14),
                        color: PColors.primary(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileContainerWidget extends StatelessWidget {
  const ProfileContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: PSize.arw(context, 72),
      width: PSize.arw(context, 80),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: PSize.arw(context, 72),
              maxWidth: PSize.arw(context, 80),
            ),
            margin: const EdgeInsets.only(left: 2, right: 8),
            // padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  PColors.containerSecondary(context),
                  BlendMode.srcOver,
                ),
                image: const NetworkImage(
                    "https://avatars.githubusercontent.com/u/58760825?s=400&u=735ec2d81037c15adfbeea61a5a3112aef3afb85&v=4"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
              // color: PColors.primary(context).withOpacity(0.2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Icon(
                //   HugeIcons.strokeRoundedUserCircle,
                //   color: PColors.primaryText(context),
                // ),
                // SizedBox(
                //   height: PSize.arh(context, 4),
                // ),
                Container(
                  constraints: BoxConstraints(
                    // maxHeight: PSize.arw(context, 20),
                    minWidth: PSize.arw(context, 80),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: PColors.background(context).withOpacity(0.9),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    'Aviral Yadav',
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: PSize.arw(context, 12),
                      fontWeight: FontWeight.w600,
                      color: PColors.secondaryText(context),
                      letterSpacing: -0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: HugeIcon(
              icon: Iconsax.notification_11,
              color: PColors.error,
              size: PSize.arw(context, 45),
            ),
          ),
        ],
      ),
    );
  }
}
