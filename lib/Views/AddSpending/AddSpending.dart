import 'dart:developer';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/AddSpendingController.dart';
import 'package:paysa/Controllers/DailySpendingsController.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/SplitModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/utils/appbar/appbar.dart';
import 'package:paysa/utils/constants/cherryToast.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';
import 'package:uuid/uuid.dart';

class AddDailySpendingScreen extends StatefulWidget {
  AddDailySpendingScreen({
    required this.fromEdit,
  });

  final fromEdit;

  @override
  State<AddDailySpendingScreen> createState() => _AddDailySpendingScreenState();
}

class _AddDailySpendingScreenState extends State<AddDailySpendingScreen> {
  bool showMore = false;
  List<Split> splits = [];

  // final DailySpendingController dailySpendingController =
  //     Get.put(DailySpendingController());
  PageController pageController = PageController();
  AddSpendingController addSpendingController =
      Get.put(AddSpendingController());

  @override
  void initState() {
    // TODO: implement initState
    // THelperFunctions.hideBottomBlackStrip();

    pageController.addListener(() {
      if (pageController.page == 1) {
        addSpendingController.isSplit.value = true;
        return;
      }
      addSpendingController.isSplit.value = false;
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // THelperFunctions.hideBottomBlackStrip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // THelperFunctions.hideBottomBlackStrip();
    return Scaffold(
      extendBody: true,
      appBar: TAppBar(
        title: Obx(() => Text(addSpendingController.isSplit.value
            ? 'Add Split'
            : 'Add Spending')),
        showBackArrow: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: TColors.primaryDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            _topNav(),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _addSpending(),
                  _addSplit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topNav() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  pageController.jumpToPage(0);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: !addSpendingController.isSplit.value
                        ? Colors.white.withOpacity(0.1)
                        : TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: TColors.light.withOpacity(0.2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Add Spending',
                      style: TextStyle(
                        color: addSpendingController.isSplit.value
                            ? TColors.textWhite.withOpacity(0.5)
                            : TColors.textWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  pageController.jumpToPage(1);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: addSpendingController.isSplit.value
                        ? Colors.white.withOpacity(0.1)
                        : TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: TColors.light.withOpacity(0.2),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'Add Split',
                      style: TextStyle(
                        color: addSpendingController.isSplit.value
                            ? TColors.textWhite
                            : TColors.textWhite.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addSpending() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: TColors.light.withOpacity(0.2),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Select Icon",
                    style: TextStyle(
                      color: TColors.textWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Obx(
                        () => Column(
                          children: [
                            CircleAvatar(
                              radius: 63,
                              backgroundImage: AssetImage(
                                  'assets/expanses_category_icons/ic_${addSpendingController.category.value}.png'),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              // duration: const Duration(milliseconds: 300),
                              // curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: TColors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: Text(
                                addSpendingController
                                    .category.value.capitalize!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: TColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // height: 54,
                        width: TSizes.displayWidth(context) * 0.48,
                        height: TSizes.displayHeight(context) * 0.2,
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: TColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: DailySpendingModel
                                .DailySpendingCategories.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  (TSizes.displayWidth(context) ~/ 90),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  addSpendingController.category.value =
                                      DailySpendingModel
                                          .DailySpendingCategories[index];
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      TColors.primary.withOpacity(0.3),
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundImage: AssetImage(
                                        'assets/expanses_category_icons/ic_${DailySpendingModel.DailySpendingCategories[index]}.png'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),

            SizedBox(
              height: 20,
            ),

            // Title
            SpendingFeildWidget(
              textController: addSpendingController.titleController,
              hint: 'Enter Title',
              lable: 'Title',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),

            // Description
            SpendingFeildWidget(
              textController: addSpendingController.descriptionController,
              hint: 'Enter Description',
              lable: 'Description',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),

            // Amount
            SpendingFeildWidget(
              textController: addSpendingController.amountController,
              hint: 'Enter Amount',
              lable: 'Amount',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Date

            Container(
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: TColors.light.withOpacity(0.2),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(
                      color: TColors.textWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      // pick date and time
                      DateTime? picked =
                          await THelperFunctions.showDateTimeDialog(context);

                      if (picked != null) {
                        addSpendingController.timestamp = picked;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: TColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: TColors.light.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            THelperFunctions.getFormattedDate(
                              addSpendingController.timestamp ?? DateTime.now(),
                              format: 'dd MMM yyyy : hh:mm a',
                            ),
                            style: TextStyle(
                              color: TColors.textWhite,
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Iconsax.calendar_2,
                            color: TColors.textWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Add Spending Button

            GestureDetector(
              onTap: () async {
                if (addSpendingController.titleController.text.isEmpty ||
                    addSpendingController.descriptionController.text.isEmpty ||
                    addSpendingController.amountController.text.isEmpty) {
                  showErrorToast(context, "Please fill all the fields");
                  return;
                }
                if (double.parse(addSpendingController.amountController.text) <=
                    0) {
                  showErrorToast(context, "Amount cannot be 0 or negative");
                  return;
                }
                if (addSpendingController.category.value.isEmpty) {
                  showErrorToast(context, "Please select a category");
                  return;
                }
                if (addSpendingController.timestamp == null) {
                  showErrorToast(context, "Please select a date");
                  return;
                }
                if (addSpendingController.timestamp!.isAfter(DateTime.now())) {
                  showErrorToast(context, "Date cannot be in future");
                  return;
                }
                if (addSpendingController.isSplit.value) {
                  if (splits.isEmpty) {
                    showErrorToast(context, "Please add splits");
                    return;
                  }
                }
                if (!widget.fromEdit) {
                  addSpendingController.addDailySpending(
                    id: const Uuid().v1(),
                    title: addSpendingController.titleController.text,
                    description:
                        addSpendingController.descriptionController.text,
                    amount: double.parse(
                        addSpendingController.amountController.text),
                    category: addSpendingController.category.value,
                    timestamp: addSpendingController.timestamp!,
                    isSplit: addSpendingController.isSplit.value,
                  );
                }
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: TColors.light,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: TColors.light.withOpacity(0.2),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.fromEdit ? 'Update Spending' : 'Add Spending',
                    style: TextStyle(
                      color: TColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _addSplit() {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}

class SpendingFeildWidget extends StatelessWidget {
  const SpendingFeildWidget({
    super.key,
    required this.textController,
    required this.hint,
    required this.lable,
    required this.keyboardType,
  });

  final TextEditingController textController;
  final String hint;
  final String lable;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: TColors.light.withOpacity(0.2),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: TextStyle(
              color: TColors.textWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: textController,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: TColors.textWhite,
            ),
            decoration: InputDecoration(
              hintText: hint,
              fillColor: Colors.transparent,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: TColors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: TColors.white.withOpacity(0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: TColors.white,
                ),
              ),
              hintStyle: TextStyle(
                color: TColors.textWhite.withOpacity(0.5),
              ),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
