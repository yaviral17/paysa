import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Controllers/dashboard_controller.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/chat/chat_screen.dart';
import 'package:paysa/Views/Dashboard/home/home_view.dart';

class SpendingListView extends StatefulWidget {
  final SpendingType spendingType;

  const SpendingListView({super.key, required this.spendingType});

  @override
  State<SpendingListView> createState() => _SpendingListViewState();
}

class _SpendingListViewState extends State<SpendingListView> {
  FocusNode searchNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  final DashboardController dashboardController = Get.find();
  final AuthenticationController authController = Get.find();
  late List<SpendingModel> spendingList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchList();
    searchNode.addListener(() {
      setState(() {});
    });
  }

  void fetchList() {
    log("Fetching list");
    log(widget.spendingType.value);
    if (widget.spendingType.value == SpendingType.shopping.value) {
      log("Shopping");
      spendingList = dashboardController.shoppingSpendings.value;
    } else if (widget.spendingType.value == SpendingType.transfer.value) {
      spendingList = dashboardController.transferSpendings.value;
    } else if (widget.spendingType.value == SpendingType.split.value) {
      spendingList = dashboardController.splitSpendings.value;
    } else {
      log("No data found");
    }
    log(spendingList.length.toString(), name: "Length");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: PColors.background(context),
        title: Text('${widget.spendingType.value} List'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedFilterHorizontal,
              color: PColors.primaryText(context),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchTextField(
              searchNode: searchNode,
              controller: searchController,
            ),
            SizedBox(
              height: PSize.arh(context, 10),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: spendingList.length,
                itemBuilder: (context, index) {
                  if (widget.spendingType.value ==
                      SpendingType.shopping.value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: ShoppingTileWidget(
                        spending: spendingList[index],
                        label: spendingList[index].shoppingModel!.message,
                        time: PHelper.timeAgo(spendingList[index].createdAt),
                        amount: double.parse(
                          spendingList[index].shoppingModel!.amount,
                        ),
                      ),
                    );
                  } else if (widget.spendingType.value ==
                      SpendingType.transfer.value) {
                    bool isIncome = spendingList[index].createdBy !=
                        authController.user.value?.uid;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: TransferTileWidget(
                        spending: spendingList[index],
                        otherPerson: isIncome
                            ? spendingList[index]
                                .transferSpendingModel!
                                .transferdFromUser!
                            : spendingList[index]
                                .transferSpendingModel!
                                .transferdToUser!,
                        time: PHelper.timeAgo(spendingList[index].createdAt),
                        amount: double.parse(
                          spendingList[index].transferSpendingModel!.amount,
                        ),
                        isIncome: isIncome,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SplitTileWidget(spending: spendingList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
