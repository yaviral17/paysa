import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SpendingDeatilsView extends StatefulWidget {
  final SpendingModel spendingModel;
  const SpendingDeatilsView({super.key, required this.spendingModel});

  @override
  State<SpendingDeatilsView> createState() => _SpendingDeatilsViewState();
}

class _SpendingDeatilsViewState extends State<SpendingDeatilsView> {
  SpendingModel? fromFirebase;

  Future<void> editSpending() async {
    if (widget.spendingModel.spendingType == SpendingType.shopping) {
    } else if (widget.spendingModel.spendingType == SpendingType.transfer) {
    } else if (widget.spendingModel.spendingType == SpendingType.split) {
      Get.bottomSheet(
        EditSpendingSheet(
          spendingModel: widget.spendingModel,
          onEdit: (spendingModel) {
            setState(() {
              fromFirebase = spendingModel;
            });
          },
          onCancel: (p0) {
            setState(() {
              fromFirebase = p0;
            });
          },
        ),
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.spendingModel.billImage, name: 'billImage');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: PColors.primaryText(context),
          ),
        ),
        backgroundColor: PColors.background(context),
        centerTitle: true,
        actions: [
          CupertinoButton(
            onPressed: () {
              // delete spending
            },
            child: Icon(
              HugeIcons.strokeRoundedDelete02,
              color: PColors.primaryText(context),
            ),
          ),
          Visibility(
            visible: FirebaseAuth.instance.currentUser!.uid ==
                widget.spendingModel.createdBy,
            child: CupertinoButton(
              onPressed: () async {
                // edit spending
                await editSpending();
              },
              child: Icon(
                HugeIcons.strokeRoundedEdit02,
                color: PColors.primaryText(context),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: widget.spendingModel.spendingType == SpendingType.shopping
            ? _shoppingUI()
            : widget.spendingModel.spendingType == SpendingType.transfer
                ? _transferUI()
                : widget.spendingModel.spendingType == SpendingType.split
                    ? _splitUI()
                    : Container(),
      ),
    );
  }

  Widget _shoppingUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _billImage(),
        SizedBox(
          height: PSize.arh(context, 18),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            "Spending Details",
            style: TextStyle(
              color: PColors.primaryText(context),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: PSize.arh(context, 18),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                widget.spendingModel.shoppingModel!.amount.toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Category',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                widget.spendingModel.shoppingModel!.category
                        .toString()
                        .trim()
                        .isEmpty
                    ? '-'
                    : widget.spendingModel.shoppingModel!.category.toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Date',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                PHelper.formatDateTime(widget.spendingModel.createdAt),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Message',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                widget.spendingModel.shoppingModel!.message
                        .toString()
                        .trim()
                        .isEmpty
                    ? '-'
                    : widget.spendingModel.shoppingModel!.message.toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Location',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                widget.spendingModel.shoppingModel!.location
                        .toString()
                        .trim()
                        .isEmpty
                    ? '-'
                    : widget.spendingModel.shoppingModel!.location.toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
      ],
    );
  }

  Widget _transferUI() {
    return Column(
      children: [
        _billImage(),
        SizedBox(
          height: PSize.arh(context, 18),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            "Spending Details",
            style: TextStyle(
              color: PColors.primaryText(context),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: PSize.arh(context, 18),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                widget.spendingModel.transferSpendingModel!.amount.toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Category',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                '-',
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Date',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                PHelper.formatDateTime(widget.spendingModel.createdAt),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Message',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                widget.spendingModel.transferSpendingModel!.message
                        .toString()
                        .trim()
                        .isEmpty
                    ? '-'
                    : widget.spendingModel.transferSpendingModel!.message
                        .toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Location',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                widget.spendingModel.transferSpendingModel!.location
                        .toString()
                        .trim()
                        .isEmpty
                    ? '-'
                    : widget.spendingModel.transferSpendingModel!.location
                        .toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
      ],
    );
  }

  Widget _splitUI() {
    log(name: "fromfirebase", "fromFirebase: ${fromFirebase != null}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _billImage(),
        SizedBox(
          height: PSize.arh(context, 18),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            "Spending Details",
            style: TextStyle(
              color: PColors.primaryText(context),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: PSize.arh(context, 18),
        ),
        ...List.generate(
          fromFirebase?.splitSpendingModel?.userSplit.length ??
              widget.spendingModel.splitSpendingModel!.userSplit.length,
          (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: PColors.containerSecondary(context),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RandomAvatar(
                    fromFirebase?.splitSpendingModel!.userSplit[index].user!
                            .username ??
                        widget.spendingModel.splitSpendingModel!
                            .userSplit[index].user!.username!,
                    height: PSize.arh(context, 40),
                  ),
                  SizedBox(width: PSize.arw(context, 8)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fromFirebase?.splitSpendingModel!.userSplit[index].user!
                                .username ??
                            widget.spendingModel.splitSpendingModel!
                                .userSplit[index].user!.username!,
                        style: TextStyle(
                          color: PColors.primaryText(context),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        fromFirebase
                                ?.splitSpendingModel!.userSplit[index].amount ??
                            widget.spendingModel.splitSpendingModel!
                                .userSplit[index].amount
                                .toString(),
                        style: TextStyle(
                          color: PColors.secondaryText(context),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    fromFirebase?.splitSpendingModel?.userSplit[index].isPaid ??
                            widget.spendingModel.splitSpendingModel!
                                .userSplit[index].isPaid
                        ? 'Paid'
                        : 'Not Paid',
                    style: TextStyle(
                      color: fromFirebase?.splitSpendingModel!.userSplit[index]
                                  .isPaid ??
                              widget.spendingModel.splitSpendingModel!
                                  .userSplit[index].isPaid
                          ? PColors.success
                          : PColors.error,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                fromFirebase?.splitSpendingModel!.totalAmount ??
                    widget.spendingModel.splitSpendingModel!.totalAmount
                        .toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Category',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                (fromFirebase == null
                        ? widget.spendingModel.splitSpendingModel!.category
                            .toString()
                            .trim()
                            .isEmpty
                        : fromFirebase!.splitSpendingModel!.category
                            .toString()
                            .trim()
                            .isEmpty)
                    ? '-'
                    : widget.spendingModel.splitSpendingModel!.category
                        .toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Date',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                PHelper.formatDateTime(widget.spendingModel.createdAt),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Message',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                (fromFirebase != null
                        ? fromFirebase!.splitSpendingModel!.message
                            .toString()
                            .trim()
                            .isEmpty
                        : widget.spendingModel.splitSpendingModel!.message
                            .toString()
                            .trim()
                            .isEmpty)
                    ? '-'
                    : widget.spendingModel.splitSpendingModel!.message
                        .toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Location',
                style: TextStyle(
                  color: PColors.secondaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                (fromFirebase != null
                        ? widget.spendingModel.splitSpendingModel!.location
                            .toString()
                            .trim()
                            .isEmpty
                        : widget.spendingModel.splitSpendingModel!.location
                            .toString()
                            .trim()
                            .isEmpty)
                    ? '-'
                    : widget.spendingModel.splitSpendingModel!.location
                        .toString(),
                style: TextStyle(
                  color: PColors.primaryText(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: PSize.arh(context, 8),
        ),
      ],
    );
  }

  SizedBox _billImage() {
    return SizedBox(
      width: PSize.displayWidth(context),
      height: PSize.displayHeight(context) * 0.45,
      child: Stack(
        children: [
          widget.spendingModel.billImage.isEmpty
              ? Container(
                  color: PColors.background(context),
                  width: PSize.displayWidth(context),
                  height: PSize.displayHeight(context) * 0.45,
                  child: Center(
                    child: Text(
                      'No Image',
                      style: TextStyle(
                        color: PColors.primaryText(context),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    // show image in full screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ZoomTapAnimation(
                          child: Image.network(
                            widget.spendingModel.billImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    widget.spendingModel.billImage,
                    fit: BoxFit.cover,
                    width: PSize.displayWidth(context),
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: PSize.displayWidth(context),
              height: 1,
              decoration:
                  BoxDecoration(color: PColors.background(context), boxShadow: [
                BoxShadow(
                  color: PColors.background(context),
                  spreadRadius: 60,
                  blurRadius: 50,
                  offset: Offset(0, 0),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class EditSpendingSheet extends StatefulWidget {
  final SpendingModel spendingModel;
  final Function(SpendingModel)? onEdit;
  final Function(SpendingModel)? onCancel;

  const EditSpendingSheet({
    super.key,
    required this.spendingModel,
    this.onEdit,
    this.onCancel,
  });

  @override
  State<EditSpendingSheet> createState() => _EditSpendingSheetState();
}

class _EditSpendingSheetState extends State<EditSpendingSheet> {
  late SpendingModel spendingModel;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spendingModel = widget.spendingModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: PSize.displayWidth(context),
      height: PSize.displayHeight(context) * 0.8,
      decoration: BoxDecoration(
        color: PColors.background(context),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: PSize.arh(context, 18),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Spends Edit",
                  style: TextStyle(
                    color: PColors.primaryText(context),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PaysaPrimaryButton(
                  color: PColors.error,
                  text: "Cancel",
                  onTap: () async {
                    await FirestoreAPIs.getSpendingById(
                      spendingModel.id,
                    ).then((value) {
                      spendingModel = value;
                    });
                    widget.onCancel!(spendingModel);
                    Navigator.pop(context);
                  },
                  textColor: Colors.white,
                  width: PSize.arw(context, 100),
                  height: PSize.arh(context, 36),
                ),
              ],
            ),
          ),
          SizedBox(
            height: PSize.arh(context, 18),
          ),
          // Add your edit spending form here
          Expanded(
            child: ListView.builder(
              itemCount: spendingModel.splitSpendingModel!.userSplit.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: PColors.containerSecondary(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RandomAvatar(
                        spendingModel.splitSpendingModel!.userSplit[index].user!
                            .username!,
                        height: PSize.arh(context, 40),
                      ),
                      SizedBox(width: PSize.arw(context, 8)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            spendingModel.splitSpendingModel!.userSplit[index]
                                .user!.username!,
                            style: TextStyle(
                              color: PColors.primaryText(context),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            spendingModel
                                .splitSpendingModel!.userSplit[index].amount
                                .toString(),
                            style: TextStyle(
                              color: PColors.secondaryText(context),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      PullDownButton(
                        itemBuilder: (context) {
                          return [
                            PullDownMenuItem(
                              title: "Paid",
                              iconWidget: spendingModel.splitSpendingModel!
                                      .userSplit[index].isPaid
                                  ? Icon(
                                      HugeIcons.strokeRoundedCheckmarkBadge03,
                                      color: PColors.success,
                                    )
                                  : null,
                              onTap: () {
                                // update paid status
                                spendingModel.splitSpendingModel!
                                    .userSplit[index].isPaid = true;
                                setState(() {});
                              },
                            ),
                            PullDownMenuItem(
                              title: "Not Paid",
                              iconWidget: spendingModel.splitSpendingModel!
                                      .userSplit[index].isPaid
                                  ? null
                                  : Icon(
                                      HugeIcons.strokeRoundedCheckmarkBadge03,
                                      color: PColors.success,
                                    ),
                              onTap: () {
                                // update not paid status
                                spendingModel.splitSpendingModel!
                                    .userSplit[index].isPaid = false;
                                setState(() {});
                              },
                            ),
                          ];
                        },
                        buttonBuilder: (context, showMenu) {
                          return ZoomTapAnimation(
                            onTap: showMenu,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: PColors.background(context),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    spendingModel.splitSpendingModel!
                                            .userSplit[index].isPaid
                                        ? 'Paid'
                                        : 'Not Paid',
                                    style: TextStyle(
                                      color: spendingModel.splitSpendingModel!
                                              .userSplit[index].isPaid
                                          ? PColors.success
                                          : PColors.error,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Iconsax.arrow_down_1,
                                    color: spendingModel.splitSpendingModel!
                                            .userSplit[index].isPaid
                                        ? PColors.success
                                        : PColors.error,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: PaysaPrimaryButton(
              text: "Save Changes",
              onTap: () async {
                if (isLoading) return;
                setState(() {
                  isLoading = true;
                });

                await FirestoreAPIs.upadteSpending(
                    spendingModel.id, spendingModel.toJson());

                await FirestoreAPIs.getSpendingById(
                  spendingModel.id,
                ).then((value) {
                  spendingModel = value;
                });
                widget.onEdit!(spendingModel);
                setState(() {
                  isLoading = false;
                });
                Navigator.pop(context);
              },
              color: PColors.primary(context),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
