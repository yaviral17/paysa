import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Controllers/new_spending_controller.dart';
import 'package:paysa/Models/user_split_model.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/NewSpending/split_flow/add_memebers_view.dart';
import 'package:paysa/Views/auth/login/login_view.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddSplitDataView extends StatefulWidget {
  const AddSplitDataView({super.key});

  @override
  State<AddSplitDataView> createState() => _AddSplitDataViewState();
}

class _AddSplitDataViewState extends State<AddSplitDataView> {
  final NewSpendingController newSpendingController =
      Get.find<NewSpendingController>();

  final AuthenticationController authController =
      Get.find<AuthenticationController>();

  int splitMode = 0;

  @override
  void initState() {
    super.initState();
    newSpendingController.splitmembers.add(
      UserSplitModel(
        user: authController.user.value,
        amount: "0",
        createdAt: DateTime.now().toIso8601String(),
        isPaid: true,
        token: authController.user.value!.token,
        uid: authController.user.value!.uid!,
        paidAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  void changeSplitMode(int mode) {
    splitMode = mode;
    if (mode == 0) {
      // equally

      for (var user in newSpendingController.splitmembers) {
        user.amount = ((double.parse(newSpendingController.amount.value) /
                    newSpendingController.splitmembers.length)
                .toPrecision(2))
            .toString();
      }
    } else if (mode == 1) {
      // amount
    }
    // else if (mode == 2) {
    //   // portion
    // } else if (mode == 3) {
    //   // percentage
    // }
    setState(() {});
    // newSpendingController.createSpending();
  }

  Future getFile() async {
    try {
      FilePickerResult? result;
      if (Platform.isIOS) {
        bool fromGallary = false;
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Select receipt from'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () async {
                    await FilePicker.platform
                        .pickFiles(
                      type: FileType.image,
                    )
                        .then(
                      (value) {
                        newSpendingController.image.value =
                            File(value!.files.single.path!);
                      },
                    );

                    fromGallary = true;
                    Navigator.pop(context);
                  },
                  child: Text('Gallery'),
                ),
                CupertinoDialogAction(
                  onPressed: () async {
                    await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: [
                        'webp',
                        'jpg',
                        'jpeg',
                        'png',
                        'pdf',
                        'doc',
                        'docx',
                        'xls',
                        'xlsx'
                      ],
                    ).then((value) {
                      newSpendingController.image.value =
                          File(value!.files.single.path!);
                      return value;
                    });
                    fromGallary = false;
                    Navigator.pop(context);
                  },
                  child: Text('Files'),
                ),
              ],
            );
          },
        );
      } else {
        FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: [
            'webp',
            'jpg',
            'jpeg',
            'png',
            'pdf',
            'doc',
            'docx',
            'xls',
            'xlsx'
          ],
        ).then((value) {
          newSpendingController.image.value = File(value!.files.single.path!);
          return value;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void createSplit() {
    // create split
    double amount = 0;
    for (var user in newSpendingController.splitmembers) {
      amount += double.parse(user.amount);
    }
    log("Amount Mismatch: $amount != ${newSpendingController.amount.value}");
    if (amount != double.parse(newSpendingController.amount.value)) {
      log("Amount Mismatch: $amount != ${newSpendingController.amount.value}");
      PHelper.showErrorMessageGet(
        title: "Amount Mismatch 😕",
        message: "The total amount and the split amount do not match",
      );
      return;
    }
    newSpendingController.createSpending();
  }

  @override
  Widget build(BuildContext context) {
    List<IconData> splitOptions = [
      Icons.safety_divider,
      Icons.currency_rupee,
      HugeIcons.strokeRoundedPieChart,
      HugeIcons.strokeRoundedPercentSquare,
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Split Data",
          style: TextStyle(
            fontSize: PSize.arw(context, 20),
            fontWeight: FontWeight.bold,
            color: PColors.primaryText(context),
          ),
        ),
        backgroundColor: PColors.background(context),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: PSize.arw(context, 16),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(
        () => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: PSize.arh(context, 12),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "TOTAL BILL AMOUNT",
                            style: TextStyle(
                              fontSize: PSize.arw(context, 16),
                              fontWeight: FontWeight.w600,
                              letterSpacing: -1,
                              color: PColors.secondaryText(context),
                            ),
                          ),
                          SizedBox(
                            height: PSize.arw(context, 4),
                          ),
                          Text(
                            "₹ ${newSpendingController.amount}",
                            style: TextStyle(
                              fontSize: PSize.arw(context, 40),
                              color: PColors.primaryText(context),
                              letterSpacing: -1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: PSize.arw(context, 12),
                    ),
                    // bill file upload
                    Expanded(
                      child: newSpendingController.image.value.path.isEmpty
                          ? ZoomTapAnimation(
                              onTap: () {
                                // upload bill
                                getFile();
                              },
                              child: Container(
                                width: PSize.arw(context, 120),
                                height: PSize.arw(context, 120),
                                decoration: BoxDecoration(
                                  color: PColors.containerSecondary(context),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Select Bill",
                                      style: TextStyle(
                                        fontSize: PSize.arw(context, 16),
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -1,
                                        color: PColors.secondaryText(context),
                                      ),
                                    ),
                                    SizedBox(
                                      height: PSize.arw(context, 4),
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.upload_file,
                                        size: PSize.arw(context, 40),
                                        color: PColors.secondaryText(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ZoomTapAnimation(
                              onTap: () {
                                // upload bill
                                getFile();
                              },
                              child: Container(
                                width: PSize.arw(context, 120),
                                height: PSize.arw(context, 120),
                                decoration: BoxDecoration(
                                  color: PColors.containerSecondary(context),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 4),
                                      child: Text(
                                        newSpendingController.image.value.path
                                            .split('/')
                                            .last,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: PSize.arw(context, 16),
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -1,
                                          color: PColors.secondaryText(context),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: PSize.arw(context, 4),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: PColors.primary(context),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Change",
                                            style: TextStyle(
                                              fontSize: PSize.arw(context, 16),
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -1,
                                              color:
                                                  PColors.primaryText(context),
                                            ),
                                          ),
                                          Icon(
                                            Icons.loop,
                                            size: PSize.arw(context, 20),
                                            color: PColors.primaryText(context),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: PSize.arh(context, 36),
              ),

              // divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      margin: const EdgeInsets.symmetric(horizontal: 18.0),
                      // width: PSize.displayWidth(context),
                      height: 50,
                      decoration: BoxDecoration(
                        color: PColors.containerSecondary(context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Split Mode",
                            style: TextStyle(
                              fontSize: PSize.arw(context, 16),
                              fontWeight: FontWeight.w600,
                              color: PColors.primaryText(context),
                            ),
                          ),
                          PullDownButton(
                            itemBuilder: (context) => [
                              PullDownMenuItem(
                                title: 'Equally',
                                onTap: () {
                                  changeSplitMode(0);
                                  // setState(() {
                                  //   splitMode = 0;
                                  // });
                                },
                              ),
                              PullDownMenuItem(
                                title: 'Amount',
                                onTap: () {
                                  changeSplitMode(1);
                                  // setState(() {
                                  //   splitMode = 1;
                                  // });
                                },
                              ),
                              // PullDownMenuItem(
                              //   title: 'Portion',
                              //   onTap: () {
                              //     setState(() {
                              //       splitMode = 2;
                              //     });
                              //   },
                              // ),
                              // PullDownMenuItem(
                              //   title: 'Percentage',
                              //   onTap: () {
                              //     setState(() {
                              //       splitMode = 3;
                              //     });
                              //   },
                              // ),
                            ],
                            buttonBuilder: (context, showMenu) =>
                                CupertinoButton(
                              onPressed: showMenu,
                              padding: EdgeInsets.zero,
                              child: Row(
                                children: [
                                  Icon(
                                    splitOptions[splitMode],
                                    size: PSize.arw(context, 20),
                                    color: PColors.primary(context),
                                  ),
                                  SizedBox(
                                    width: PSize.arw(context, 4),
                                  ),
                                  Text(
                                    splitMode == 0
                                        ? "Equally"
                                        : splitMode == 1
                                            ? "Amount"
                                            : splitMode == 2
                                                ? "Portion"
                                                : "Percentage",
                                    style: TextStyle(
                                      fontSize: PSize.arw(context, 18),
                                      fontWeight: FontWeight.w600,
                                      color: PColors.primary(context),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: PSize.arw(context, 16),
                                    color: PColors.primary(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (newSpendingController.splitmembers.isNotEmpty)
                    ZoomTapAnimation(
                      onTap: () {
                        PNavigate.to(AddMemebersView());
                      },
                      child: SmoothContainer(
                        width: PSize.arw(context, 50),
                        height: PSize.arw(context, 50),
                        color: PColors.primary(context),
                        borderRadius: BorderRadius.circular(10),
                        child: Center(
                          child: Icon(
                            Icons.person_add,
                          ),
                        ),
                      ),
                    ),
                  if (newSpendingController.splitmembers.isNotEmpty)
                    SizedBox(
                      width: PSize.arw(context, 18),
                    ),
                ],
              ),
              SizedBox(
                height: PSize.arh(context, 12),
              ),
              // list of members

              newSpendingController.splitmembers.isEmpty
                  ? Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 18,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: PSize.arh(context, 12),
                              ),
                              Text(
                                "No Member Added Yet",
                                style: TextStyle(
                                  fontSize: PSize.arw(context, 20),
                                  fontWeight: FontWeight.w600,
                                  color: PColors.primaryText(context),
                                ),
                              ),
                              SizedBox(
                                height: PSize.arh(context, 4),
                              ),
                              Text(
                                "Add members to split the bill by clicking the button above",
                                style: TextStyle(
                                  fontSize: PSize.arw(context, 12),
                                  fontWeight: FontWeight.w400,
                                  color: PColors.secondaryText(context),
                                ),
                              ),
                              SizedBox(
                                height: PSize.arh(context, 12),
                              ),
                              ZoomTapAnimation(
                                onTap: () {
                                  PNavigate.to(AddMemebersView());
                                },
                                child: SmoothContainer(
                                  width: PSize.arw(context, 120),
                                  height: PSize.arw(context, 50),
                                  color: PColors.primary(context),
                                  padding: EdgeInsets.symmetric(horizontal: 18),
                                  borderRadius: BorderRadius.circular(10),
                                  child: FittedBox(
                                    child: Text(
                                      "Add Members",
                                      style: TextStyle(
                                        fontSize: PSize.arw(context, 18),
                                        fontWeight: FontWeight.w600,
                                        color: PColors.background(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: newSpendingController.splitmembers.length,
                        itemBuilder: (context, index) {
                          UserSplitModel data =
                              newSpendingController.splitmembers[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 18,
                            ),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              children: [
                                RandomAvatar(
                                  data.user!.username!,
                                  height: PSize.arh(context, 40),
                                ),
                                SizedBox(
                                  width: PSize.arw(context, 12),
                                ),
                                Text(
                                  authController.user.value!.uid ==
                                          data.user!.uid
                                      ? "You"
                                      : "${data.user!.username}",
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 16),
                                    fontWeight: FontWeight.w600,
                                    color: PColors.primaryText(context),
                                  ),
                                ),
                                Spacer(),
                                if (splitMode == 0)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      "₹ ${(double.parse(newSpendingController.amount.value) / newSpendingController.splitmembers.length).toPrecision(2)}",
                                      style: TextStyle(
                                        fontSize: PSize.arw(context, 16),
                                        fontWeight: FontWeight.w600,
                                        color: PColors.primaryText(context),
                                      ),
                                    ),
                                  ),
                                if (splitMode == 1)
                                  SizedBox(
                                    width: PSize.arw(context, 160),
                                    child: PaysaPrimaryTextField(
                                      prefixIcon: Icon(
                                        Icons.currency_rupee,
                                        color: PColors.primaryText(context),
                                        size: PSize.arw(context, 20),
                                      ),
                                      controller: TextEditingController(
                                        text: data.amount,
                                      ),
                                      onChanged: (value) {
                                        data.amount = value;
                                      },
                                      hintText: "Amount",
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    // Pulldown for selection Paid by
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(horizontal: 12),
                    //     margin: const EdgeInsets.only(right: 12.0),
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       color: PColors.containerSecondary(context),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: FittedBox(
                    //       child: PullDownButton(
                    //         itemBuilder: (context) => [
                    //           PullDownMenuItem(
                    //             title: 'You',
                    //             onTap: () {
                    //               // changeSplitMode(0);
                    //               // setState(() {
                    //               //   splitMode = 0;
                    //               // });
                    //             },
                    //           ),
                    //           PullDownMenuItem(
                    //             title: 'Someone Else',
                    //             onTap: () {
                    //               // changeSplitMode(1);
                    //               // setState(() {
                    //               //   splitMode = 1;
                    //               // });
                    //             },
                    //           ),
                    //         ],
                    //         buttonBuilder: (context, showMenu) =>
                    //             CupertinoButton(
                    //           onPressed: showMenu,
                    //           padding: EdgeInsets.zero,
                    //           child: Row(
                    //             children: [
                    //               Text(
                    //                 "Paid By",
                    //                 style: TextStyle(
                    //                   fontSize: PSize.arw(context, 16),
                    //                   fontWeight: FontWeight.w600,
                    //                   color: PColors.primaryText(context),
                    //                 ),
                    //               ),
                    //               Icon(
                    //                 Icons.person,
                    //                 size: PSize.arw(context, 20),
                    //                 color: PColors.primary(context),
                    //               ),
                    //               SizedBox(
                    //                 width: PSize.arw(context, 4),
                    //               ),
                    //               Text(
                    //                 "You",
                    //                 style: TextStyle(
                    //                   fontSize: PSize.arw(context, 18),
                    //                   fontWeight: FontWeight.w600,
                    //                   color: PColors.primary(context),
                    //                 ),
                    //               ),
                    //               Icon(
                    //                 Icons.keyboard_arrow_down_outlined,
                    //                 size: PSize.arw(context, 16),
                    //                 color: PColors.primary(context),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Expanded(
                      flex: 2,
                      child: PaysaPrimaryButton(
                        text: "Create Split",
                        isLoading: newSpendingController.isLoading.value,
                        borderRadius: 10,
                        isDisabled: newSpendingController.splitmembers.isEmpty,
                        onTap: () {
                          createSplit();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: PSize.arw(context, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
