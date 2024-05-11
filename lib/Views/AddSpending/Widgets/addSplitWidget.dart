import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/AddSpendingController.dart';
import 'package:paysa/Models/SplitModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/utils/constants/cherryToast.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

class AddSplitWidget extends StatelessWidget {
  const AddSplitWidget({
    super.key,
    required this.addSpendingController,
  });

  final AddSpendingController addSpendingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                Row(
                  children: [
                    const Text(
                      'Splits',
                      style: TextStyle(
                        color: TColors.textWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // Add myself
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: TColors.primary.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(52, 40),
                      ),
                      onPressed: () {
                        if (addSpendingController
                            .amountController.text.isEmpty) {
                          showErrorToast(context, "Please enter amount");
                          return;
                        }
                        if (addSpendingController.splits.any((element) =>
                            element.uid ==
                            FirebaseAuth.instance.currentUser!.uid)) {
                          showErrorToast(context, "User already added");
                          return;
                        }

                        Split sp = Split(
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          amount: double.parse(
                                addSpendingController.amountController.text,
                              ) /
                              ((addSpendingController.splits.length == 0
                                      ? 1
                                      : addSpendingController.splits.length) +
                                  1),
                          paid: addSpendingController.paidBy ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? true
                              : false,
                        );
                        addSpendingController.splits.add(
                          sp,
                        );

                        // addSpendingController.paidBy.value = UserModel(
                        //   uid: FirebaseAuth.instance.currentUser!.uid,
                        //   name: FirebaseAuth.instance.currentUser!.displayName!,
                        //   email: FirebaseAuth.instance.currentUser!.email!,
                        //   profile: FirebaseAuth.instance.currentUser!.photoURL!,
                        //   phone: "",
                        // );
                        addSpendingController.users.add(
                          UserModel(
                            uid: FirebaseAuth.instance.currentUser!.uid,
                            name:
                                FirebaseAuth.instance.currentUser!.displayName!,
                            email: FirebaseAuth.instance.currentUser!.email!,
                            profile:
                                FirebaseAuth.instance.currentUser!.photoURL!,
                            phone: "",
                          ),
                        );
                      },
                      child: Text(
                        'Add Myself',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
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
                              showErrorToast(context, "Please enter amount");
                              return;
                            }

                            double splitAmount = double.parse(
                                    addSpendingController
                                        .amountController.text) /
                                (addSpendingController.splits.isEmpty
                                    ? 1
                                    : addSpendingController.splits.length + 1);
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
                                          disabledBorder: OutlineInputBorder(
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
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            child: IconButton(
                                              onPressed: () {
                                                double amount = double.parse(
                                                    amountController.text);
                                                amount = max(0, amount - 1);
                                                amountController.text =
                                                    amount.toStringAsFixed(2);
                                              },
                                              icon: const Icon(Iconsax.minus),
                                              color: TColors.textWhite,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                TSizes.displayWidth(context) *
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
                                                if (double.parse(value) <= 0) {
                                                  amountController.text = '0';
                                                  return;
                                                }
                                                if (double.parse(value) >
                                                    splitAmount) {
                                                  amountController.text =
                                                      splitAmount
                                                          .toStringAsFixed(2);
                                                }
                                              },
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                prefixText: '₹ ',
                                                prefixStyle: const TextStyle(
                                                  color: TColors.textWhite,
                                                ),
                                                constraints: BoxConstraints(
                                                  minHeight: 54,
                                                  minWidth: TSizes.displayWidth(
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
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                    color: TColors.transparent,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                    color: TColors.transparent,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                    color: TColors.transparent,
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
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            child: IconButton(
                                              onPressed: () {
                                                double amount = double.parse(
                                                    amountController.text);
                                                if (amount ==
                                                    double.parse(
                                                        addSpendingController
                                                            .amountController
                                                            .text)) {
                                                  return;
                                                }
                                                amount = max(0, amount + 1);
                                                amountController.text =
                                                    amount.toStringAsFixed(2);
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
                                              activeColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              activeTrackColor: TColors.primary
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
                                          showErrorToast(
                                              context, "Please enter email");
                                          return;
                                        }

                                        if (amountController.text.isEmpty) {
                                          showErrorToast(
                                              context, "Please enter amount");
                                          return;
                                        }

                                        if (double.parse(
                                                amountController.text) <=
                                            0) {
                                          showErrorToast(context,
                                              "Amount cannot be 0 or negative");
                                          return;
                                        }

                                        UserModel? user =
                                            await UserModel.getUserModelByEmail(
                                                emailController.text, context);

                                        if (addSpendingController.splits.any(
                                            (element) =>
                                                element.uid == user!.uid)) {
                                          showErrorToast(
                                              context, "User already added");
                                          return;
                                        }

                                        addSpendingController.users.add(user!);

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
                                        'Add Member',
                                        style: TextStyle(
                                          color: TColors.textWhite,
                                        ),
                                      ),
                                    ),
                                    // Add myself
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
                                    addSpendingController.splits[index].uid),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }

                                  if (snapshot.hasError) {
                                    return const Text('Error');
                                  }

                                  UserModel usr = UserModel.fromJson(
                                      snapshot.data as Map<String, dynamic>);

                                  return Row(
                                    children: [
                                      CircleAvatar(
                                        radius:
                                            TSizes.displayWidth(context) * 0.04,
                                        backgroundImage: NetworkImage(
                                          usr.profile,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: Text(
                                          usr.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
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
      ],
    );
  }
}
