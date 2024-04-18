import 'dart:developer';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/AddSpendingController.dart';
import 'package:paysa/Controllers/DailySpendingsController.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/SplitModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/Views/AddSpending/Widgets/spendingIconWidget.dart';
import 'package:paysa/utils/appbar/appbar.dart';
import 'package:paysa/utils/constants/cherryToast.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';
import 'package:pull_down_button/pull_down_button.dart';
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

  // final DailySpendingController dailySpendingController =
  //     Get.put(DailySpendingController());
  PageController pageController = PageController();
  AddSpendingController addSpendingController =
      Get.put(AddSpendingController());
  final TextEditingController splitMemberEmail = TextEditingController();
  final TextEditingController splitAmount = TextEditingController();

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
          mainAxisSize: MainAxisSize.min,
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),

            SpendingsIconWidget(
                context: context, addSpendingController: addSpendingController),
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),

            SpendingsIconWidget(
                context: context, addSpendingController: addSpendingController),

            const SizedBox(width: 20),

            const SizedBox(
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
                borderRadius: BorderRadius.circular(16),
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
                        borderRadius: BorderRadius.circular(8),
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

            // Members Split with amount

            Obx(
              () => Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: TColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: TColors.light.withOpacity(0.2),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Splits',
                      style: TextStyle(
                        color: TColors.textWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(
                      addSpendingController.splits.length + 1,
                      (index) {
                        if (index == addSpendingController.splits.length) {
                          return TextButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TColors.white.withOpacity(0.1),
                                foregroundColor: TColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: TColors.white.withOpacity(0.6),
                                  ),
                                ),
                                minimumSize: const Size(double.infinity, 54),
                              ),
                              onPressed: () {
                                // show dialog for taking email and amount and add to splits list

                                if (addSpendingController
                                    .amountController.text.isEmpty) {
                                  showErrorToast(
                                      context, "Please enter amount");
                                  return;
                                }

                                double splitAmount = double.parse(
                                        addSpendingController
                                            .amountController.text) /
                                    (addSpendingController.splits.isEmpty
                                        ? 1
                                        : addSpendingController.splits.length +
                                            1);
                                TextEditingController emailController =
                                    TextEditingController();
                                TextEditingController amountController =
                                    TextEditingController(
                                  text: splitAmount.toStringAsFixed(2),
                                );
                                RxBool paid = false.obs;

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: TColors.dark,
                                      title: const Text(
                                        'Split member',
                                        style: TextStyle(
                                          color: TColors.textWhite,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: emailController,
                                            style: const TextStyle(
                                              color: TColors.textWhite,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Enter Email',
                                              hintStyle: TextStyle(
                                                color: TColors.textWhite
                                                    .withOpacity(0.5),
                                              ),
                                              fillColor: Colors.transparent,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: TColors.white,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: TColors.white
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: TColors.white,
                                                ),
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    TColors.primary,
                                                child: IconButton(
                                                  onPressed: () {
                                                    double amount =
                                                        double.parse(
                                                            amountController
                                                                .text);
                                                    amount = max(0, amount - 1);
                                                    amountController.text =
                                                        amount
                                                            .toStringAsFixed(2);
                                                  },
                                                  icon:
                                                      const Icon(Iconsax.minus),
                                                  color: TColors.textWhite,
                                                ),
                                              ),
                                              SizedBox(
                                                width: TSizes.displayWidth(
                                                        context) *
                                                    0.2,
                                                child: TextField(
                                                  controller: amountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    // decimal input with only 2 decimal places
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                      RegExp(r'^\d+\.?\d{0,2}'),
                                                    ),
                                                  ],
                                                  onChanged: (value) {
                                                    if (double.parse(value) <=
                                                        0) {
                                                      amountController.text =
                                                          '0';
                                                      return;
                                                    }
                                                    if (double.parse(value) >
                                                        splitAmount) {
                                                      amountController.text =
                                                          splitAmount
                                                              .toStringAsFixed(
                                                                  2);
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16,
                                                            vertical: 10),
                                                    prefixText: '₹ ',
                                                    prefixStyle:
                                                        const TextStyle(
                                                      color: TColors.textWhite,
                                                    ),
                                                    constraints: BoxConstraints(
                                                      minHeight: 54,
                                                      minWidth:
                                                          TSizes.displayWidth(
                                                                  context) *
                                                              0.05,
                                                    ),
                                                    hintText: '0.0',
                                                    hintStyle: TextStyle(
                                                      color: TColors.textWhite
                                                          .withOpacity(0.5),
                                                    ),
                                                    fillColor: TColors
                                                        .darkBackground
                                                        .withOpacity(0.8),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      borderSide: BorderSide(
                                                        color:
                                                            TColors.transparent,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      borderSide: BorderSide(
                                                        color:
                                                            TColors.transparent,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      borderSide: BorderSide(
                                                        color:
                                                            TColors.transparent,
                                                      ),
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                  style: const TextStyle(
                                                    color: TColors.textWhite,
                                                  ),
                                                ),
                                              ),
                                              CircleAvatar(
                                                backgroundColor:
                                                    TColors.primary,
                                                child: IconButton(
                                                  onPressed: () {
                                                    double amount =
                                                        double.parse(
                                                            amountController
                                                                .text);
                                                    if (amount ==
                                                        double.parse(
                                                            addSpendingController
                                                                .amountController
                                                                .text)) {
                                                      return;
                                                    }
                                                    amount = max(0, amount + 1);
                                                    amountController.text =
                                                        amount
                                                            .toStringAsFixed(2);
                                                  },
                                                  icon: const Icon(Iconsax.add),
                                                  color: TColors.textWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Text(
                                                'Paid',
                                                style: TextStyle(
                                                  color: TColors.textWhite,
                                                ),
                                              ),
                                              Obx(
                                                () => Switch(
                                                  value: paid.value,
                                                  onChanged: (value) {
                                                    paid.value = value;
                                                  },
                                                  activeColor: TColors.primary,
                                                  activeTrackColor: TColors
                                                      .primary
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: TColors.textWhite,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            if (emailController.text.isEmpty) {
                                              showErrorToast(context,
                                                  "Please enter email");
                                              return;
                                            }

                                            if (amountController.text.isEmpty) {
                                              showErrorToast(context,
                                                  "Please enter amount");
                                              return;
                                            }

                                            if (double.parse(
                                                    amountController.text) <=
                                                0) {
                                              showErrorToast(context,
                                                  "Amount cannot be 0 or negative");
                                              return;
                                            }

                                            UserModel? user = await UserModel
                                                .getUserModelByEmail(
                                                    emailController.text,
                                                    context);

                                            if (addSpendingController.splits
                                                .any((element) =>
                                                    element.uid == user!.uid)) {
                                              showErrorToast(context,
                                                  "User already added");
                                              return;
                                            }

                                            addSpendingController.users
                                                .add(user!);

                                            if (user != null) {
                                              addSpendingController.splits.add(
                                                Split(
                                                  uid: user.uid,
                                                  amount: double.parse(
                                                      amountController.text),
                                                  paid: paid.value,
                                                ),
                                              );
                                              Get.back();
                                            }
                                          },
                                          child: const Text(
                                            'Add',
                                            style: TextStyle(
                                              color: TColors.textWhite,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text('Add Member'));
                        }
                        return Row(
                          children: [
                            Flexible(
                              child: Expanded(
                                flex: 2,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: TColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: TColors.light.withOpacity(0.2),
                                    ),
                                  ),
                                  child: FutureBuilder(
                                    future: FireStoreRef.getuserByUid(
                                        addSpendingController
                                            .splits[index].uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }

                                      if (snapshot.hasError) {
                                        return const Text('Error');
                                      }

                                      UserModel usr = UserModel.fromJson(
                                          snapshot.data
                                              as Map<String, dynamic>);

                                      return Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                              usr.profile,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            usr.name,
                                            style: const TextStyle(
                                              color: TColors.textWhite,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Amount Split

                            Container(
                              padding: const EdgeInsets.all(16),
                              // decoration: BoxDecoration(
                              //   color: TColors.white.withOpacity(0.1),
                              //   borderRadius: BorderRadius.circular(16),
                              // ),
                              child: Text(
                                '₹ ${addSpendingController.splits[index].amount}',
                                style: const TextStyle(
                                  color: TColors.textWhite,
                                  fontSize: 18,
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () async {
                                addSpendingController.splits.removeAt(index);
                                addSpendingController.users.removeAt(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: TColors.error,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: TColors.light.withOpacity(0.2),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: TColors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Paid By
            Container(
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: TColors.light.withOpacity(0.2),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Paid By',
                    style: TextStyle(
                      color: TColors.textWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  PullDownButton(
                    itemBuilder: (context) {
                      return List.generate(
                        addSpendingController.users.length,
                        (index) {
                          return PullDownMenuItem(
                            onTap: () {
                              addSpendingController.paidBy.value =
                                  addSpendingController.users[index];
                            },
                            title: addSpendingController.users[index].name,
                          );
                        },
                      );
                    },
                    buttonBuilder: (context, showMenu) {
                      return GestureDetector(
                        onTap: () async {
                          // pick date and time
                          showMenu();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: TColors.light.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                addSpendingController.paidBy.value.name.isEmpty
                                    ? "Tap to select"
                                    : addSpendingController.paidBy.value.name,
                                style: const TextStyle(
                                  color: TColors.textWhite,
                                  fontSize: 18,
                                ),
                              ),
                              const Icon(
                                Iconsax.user,
                                color: TColors.textWhite,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Add Split Button

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
                if (addSpendingController.splits.isEmpty) {
                  showErrorToast(context, "Please add splits");
                  return;
                }

                if (widget.fromEdit) {
                  return;
                }
                addSpendingController.addSplit();
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
                    widget.fromEdit ? 'Update Split' : 'Add Split',
                    style: const TextStyle(
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
