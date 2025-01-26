import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Controllers/contact_controller.dart';
import 'package:paysa/Controllers/new_spending_controller.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NewSpendingView extends StatefulWidget {
  const NewSpendingView({super.key});

  @override
  State<NewSpendingView> createState() => _NewSpendingViewState();
}

class _NewSpendingViewState extends State<NewSpendingView>
    with SingleTickerProviderStateMixin {
  RxBool isBottomsheetOpen = false.obs;

  // Rx<Contact?> transferContact = Rx<Contact?>(null);
  // RxList<Contact> searchedContacts = <Contact>[].obs;

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
    '.',
    '0',
    '⇦'
  ];
  late AnimationController _animationController;

  final NewSpendingController newSpendingController = NewSpendingController();
  final authController = Get.find<AuthenticationController>();

  ContactsController contactController = Get.find<ContactsController>();

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

  void searchContact(String query) {
    log('Searching: $query');

    if (query.isEmpty) {
      newSpendingController.searchedContacts.value = contactController.contacts;
      return;
    }
    // finad match in nuber or name
    newSpendingController.searchedContacts.value = contactController.contacts
        .where((element) =>
            element.displayName!.toLowerCase().contains(query.toLowerCase()) ||
            element.phones.any((element) => element.number!.contains(query)))
        .toList();
  }

  void buttonPressed(String buttonText) {
    log('Button Pressed: $buttonText');

    if (newSpendingController.amount.value.contains('.') &&
        (newSpendingController.amount.value.split('.').last.length > 1) &&
        buttonText != '⇦') {
      return;
    }

    if (buttonText == '0' && newSpendingController.amount.value == '0') {
      return;
    }

    if (buttonText == '.' && newSpendingController.amount.value.contains('.')) {
      return;
    }

    if (buttonText == '⇦') {
      newSpendingController.amount.value = newSpendingController.amount.value
          .substring(0, newSpendingController.amount.value.length - 1);
    } else {
      newSpendingController.amount.value += buttonText;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyUi = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TransactionModeWidget(
                label: 'Shopping',
                icon: HugeIcons.strokeRoundedShoppingBasket03,
                isActive: newSpendingController.spendingMode.value ==
                    SpendingType.shopping,
                onTap: () {
                  newSpendingController.spendingMode.value =
                      SpendingType.shopping;
                },
              ),
              TransactionModeWidget(
                label: 'Transfer',
                icon: HugeIcons.strokeRoundedTransaction,
                isActive: newSpendingController.spendingMode.value ==
                    SpendingType.transfer,
                onTap: () {
                  newSpendingController.spendingMode.value =
                      SpendingType.transfer;
                },
              ),
              TransactionModeWidget(
                label: 'Bill Split',
                icon: HugeIcons.strokeRoundedUserGroup,
                isActive: newSpendingController.spendingMode.value ==
                    SpendingType.split,
                onTap: () {
                  newSpendingController.spendingMode.value = SpendingType.split;
                },
              ),
            ],
          ),
        ),
        SmoothContainer(
          width: PSize.displayWidth(context),
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: 12,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          color: PColors.containerSecondary(context),
          borderRadius: BorderRadius.circular(16),
          smoothness: 0.8,
          child: Row(
            children: [
              Icon(
                HugeIcons.strokeRoundedImage01,
                size: PSize.arw(context, 45),
              ),
              SizedBox(
                width: PSize.arw(context, 8),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add a receipt',
                    style: TextStyle(
                      fontSize: PSize.arw(context, 14),
                      color: PColors.primaryText(context),
                    ),
                  ),
                  Text(
                    'Add a receipt to keep track of your spending',
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
                  '   Add   ',
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
        SmoothContainer(
          width: PSize.displayWidth(context),
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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

        const Spacer(),

        // money input

        Obx(
          () => Center(
            child: Text(
              '₹ ${newSpendingController.amount.value}',
              style: TextStyle(
                fontSize: PSize.arw(context, 63),
                color: PColors.primaryText(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        Center(
          child: SmoothContainer(
            width: PSize.arw(context, 225),
            height: PSize.arh(context, 36),
            color: PColors.containerSecondary(context),
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: TextField(
                controller: newSpendingController.messageControler,
                onChanged: (value) {
                  // newSpendingController.amount.value = value;
                  log("length: ${value.length}");
                },
                decoration: InputDecoration(
                  hintText: 'Add a message',
                  hintStyle: TextStyle(
                    fontSize: PSize.arw(context, 10),
                    color: PColors.secondaryText(context),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: PColors.transparent,
                  focusColor: PColors.transparent,
                  hoverColor: PColors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontSize: PSize.arw(context, 12),
                  color: PColors.primaryText(context),
                ),
                minLines: 1,
                maxLength: 30,
                buildCounter: (
                  BuildContext context, {
                  required int currentLength,
                  required bool isFocused,
                  required int? maxLength,
                }) {
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ),

        const Spacer(),
        Obx(
          // 3622668
          () => Visibility(
            visible: newSpendingController.spendingMode.value == 'Transfer',
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: ZoomTapAnimation(
              onTap: () {
                log('Tapped ${contactController.contacts.length}');
                TextEditingController _searchController =
                    TextEditingController();
                Get.bottomSheet(Container(
                  height: PSize.arh(context, 400),
                  color: PColors.background(context),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: PSize.arw(context, 16),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            Text(
                              'Select a contact',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 18),
                                color: PColors.primaryText(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          searchContact(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search contact',
                          hintStyle: TextStyle(
                            fontSize: PSize.arw(context, 14),
                            color: PColors.secondaryText(context),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: PColors.containerSecondary(context),
                          focusColor: PColors.containerSecondary(context),
                          hoverColor: PColors.containerSecondary(context),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: ListView.builder(
                            itemCount:
                                newSpendingController.searchedContacts.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: newSpendingController
                                            .searchedContacts[index].photo !=
                                        null
                                    ? CircleAvatar(
                                        backgroundImage: MemoryImage(
                                          newSpendingController
                                              .searchedContacts[index].photo!,
                                        ),
                                        radius: PSize.arw(context, 20),
                                      )
                                    : RandomAvatar(
                                        newSpendingController
                                            .searchedContacts[index]
                                            .displayName,
                                        width: PSize.arw(context, 40),
                                      ),
                                title: Text(
                                  newSpendingController.searchedContacts[index]
                                          .displayName ??
                                      '',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 14),
                                    color: PColors.primaryText(context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  newSpendingController.searchedContacts[index]
                                          .phones.first.number ??
                                      '',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 12),
                                    color: PColors.secondaryText(context),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onTap: () {
                                  newSpendingController.transferContact.value =
                                      newSpendingController
                                          .searchedContacts[index];
                                  Get.back();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              },
              child: newSpendingController.transferContact.value != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListTile(
                        leading: newSpendingController
                                    .transferContact.value!.photo !=
                                null
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(
                                  newSpendingController
                                      .transferContact.value!.photo!,
                                ),
                                radius: PSize.arw(context, 20),
                              )
                            : RandomAvatar(
                                newSpendingController
                                    .transferContact.value!.displayName,
                                width: PSize.arw(context, 40),
                              ),
                        title: Text(
                          newSpendingController
                                  .transferContact.value!.displayName ??
                              '',
                          style: TextStyle(
                            fontSize: PSize.arw(context, 14),
                            color: PColors.primaryText(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          newSpendingController
                                  .transferContact.value!.phones.first.number ??
                              '',
                          style: TextStyle(
                            fontSize: PSize.arw(context, 12),
                            color: PColors.secondaryText(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            newSpendingController.transferContact.value = null;
                          },
                          child: Icon(
                            Iconsax.close_circle,
                            color: PColors.error,
                            size: PSize.arw(context, 27),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ListTile(
                        leading: Icon(
                          Iconsax.user,
                          size: PSize.arw(context, 40),
                          color: PColors.primaryText(context),
                        ),
                        title: Text(
                          'Select a contact',
                          style: TextStyle(
                            fontSize: PSize.arw(context, 14),
                            color: PColors.primaryText(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

              // : Container(
              //     width: PSize.displayWidth(context),
              //     margin: const EdgeInsets.symmetric(horizontal: 12),
              //     padding: const EdgeInsets.symmetric(vertical: 12),
              //     decoration: BoxDecoration(
              //       color: PColors.primary(context),
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "Select a contact",
              //         style: TextStyle(
              //           fontSize: PSize.arw(context, 14),
              //           color: PColors.primaryText(context),
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ),
              //   ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmoothContainer(
            width: PSize.displayWidth(context),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  onTap: () {
                    buttonPressed(buttons[index]);
                  },
                  onLongPress: () {
                    if (buttons[index] == '⇦') {
                      newSpendingController.amount.value = '';
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: buttons[index] == '⇦'
                          ? PColors.error
                          : buttons[index] == '.'
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
                          : buttons[index] == '.'
                              ? Icon(
                                  Icons.circle,
                                  size: PSize.arw(context, 9),
                                  color: PColors.primaryTextLight,
                                )
                              : Text(
                                  buttons[index],
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 20),
                                    color: buttons[index] == '.'
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
    );

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
            newSpendingController.spendingMode.value.value,
            style: TextStyle(
              fontSize: PSize.arw(context, 18),
              color: PColors.primaryText(context),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Platform.isIOS ? bodyUi : SafeArea(child: bodyUi),
    );
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
        curve: Curves.fastEaseInToSlowEaseOut,
        width: PSize.arw(context, 126),
        height: PSize.arh(context, 63),
        decoration: BoxDecoration(
          color: isActive
              ? PColors.primary(context)
              : PColors.containerSecondary(context),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: PSize.arw(context, 20),
              color: isActive
                  ? PColors.primaryText(context)
                  : PColors.primaryText(context).withAlpha(162),
            ),
            SizedBox(
              width: PSize.arw(context, 8),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: PSize.arw(context, 14),
                color: isActive
                    ? PColors.primaryText(context)
                    : PColors.primaryText(context).withAlpha(162),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
