import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/DailySpendingsController.dart';
import 'package:paysa/Controllers/UserData.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/SplitModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/Views/AddSpending/AddSpending.dart';
import 'package:paysa/utils/appbar/appbar.dart';
import 'package:paysa/utils/constants/cherryToast.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class DailySpendingScreen extends StatefulWidget {
  DailySpendingScreen({super.key});

  @override
  State<DailySpendingScreen> createState() => _DailySpendingScreenState();
}

class _DailySpendingScreenState extends State<DailySpendingScreen> {
  final DailySpendingController dailySpendingController =
      Get.put(DailySpendingController());

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  RxDouble maxY = 200.0.obs;

  addDailySpendingBottomSheet(BuildContext context) {
    // Get.bottomSheet(
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   AddDailySpendingSheetDesign(
    //     id: Uuid().v1(),
    //     timestamp: DateTime.now(),
    //     category: DailySpendingModel.DailySpendingCategories[0],
    //     titleController: titleController,
    //     descriptionController: descriptionController,
    //     amountController: amountController,
    //   ),
    // );

    Get.toNamed('/add-spending',
        arguments: AddDailySpendingScreen(fromEdit: false));
  }

  double roundOfValueFromFirstDigit(double value) {
    log(value.toString());
    double firstDigit = double.parse(value.toString()[0]) + 1;
    double numberOfDigits = value.toInt().toString().length.toDouble();
    double generateNumber = (firstDigit * math.pow(10, numberOfDigits - 1));
    log(generateNumber.toString());
    return generateNumber;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setUpList(List<Map<String, dynamic>> dailySpendings,
      List<Map<String, dynamic>> data) {
    // dailySpendingController.dailySplits.clear();
    for (var item in dailySpendings) {
      if (!(item['isSplit'] ?? false)) {
        DailySpendingModel dailySpending = DailySpendingModel.fromJson(item);
        dailySpendingController.dailySpendings.add(dailySpending);
      }
    }

    for (var item in data) {
      if (item['isSplit'] ?? false) {
        Map<String, dynamic>? data;
        FireStoreRef.getSplitDataById(item['id']).listen((event) {
          if (event != null) {
            for (DailySpendingModel model
                in dailySpendingController.dailySplits) {
              if (model.id == item['id']) {
                return;
              }
            }
            dailySpendingController.dailySplits
                .add(DailySpendingModel.fromJson(event));
          }
        });
      }
    }

    dailySpendingController.dailySpendings
        .addAll(dailySpendingController.dailySplits);

    dailySpendingController.dailySpendings
        .sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  @override
  Widget build(BuildContext context) {
    log(roundOfValueFromFirstDigit(1234.0).toString());
    // THelperFunctions.hideBottomBlackStrip();
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Daily Spendings'),
        showBackArrow: false,
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => addDailySpendingBottomSheet(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FireStoreRef.getMyDailySpendings(),
          builder: (context, snapshot) {
            dailySpendingController.dailySpendings.clear();
            // dailySpendingController.dailySplits.clear();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching data'),
              );
            }

            List<Map<String, dynamic>> dailySpendings = snapshot.requireData;
            if (dailySpendings.isEmpty) {
              return const Center(
                child: Text('No Daily Spendings'),
              );
            }

            setUpList(dailySpendings, snapshot.requireData);

            return spendingList();
          },
        ),
      ),
    );
  }

  Widget spendingList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          GroupedListView(
            shrinkWrap: true,
            elements: dailySpendingController.dailySpendings,
            groupBy: (element) =>
                THelperFunctions.getDayDifference(element.timestamp),
            itemBuilder: (context, element) {
              return spendingInfoTile(element);
            },
            sort: false,
            groupSeparatorBuilder: (element) {
              return Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 12,
                  right: 12,
                ),
                margin: const EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  left: 12,
                  right: 12,
                ),
                decoration: BoxDecoration(
                  color: TColors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  element,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            },
          ),
          // ...List.generate(
          //   dailySpendingController.dailySpendings.length,
          //   (index) =>
          //       spendingInfoTile(dailySpendingController.dailySpendings[index]),
          // ),
        ],
      ),
    );
  }

  spendingInfoTile(DailySpendingModel dailySpending) {
    return Container(
      width: TSizes.displayWidth(context),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: TColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: TSizes.displayWidth(context) * 0.063,
                backgroundImage: AssetImage(
                  'assets/expanses_category_icons/ic_${dailySpending.category}.png',
                ),
              ),
              SizedBox(width: TSizes.displayWidth(context) * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dailySpending.title.capitalizeFirst ?? "No Title",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    dailySpending.description.capitalizeFirst ??
                        "No Description",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹ " + dailySpending.amount.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    THelperFunctions.formateDateTime(
                        dailySpending.timestamp, 'h:mm a'),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
            ],
          ),

          // if (dailySpending.isSplit)

          if (dailySpending.isSplit)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ...List.generate(dailySpending.splits!.length, (index) {
                  return FutureBuilder(
                    future: FireStoreRef.getuserByUid(
                        dailySpending.splits![index].uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          child: Shimmer.fromColors(
                            baseColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2),
                            highlightColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              width: TSizes.displayWidth(context) * 0.4,
                              height: TSizes.displayWidth(context) * 0.09,
                              decoration: BoxDecoration(
                                color: TColors.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error fetching data'),
                        );
                      }

                      UserModel user = UserModel.fromJson(snapshot.requireData);

                      return usertagTile(user, dailySpending, index);
                    },
                  );
                }),
              ],
            ),
        ],
      ),
    );
  }

  Padding usertagTile(
      UserModel user, DailySpendingModel dailySpending, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Ink(
        height: TSizes.displayWidth(context) * 0.09,
        padding: const EdgeInsets.all(4),
        width: TSizes.displayWidth(context) * 0.4,
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user.profile.isNotEmpty)
              CircleAvatar(
                radius: TSizes.displayWidth(context) * 0.036,
                backgroundImage: NetworkImage(user.profile),
              ),
            SizedBox(width: TSizes.displayWidth(context) * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name ?? "No Name",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                FittedBox(
                  child: Text(
                    dailySpending.splits![index].amount.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
