import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:uuid/uuid.dart';

class DailySpendingScreen extends StatefulWidget {
  DailySpendingScreen({super.key});

  @override
  State<DailySpendingScreen> createState() => _DailySpendingScreenState();
}

class _DailySpendingScreenState extends State<DailySpendingScreen> {
  final DailySpendingController dailySpendingController =
      DailySpendingController();

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

  @override
  Widget build(BuildContext context) {
    log(roundOfValueFromFirstDigit(1234.0).toString());
    // THelperFunctions.hideBottomBlackStrip();
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Daily Spendings'),
        showBackArrow: false,
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => addDailySpendingBottomSheet(context),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FireStoreRef.getMyDailySpendings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('An error occurred'),
              );
            }

            List<Map<String, dynamic>> dailySpendings = snapshot.requireData;

            List<DailySpendingModel> dailySpendingsModelList =
                DailySpendingModel.fromJsonList(dailySpendings);
            dailySpendingController.dailySpendings.value =
                dailySpendingsModelList;

            dailySpendingController.dailySpendings
                .sort((a, b) => b.timestamp.compareTo(a.timestamp));

            if (dailySpendingsModelList.isEmpty) {
              return const Center(
                child: Text('No Daily Spendings'),
              );
            }

            Map<String, double> data = {};
            for (DailySpendingModel dailySpending
                in dailySpendingController.dailySpendings) {
              String day = THelperFunctions.formateDateTime(
                  dailySpending.timestamp, "d M yyyy");

              if (data[day] == null) {
                data[day] = dailySpending.amount;
              } else {
                data[day] = data[day]! + dailySpending.amount;
              }
            }

            for (var key in data.keys) {
              log('Key: $key, Value: ${data[key]}');
            }
            dailySpendingController.data.value = data;

            maxY.value =
                roundOfValueFromFirstDigit(data.values.reduce(math.max));
            log("hi");
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: MediaQuery.of(context).size.height * 0.4,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Chart(
                    duration: const Duration(milliseconds: 500),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    layers: [
                      ChartAxisLayer(
                        settings: ChartAxisSettings(
                          x: ChartAxisSettingsAxis(
                            frequency: 1,
                            max: 6.0,
                            min: 0.0,
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          y: ChartAxisSettingsAxis(
                            frequency: maxY.value / 5,
                            max: maxY.value,
                            min: 0,
                            textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        labelX: (value) => THelperFunctions.formateDateTime(
                          DateTime.now().subtract(
                            Duration(days: 6 - value.toInt()),
                          ),
                          'd MMM',
                        ),
                        labelY: (value) => value.toInt().toString(),
                      ),
                      ChartBarLayer(
                        items: List.generate(
                          7,
                          (index) {
                            return ChartBarDataItem(
                              color: Theme.of(context).colorScheme.tertiary,
                              value: dailySpendingController
                                      .data[THelperFunctions.formateDateTime(
                                    DateTime.now().subtract(
                                      Duration(days: 6 - index),
                                    ),
                                    'd M yyyy',
                                  )] ??
                                  0.0,
                              x: (index).toDouble(),
                            );
                          },
                        ),
                        settings: const ChartBarSettings(
                          thickness: 18.0,
                          radius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GroupedListView(
                  shrinkWrap: true,
                  elements: <DailySpendingModel>[
                    ...dailySpendingController.dailySpendings
                  ],
                  groupBy: (element) => THelperFunctions.getDayDifference(
                    element.timestamp,
                  ),
                  sort: false,
                  groupSeparatorBuilder: (String groupByValue) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: TColors.darkGrey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              groupByValue,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              // total spending of the day
                              '₹${dailySpendingController.dailySpendings.where((element) => THelperFunctions.getDayDifference(
                                    element.timestamp,
                                  ) == groupByValue).map((e) => e.amount).reduce((value, element) => value + element)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemBuilder: (context, element) {
                    return PullDownButton(
                      itemBuilder: (context) => [
                        PullDownMenuActionsRow.small(items: [
                          PullDownMenuItem(
                            icon: Icons.edit,
                            title: 'Edit',
                            onTap: () {
                              titleController.text = element.title;
                              descriptionController.text = element.description;
                              amountController.text = element.amount.toString();
                              Get.toNamed('add-spending',
                                  arguments:
                                      AddDailySpendingScreen(fromEdit: true));
                            },
                          ),
                          PullDownMenuItem(
                            icon: (Icons.delete),
                            iconColor: Colors.red,
                            isDestructive: true,
                            title: 'Delete',
                            onTap: () async {
                              await dailySpendingController
                                  .removeDailySpending(element);
                            },
                          ),
                        ]),
                      ],
                      buttonBuilder: (context, showMenu) {
                        if (element.splits.isNotEmpty) {
                          return InkWell(
                            onLongPress: () {
                              // show menu
                              showMenu();
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: TColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.only(bottom: 8.0),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 4),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    style: ListTileStyle.list,
                                    leading: CircleAvatar(
                                      child: Image.asset(
                                        element.categoryIcon,
                                      ),
                                    ),
                                    title: Text(
                                      element.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            color: TColors.light,
                                          ),
                                    ),
                                    subtitle: Text(
                                      element.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                          ),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          "₹${element.amount}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                color: TColors.accent,
                                              ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          THelperFunctions.formateDateTime(
                                              element.timestamp,
                                              'dd MMM  h:mm a'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...List.generate(
                                      element.splits.length,
                                      (index) => FutureBuilder(
                                            future: UserModel.getUserbodelById(
                                                element.splits[index].uid),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }

                                              if (snapshot.hasError) {
                                                return const Center(
                                                  child:
                                                      Text('An error occurred'),
                                                );
                                              }

                                              UserModel user =
                                                  snapshot.requireData;
                                              return Container(
                                                width: TSizes.displayWidth(
                                                        context) *
                                                    0.6,
                                                decoration: BoxDecoration(
                                                  color:
                                                      element.splits[index].paid
                                                          ? TColors.primary
                                                              .withOpacity(0.5)
                                                          : TColors.accent
                                                              .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 32.0,
                                                        vertical: 4),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CircleAvatar(
                                                      radius:
                                                          TSizes.displayWidth(
                                                                  context) *
                                                              0.03,
                                                      backgroundImage:
                                                          Image.network(
                                                        user.profile,
                                                      ).image,
                                                    ),
                                                    const SizedBox(width: 8.0),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          user.name,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge!
                                                                  .copyWith(
                                                                    color: TColors
                                                                        .light,
                                                                  ),
                                                        ),
                                                        Text(
                                                          user.email,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.6),
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      element.splits[index].paid
                                                          ? 'Paid'
                                                          : "₹${element.splits[index].amount}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .copyWith(
                                                            color:
                                                                TColors.accent,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          )),
                                ],
                              ),
                            ),
                          );
                        }

                        return InkWell(
                          onLongPress: () {
                            // show menu
                            showMenu();
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: TColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.only(bottom: 8.0),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 4),
                            child: ListTile(
                              style: ListTileStyle.list,
                              leading: CircleAvatar(
                                child: Image.asset(
                                  element.categoryIcon,
                                ),
                              ),
                              title: Text(
                                element.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: TColors.light,
                                    ),
                              ),
                              subtitle: Text(
                                element.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    "₹${element.amount}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: TColors.accent,
                                        ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    THelperFunctions.formateDateTime(
                                        element.timestamp, 'dd MMM  h:mm a'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );

            // return Column(
            //   children: [
            //     ...List.generate(
            //       dailySpendingController.dailySpendings.length,
            //       (index) {
            //         log(dailySpendingController
            //             .dailySpendings[index].categoryIcon);
            //         return PullDownButton(
            //           itemBuilder: (context) => [
            //             PullDownMenuActionsRow.small(items: [
            //               PullDownMenuItem(
            //                 icon: Icons.edit,
            //                 title: 'Edit',
            //                 onTap: () {
            //                   titleController.text =
            //                       dailySpendingController
            //                           .dailySpendings[index].title;
            //                   descriptionController.text =
            //                       dailySpendingController
            //                           .dailySpendings[index].description;
            //                   amountController.text =
            //                       dailySpendingController
            //                           .dailySpendings[index].amount
            //                           .toString();
            //                   Get.bottomSheet(
            //                     backgroundColor: Colors.transparent,
            //                     isScrollControlled: true,
            //                     AddDailySpendingSheetDesign(
            //                       id: dailySpendingController
            //                           .dailySpendings[index].id,
            //                       timestamp: dailySpendingController
            //                           .dailySpendings[index].timestamp,
            //                       category: dailySpendingController
            //                           .dailySpendings[index].category,
            //                       titleController: titleController,
            //                       descriptionController:
            //                           descriptionController,
            //                       amountController: amountController,
            //                       fromEdit: true,
            //                     ),
            //                   );
            //                 },
            //               ),
            //               PullDownMenuItem(
            //                 icon: (Icons.delete),
            //                 iconColor: Colors.red,
            //                 isDestructive: true,
            //                 title: 'Delete',
            //                 onTap: () async {
            //                   await dailySpendingController
            //                       .removeDailySpending(
            //                           dailySpendingController
            //                               .dailySpendings[index]);
            //                 },
            //               ),
            //             ]),
            //           ],
            //           buttonBuilder: (context, showMenu) {
            //             return ListTile(
            //               onLongPress: () {
            //                 // show menu
            //                 showMenu();
            //               },
            //               style: ListTileStyle.list,
            //               leading: CircleAvatar(
            //                 child: Image.asset(
            //                   dailySpendingController
            //                       .dailySpendings[index].categoryIcon,
            //                 ),
            //               ),
            //               title: Text(
            //                 dailySpendingController
            //                     .dailySpendings[index].title,
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .labelLarge!
            //                     .copyWith(
            //                       color: TColors.primary,
            //                     ),
            //               ),
            //               subtitle: Text(
            //                 dailySpendingController
            //                     .dailySpendings[index].description,
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .caption!
            //                     .copyWith(
            //                       color: Colors.white.withOpacity(0.6),
            //                     ),
            //               ),
            //               trailing: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.end,
            //                 children: [
            //                   SizedBox(
            //                     height: 8.0,
            //                   ),
            //                   Text(
            //                     "₹${dailySpendingController.dailySpendings[index].amount}",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .titleSmall!
            //                         .copyWith(
            //                           color: TColors.primary,
            //                         ),
            //                   ),
            //                   SizedBox(height: 4.0),
            //                   Text(
            //                     THelperFunctions.formateDateTime(
            //                         dailySpendingController
            //                             .dailySpendings[index].timestamp,
            //                         'dd MMM  h:mm a'),
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .caption!
            //                         .copyWith(
            //                           color:
            //                               Colors.white.withOpacity(0.6),
            //                         ),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           },
            //         );
            //       },
            //     ),
            //   ],
            // );
          },
        ),
      ),
    );
  }
}
