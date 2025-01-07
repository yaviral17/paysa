import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Controllers/new_spending_controller.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../Utils/helpers/helper.dart';

class NewSpendingView extends StatefulWidget {
  const NewSpendingView({super.key});

  @override
  State<NewSpendingView> createState() => _NewSpendingViewState();
}

class _NewSpendingViewState extends State<NewSpendingView>
    with SingleTickerProviderStateMixin {
  List<String> selectedContacts = [];

  RxBool isBottomsheetOpen = false.obs;

  List<String> buttons = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '000',
    '0',
    '⇦'
  ];
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final NewSpendingController newSpendingController = NewSpendingController();
  final authController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: PSize.arw(context, 16),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Obx(
          () => Text(
            newSpendingController.spendingMode.value,
            style: TextStyle(
              fontSize: PSize.arw(context, 18),
              color: PColors.primaryText(context),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Spacer(),
                      TransactionModeWidget(
                        label: 'Shopping',
                        icon: HugeIcons.strokeRoundedShoppingBasket03,
                        isActive: newSpendingController.spendingMode.value ==
                            'Shopping',
                        onTap: () {
                          newSpendingController.spendingMode.value = 'Shopping';
                        },
                      ),
                      Spacer(),
                      TransactionModeWidget(
                        label: 'Fund Transfer',
                        icon: HugeIcons.strokeRoundedTransaction,
                        isActive: newSpendingController.spendingMode.value ==
                            'Fund Transfer',
                        onTap: () {
                          newSpendingController.spendingMode.value =
                              'Fund Transfer';
                        },
                      ),
                      Spacer(),
                      TransactionModeWidget(
                        label: 'Bill Split',
                        icon: HugeIcons.strokeRoundedUserGroup,
                        isActive: newSpendingController.spendingMode.value ==
                            'Bill Split',
                        onTap: () {
                          newSpendingController.spendingMode.value =
                              'Bill Split';
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // money input
              Center(
                child: Text(
                  '₹ 0.00',
                  style: TextStyle(
                    fontSize: PSize.arw(context, 63),
                    color: PColors.primaryText(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Center(
                child: Obx(() {
                  if (newSpendingController.spendingMode.value ==
                      'Bill Split') {
                    return ZoomTapAnimation(
                      onTap: () {
                        isBottomsheetOpen.value = true;

                        showContactBottomSheet(context);
                      },
                      child: SmoothContainer(
                        width: PSize.arw(context, 150),
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        color: PColors.background(context),
                        borderRadius: BorderRadius.circular(16),
                        smoothness: 0.8,
                        side: BorderSide(
                          color: PColors.containerSecondary(context),
                          width: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.add, size: PSize.arw(context, 20)),
                            SizedBox(
                              width: PSize.arw(context, 8),
                            ),
                            Text(
                              'Add Contact',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 14),
                                color: PColors.primaryText(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                }),
              ),
              const Spacer(),
              Obx(() {
                if (newSpendingController.spendingMode.value == 'Bill Split') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Selected Contacts',
                        //   style: TextStyle(
                        //       fontSize: PSize.arw(context, 20),
                        //       fontWeight: FontWeight.w500,
                        //       color: PColors.primaryTextDark),
                        // ),
                        // SizedBox(
                        //   height: PSize.arw(context, 10),
                        // ),
                        selectedContacts.isEmpty
                            ? SizedBox(
                                height: PSize.arw(context, 40),
                              )
                            : SizedBox(
                                width: PSize.screenWidth,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        selectedContacts.length,
                                        (i) => Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        PSize.arw(context, 40),
                                                    width:
                                                        PSize.arw(context, 40),
                                                    child: RandomAvatar(
                                                      selectedContacts[i],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 0,
                                                    top: 0,
                                                    child: GestureDetector(
                                                      onTap: () => setState(() {
                                                        selectedContacts
                                                            .removeAt(i);
                                                      }),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: PColors.error,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        child: Icon(
                                                            Icons.remove,
                                                            color: PColors
                                                                .primaryTextLight,
                                                            size: PSize.arw(
                                                                context, 10)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
              SizedBox(
                height: PSize.arw(context, 10),
              ),
              SmoothContainer(
                width: PSize.displayWidth(context),
                margin: const EdgeInsets.all(12),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                color: PColors.containerSecondary(context),
                borderRadius: BorderRadius.circular(16),
                smoothness: 0.8,
                child: Row(
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedCreditCard,
                      size: PSize.arw(context, 45),
                    ),
                    SizedBox(
                      width: PSize.arw(context, 8),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HDFC Bank',
                          style: TextStyle(
                            fontSize: PSize.arw(context, 14),
                            color: PColors.primaryText(context),
                          ),
                        ),
                        Text(
                          'Balance: ₹ 98,468.90',
                          style: TextStyle(
                            fontSize: PSize.arw(context, 12),
                            color: PColors.secondaryText(context),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PColors.primary(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        minimumSize: Size(
                          PSize.arw(context, 54),
                          PSize.arh(context, 42),
                        ),
                      ),
                      child: Text(
                        'Change',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 14),
                          color: PColors.primaryText(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SmoothContainer(
                  width: PSize.displayWidth(context),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 4,
                    ),
                    shrinkWrap: true,
                    itemCount: buttons.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(100),
                        splashColor: PColors.primary(context).withOpacity(0.2),
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: buttons[index] == '⇦'
                                ? PColors.error
                                : buttons[index] == '000'
                                    ? PColors.primaryTextDark
                                    : PColors.containerSecondary(context),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          height: PSize.arh(context, 100),
                          width: PSize.arw(context, 100),
                          child: Center(
                            child: buttons[index] == '⇦'
                                ? Icon(
                                    Icons.backspace_rounded,
                                    size: PSize.arw(context, 20),
                                    color: PColors.primaryText(context),
                                  )
                                : Text(
                                    buttons[index],
                                    style: TextStyle(
                                      fontSize: PSize.arw(context, 20),
                                      color: buttons[index] == '000'
                                          ? PColors.primaryTextLight
                                          : PColors.primaryText(context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: PaysaPrimaryButton(
                  text: 'Add Transaction',
                  onTap: () {},
                  textColor: PColors.primaryText(context),
                ),
              ),
              SizedBox(
                height: PSize.arh(
                  context,
                  8,
                ),
              ),
            ],
          ),
          Obx(() => Visibility(
                visible: isBottomsheetOpen.value,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 4,
                    sigmaY: 4,
                  ),
                  child: SizedBox(
                    height: PSize.displayHeight(context),
                    width: PSize.displayWidth(context),
                    //blur effect
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void showContactBottomSheet(BuildContext context) {
    showModalBottomSheet(
      transitionAnimationController: _animationController,
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Contacts',
                      style: TextStyle(
                        fontSize: PSize.arw(context, 40),
                        fontWeight: FontWeight.w400,
                        color: PColors.primaryTextDark,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: PSize.arw(context, 26),
                        color: PColors.error,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: PSize.arw(context, 10)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Contacts',
                    hintStyle: TextStyle(
                      fontSize: PSize.arw(context, 14),
                      color: PColors.secondaryText(context),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: PColors.secondaryText(context),
                    ),
                    filled: true,
                    fillColor: PColors.containerSecondary(context),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: PSize.arw(context, 20)),
              SizedBox(
                height: PSize.arh(context, 80),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      10,
                      (i) => GestureDetector(
                        onTap: () {
                          setState(() {
                            String contact =
                                "${authController.user.value!.firstname ?? ""} ${authController.user.value!.lastname ?? ""}${i}";
                            if (!selectedContacts.contains(contact)) {
                              selectedContacts.add(contact);
                            } else {
                              PHelper.showErrorMessageGet(
                                  title: 'Contact Already Added',
                                  message: 'Contact Already Added');
                            }
                          });
                        },
                        child: Row(
                          children: [
                            SizedBox(width: PSize.arw(context, 10)),
                            Column(
                              children: [
                                SizedBox(
                                  height: PSize.arw(context, 50),
                                  width: PSize.arw(context, 50),
                                  child: RandomAvatar(
                                    "${authController.user.value!.firstname ?? ""} ${authController.user.value!.lastname ?? ""}${i}",
                                  ),
                                ),
                                SizedBox(width: PSize.arw(context, 10)),
                                Text(
                                  "${authController.user.value!.firstname} ${authController.user.value!.lastname}${i}",
                                  style: TextStyle(
                                    color: PColors.primaryTextDark,
                                    fontSize: PSize.arw(context, 14),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: PSize.arw(context, 10)),
                          ],
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
    ).whenComplete(() {
      isBottomsheetOpen.value = false;
    });
  }
}

class TransactionModeWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final void Function()? onTap;

  const TransactionModeWidget({
    super.key,
    this.label = 'Shopping',
    this.icon = HugeIcons.strokeRoundedShoppingBasket03,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? PColors.containerSecondary(context)
              : PColors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: PColors.primary(context),
              radius: PSize.arw(context, 24),
              child: Icon(
                icon,
                color: PColors.primaryText(context),
              ),
            ),
            Visibility(
              visible: isActive,
              child: SizedBox(
                width: PSize.arw(context, 8),
              ),
            ),
            Visibility(
              visible: isActive,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  color: PColors.primaryText(context),
                ),
              ),
            ),
            Visibility(
              visible: isActive,
              child: SizedBox(
                width: PSize.arw(context, 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
