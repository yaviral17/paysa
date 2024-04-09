import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/DailySpendingsController.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/utils/appbar/appbar.dart';
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

  double maxY = 200.0;

  addDailySpendingBottomSheet(BuildContext context) {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      AddDailySpendingSheetDesign(
        id: Uuid().v1(),
        timestamp: DateTime.now(),
        category: DailySpendingModel.DailySpendingCategories[0],
        titleController: titleController,
        descriptionController: descriptionController,
        amountController: amountController,
      ),
    );
  }

  getMaxValue() {
    Map<String, double> data = {};
    for (DailySpendingModel dailySpending
        in dailySpendingController.dailySpendings) {
      String day =
          THelperFunctions.formateDateTime(dailySpending.timestamp, "d M yyyy");

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

    maxY = data.values.reduce(math.max);
    log('Max Value: $maxY');
  }

  // getMinValue() {}
  List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMaxValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Daily Spendings'),
        showBackArrow: false,
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => addDailySpendingBottomSheet(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Add your widgets here
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                height: MediaQuery.of(context).size.height * 0.32,
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
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 10.0,
                          ),
                        ),
                        y: ChartAxisSettingsAxis(
                          frequency: maxY / 6,
                          max: maxY,
                          min: 0,
                          textStyle: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      labelX: (value) => weekDays[DateTime.now()
                              .subtract(
                                Duration(days: value.toInt() - 6),
                              )
                              .weekday -
                          1],
                      labelY: (value) => value.toInt().toString(),
                    ),
                    ChartBarLayer(
                      items: List.generate(
                        7,
                        (index) => ChartBarDataItem(
                          color: TColors.accent,
                          value: dailySpendingController
                                  .data[THelperFunctions.formateDateTime(
                                DateTime.now().subtract(
                                  Duration(days: 6 - index),
                                ),
                                "d M yyyy",
                              )] ??
                              0.0,
                          x: (index).toDouble(),
                        ),
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

              StreamBuilder(
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

                  List<Map<String, dynamic>> dailySpendings =
                      snapshot.requireData;

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
                  getMaxValue();

                  return GroupedListView(
                    shrinkWrap: true,
                    elements: <DailySpendingModel>[
                      ...dailySpendingController.dailySpendings
                    ],
                    groupBy: (element) => THelperFunctions.getDayDifference(
                      element.timestamp,
                    ),
                    sort: false,
                    groupSeparatorBuilder: (String groupByValue) => Center(
                      child: Ink(
                        decoration: BoxDecoration(
                          color: TColors.textWhite.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(45),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        child: Text(
                          groupByValue,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: TColors.textWhite.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
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
                                descriptionController.text =
                                    element.description;
                                amountController.text =
                                    element.amount.toString();
                                Get.bottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  AddDailySpendingSheetDesign(
                                    id: element.id,
                                    timestamp: element.timestamp,
                                    category: element.category,
                                    titleController: titleController,
                                    descriptionController:
                                        descriptionController,
                                    amountController: amountController,
                                    fromEdit: true,
                                  ),
                                );
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
                          return ListTile(
                            onTap: () {
                              // show menu
                              showMenu();
                            },
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
                                    color: TColors.primary,
                                  ),
                            ),
                            subtitle: Text(
                              element.description,
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
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
                                        color: TColors.primary,
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
                          );
                        },
                      );
                    },
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
            ],
          ),
        ),
      ),
    );
  }
}

class AddDailySpendingSheetDesign extends StatefulWidget {
  AddDailySpendingSheetDesign({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.amountController,
    required this.id,
    required this.timestamp,
    this.fromEdit = false,
    required this.category,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController amountController;
  final bool fromEdit;
  final DateTime timestamp;
  final String id;
  String category;

  @override
  State<AddDailySpendingSheetDesign> createState() =>
      _AddDailySpendingSheetDesignState();
}

class _AddDailySpendingSheetDesignState
    extends State<AddDailySpendingSheetDesign> {
  bool showMore = false;

  final DailySpendingController dailySpendingController =
      Get.put(DailySpendingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 16.0,
            ),
            Center(
              child: Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Add Daily Spending',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: TColors.primary,
                  ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Center(
              child: CircleAvatar(
                radius: 54.0,
                child: Image.asset(
                  "assets/expanses_category_icons/ic_${widget.category}.png",
                ),
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            TextField(
              controller: widget.titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextField(
              controller: widget.descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextField(
              controller: widget.amountController,
              decoration: InputDecoration(
                hintText: 'Amount',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Center(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    showMore
                        ? DailySpendingModel.DailySpendingCategories.length
                        : DailySpendingModel.DailySpendingCategories.length ~/
                            2,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.category = DailySpendingModel
                                .DailySpendingCategories[index];
                          });
                        },
                        child: CircleAvatar(
                          child: Image.asset(
                            "assets/expanses_category_icons/ic_${DailySpendingModel.DailySpendingCategories[index]}.png",
                          ),
                        ),
                      );
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          showMore = !showMore;
                        });
                      },
                      child: Text(showMore ? 'Show Less' : 'Show More')),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.titleController.text.isEmpty) {
                  THelperFunctions.showAlert(
                    'Title cannot be empty',
                    'Please enter a title for the daily spending',
                  );
                  return;
                }

                if (widget.descriptionController.text.isEmpty) {
                  THelperFunctions.showAlert(
                    'Description cannot be empty',
                    'Please enter a description for the daily spending',
                  );
                  return;
                }

                if (widget.amountController.text.isEmpty ||
                    double.parse(widget.amountController.text) == 0.0) {
                  THelperFunctions.showAlert(
                    'Amount cannot be empty',
                    'Please enter an amount for the daily spending',
                  );
                  return;
                }
                if (widget.fromEdit) {
                  dailySpendingController.updateDailySpending(
                    DailySpendingModel(
                      id: widget.id,
                      timestamp: widget.timestamp,
                      amount: double.parse(widget.amountController.text),
                      category: widget.category,
                      title: widget.titleController.text,
                      description: widget.descriptionController.text,
                    ),
                  );
                  Get.back();
                  return;
                }
                dailySpendingController.addDailySpending(
                  id: widget.id,
                  timestamp: widget.timestamp,
                  title: widget.titleController.text,
                  description: widget.descriptionController.text,
                  amount: double.parse(widget.amountController.text),
                  category: widget.category,
                );
                Get.back();
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
