import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SpendingDeatilsView extends StatefulWidget {
  final SpendingModel spendingModel;
  const SpendingDeatilsView({super.key, required this.spendingModel});

  @override
  State<SpendingDeatilsView> createState() => _SpendingDeatilsViewState();
}

class _SpendingDeatilsViewState extends State<SpendingDeatilsView> {
  @override
  Widget build(BuildContext context) {
    log(widget.spendingModel.billImage, name: 'billImage');

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
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
                    : Image.network(
                        widget.spendingModel.billImage,
                        fit: BoxFit.cover,
                        width: PSize.displayWidth(context),
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: PSize.displayWidth(context),
                    height: 1,
                    decoration: BoxDecoration(
                        color: PColors.background(context),
                        boxShadow: [
                          BoxShadow(
                            color: PColors.background(context),
                            spreadRadius: 60,
                            blurRadius: 50,
                            offset: Offset(0, 0),
                          ),
                        ]),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: PSize.arw(context, 40),
                            height: PSize.arw(context, 40),
                            decoration: BoxDecoration(
                              color: PColors.primaryText(context),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: PColors.background(context)
                                      .withAlpha(100),
                                  spreadRadius: 1,
                                  blurRadius: 20,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: PColors.background(context),
                                size: PSize.arw(context, 20),
                              ),
                            ),
                          ),
                          ZoomTapAnimation(
                            onTap: () {
                              // cupertino dialog to confirm delete
                              showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text('Comfirm Delete 🗑'),
                                    content: Text(
                                        'Are you sure you want to delete this spending? This action cannot be undone. 🤔'),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: PColors.primaryText(context),
                                          ),
                                        ),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          FirestoreAPIs.deleteSpendings(
                                              [widget.spendingModel.id]);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: PColors.error,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: PSize.arw(context, 40),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                color: PColors.error,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    HugeIcons.strokeRoundedDelete02,
                                    color: PColors.primaryText(context),
                                    size: PSize.arw(context, 20),
                                  ),
                                  SizedBox(width: PSize.arw(context, 8)),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: PColors.primaryText(context),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      ),
    );
  }

  Widget _shoppingUI() {
    return Text('Shopping');
  }

  Widget _transferUI() {
    return Text('Transfer');
  }

  Widget _splitUI() {
    return Text('Split');
  }
}
