import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Controllers/dashboard_controller.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/home/widget/chart_widget.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
  final dashboardController = Get.find<DashboardController>();

  @override
  void initState() {
    super.initState();
  }

  void fetchRecentTransactions() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.background(context),
      appBar: AppBar(
        backgroundColor: PColors.background(context),
        surfaceTintColor: PColors.background(context),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: IconButton(
            onPressed: () {},
            icon: HugeIcon(
              icon: Iconsax.search_normal_1,
              color: PColors.primary(context),
            ),
          ),
        ),
        title: Container(
          height: PSize.arw(context, 36),
          width: PSize.arw(context, 120),
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
                  color: PColors.primaryText(context).withAlpha(200),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              onPressed: () {},
              icon: HugeIcon(
                icon: Iconsax.notification,
                color: PColors.primary(context),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  firstBgBalanceCard(context),
                  SizedBox(
                    height: PSize.arh(context, 18),
                  ),
                  Visibility(
                    visible:
                        dashboardController.shoppingSpendings.value.isNotEmpty,
                    child: Column(
                      children: [
                        SectionDividerWidget(
                          label: "Shopping 🛍️",
                          onTap: () {},
                        ),
                        SizedBox(
                          height: PSize.arh(context, 8),
                        ),
                        ...List.generate(
                          dashboardController.shoppingSpendings.value.length > 3
                              ? 3
                              : dashboardController
                                  .shoppingSpendings.value.length,
                          (index) {
                            return ShoppingTileWidget(
                              label: dashboardController.shoppingSpendings
                                  .value[index].shoppingModel!.message,
                              time: PHelper.timeAgo(
                                dashboardController
                                    .shoppingSpendings.value[index].createdAt,
                              ),
                              amount: double.parse(
                                dashboardController.shoppingSpendings
                                        .value[index].shoppingModel?.amount ??
                                    '0',
                              ),
                              isIncome: false,
                            );
                          },
                        ),
                        SizedBox(
                          height: PSize.arh(context, 18),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        dashboardController.transferSpendings.value.isNotEmpty,
                    child: Column(
                      children: [
                        SectionDividerWidget(
                          label: 'Transfer 💸',
                          onTap: () {},
                        ),
                        SizedBox(
                          height: PSize.arh(context, 8),
                        ),
                        ...List.generate(
                          dashboardController.transferSpendings.value.length > 3
                              ? 3
                              : dashboardController
                                  .transferSpendings.value.length,
                          (index) {
                            SpendingModel spending = dashboardController
                                .transferSpendings.value[index];
                            bool isIncome = spending.createdBy !=
                                authController.user.value?.uid;
                            return TransferTileWidget(
                              otherPerson: isIncome
                                  ? spending
                                      .transferSpendingModel!.transferdFromUser!
                                  : spending
                                      .transferSpendingModel!.transferdToUser!,
                              isIncome: isIncome,
                              time: PHelper.timeAgo(spending.createdAt),
                              amount: double.parse(
                                spending.transferSpendingModel?.amount ?? '0',
                              ),
                              onTap: () {},
                            );
                          },
                        ),
                        SizedBox(
                          height: PSize.arh(context, 18),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        dashboardController.splitSpendings.value.isNotEmpty,
                    child: Column(
                      children: [
                        SectionDividerWidget(
                          label: 'Bill Split 🤝',
                          onTap: () {},
                        ),
                        SizedBox(
                          height: PSize.arh(context, 8),
                        ),
                        ...List.generate(
                          dashboardController.splitSpendings.value.length > 3
                              ? 3
                              : dashboardController.splitSpendings.value.length,
                          (index) {
                            SpendingModel spending =
                                dashboardController.splitSpendings.value[index];
                            bool isIncome = spending.createdBy !=
                                authController.user.value?.uid;
                            return TransferTileWidget(
                              otherPerson: isIncome
                                  ? spending
                                      .transferSpendingModel!.transferdFromUser!
                                  : spending
                                      .transferSpendingModel!.transferdToUser!,
                              isIncome: isIncome,
                              time: PHelper.timeAgo(spending.createdAt),
                              amount: double.parse(
                                spending.transferSpendingModel?.amount ?? '0',
                              ),
                              onTap: () {},
                            );
                          },
                        ),
                        SizedBox(
                          height: PSize.arh(context, 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget firstBgBalanceCard(BuildContext context) {
    log("'₹ 2397.0 spent this month'".length.toString(),
        name: 'firstBgBalanceCard');
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
            Obx(
              () => Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: PSize.arh(context, 10),
                    ),
                    Skeletonizer(
                      enabled: dashboardController.isLoading.value,
                      child: Text(
                        'TOTAL BALANCE',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 16),
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1,
                          color: PColors.secondaryText(context),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: PSize.arh(context, 2),
                    ),
                    Skeletonizer(
                      enabled: dashboardController.isLoading.value,
                      child: Text(
                        '₹ ${dashboardController.user.value?.balance ?? 0}',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 40),
                          color: PColors.primaryText(context),
                          letterSpacing: -1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: PSize.arh(context, 8),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            margin: const EdgeInsets.only(
                              right: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: PColors.containerSecondary(context),
                            ),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  '₹ 2397.0 spent this month',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 24),
                                    color: PColors.primary(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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

class ShoppingTileWidget extends StatelessWidget {
  final String icon;
  final String label;
  final String time;
  final double amount;
  final bool isIncome;
  final Function()? onTap;

  const ShoppingTileWidget({
    super.key,
    this.icon = '🛍️',
    this.label = 'Shopping',
    this.time = '2 hours ago',
    this.amount = 100,
    this.isIncome = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: SmoothContainer(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        margin: const EdgeInsets.only(bottom: 8),
        width: PSize.displayWidth(context),
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: PSize.arw(context, 25),
              backgroundColor: PColors.containerSecondary(context),
              child: Text(
                icon,
                style: TextStyle(
                  fontSize: PSize.arw(context, 20),
                ),
              ),
            ),
            SizedBox(
              width: PSize.arw(context, 18),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: PSize.arw(context, 16),
                    fontWeight: FontWeight.w600,
                    color: PColors.primaryText(context),
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: PSize.arw(context, 14),
                    color: PColors.secondaryText(context),
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              isIncome ? '+ ₹ $amount' : '- ₹ $amount',
              style: TextStyle(
                fontSize: PSize.arw(context, 16),
                color:
                    isIncome ? PColors.success.withAlpha(180) : PColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransferTileWidget extends StatelessWidget {
  final UserModel otherPerson;
  final String time;
  final double amount;
  final bool isIncome;
  final Function()? onTap;

  const TransferTileWidget({
    super.key,
    required this.otherPerson,
    this.time = '2 hours ago',
    this.amount = 100,
    this.isIncome = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: SmoothContainer(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        margin: const EdgeInsets.only(bottom: 8),
        width: PSize.displayWidth(context),
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            RandomAvatar(
              '${otherPerson.firstname!} ${otherPerson.lastname!}',
              width: PSize.arw(context, 45),
              height: PSize.arw(context, 45),
            ),
            SizedBox(
              width: PSize.arw(context, 18),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${otherPerson.firstname!} ${otherPerson.lastname!}',
                  style: TextStyle(
                    fontSize: PSize.arw(context, 16),
                    fontWeight: FontWeight.w600,
                    color: PColors.primaryText(context),
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: PSize.arw(context, 14),
                    color: PColors.secondaryText(context),
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              isIncome ? '+ ₹ $amount' : '- ₹ $amount',
              style: TextStyle(
                fontSize: PSize.arw(context, 16),
                color:
                    isIncome ? PColors.success.withAlpha(180) : PColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionDividerWidget extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const SectionDividerWidget({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: PSize.arw(context, 18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
            color: PColors.primaryText(context),
          ),
        ),
        ZoomTapAnimation(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View All',
                style: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  color: PColors.primary(context),
                ),
              ),
              HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                color: PColors.primary(context),
              ),
            ],
          ),
        ),
      ],
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
                '₹ $currentAmount',
                style: TextStyle(
                  fontSize: PSize.arw(context, 12),
                  color: PColors.secondaryText(context),
                ),
              ),
              Text(
                ' / ₹ $totalAmount',
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
