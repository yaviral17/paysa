import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/DailySpendingsController.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/utils/appbar/appbar.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';
import 'package:pull_down_button/pull_down_button.dart';

class DailySpendingScreen extends StatelessWidget {
  DailySpendingScreen({super.key});

  final DailySpendingController dailySpendingController =
      DailySpendingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  addDailySpendingBottomSheet(BuildContext context) {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      AddDailySpendingSheetDesign(
        titleController: titleController,
        descriptionController: descriptionController,
        amountController: amountController,
      ),
    );
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
                        max: 5.0,
                        min: 0.0,
                        textStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 10.0,
                        ),
                      ),
                      y: ChartAxisSettingsAxis(
                        frequency: 100.0,
                        max: 400.0,
                        min: 0.0,
                        textStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    labelX: (value) => value.toInt().toString(),
                    labelY: (value) => value.toInt().toString(),
                  ),
                  ChartBarLayer(
                    items: List.generate(
                      6,
                      (index) => ChartBarDataItem(
                        color: TColors.accent,
                        value: 200,
                        x: (index).toDouble(),
                      ),
                    ),
                    settings: const ChartBarSettings(
                      thickness: 4.0,
                      radius: BorderRadius.all(Radius.circular(4.0)),
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

                dailySpendingController.dailySpendings.value
                    .sort((a, b) => b.timestamp.compareTo(a.timestamp));

                return Column(
                  children: [
                    ...List.generate(
                      dailySpendingController.dailySpendings.length,
                      (index) {
                        log(dailySpendingController
                            .dailySpendings[index].categoryIcon);
                        return PullDownButton(
                          itemBuilder: (context) => [
                            PullDownMenuItem(
                              icon: (Icons.delete),
                              title: 'Delete',
                              onTap: () async {
                                await dailySpendingController
                                    .removeDailySpending(dailySpendingController
                                        .dailySpendings[index]);
                              },
                            ),
                          ],
                          buttonBuilder: (context, showMenu) {
                            return ListTile(
                              onLongPress: () {
                                // show menu
                                showMenu();
                              },
                              style: ListTileStyle.list,
                              leading: CircleAvatar(
                                child: Image.asset(
                                  dailySpendingController
                                      .dailySpendings[index].categoryIcon,
                                ),
                              ),
                              title: Text(
                                dailySpendingController
                                    .dailySpendings[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: TColors.primary,
                                    ),
                              ),
                              subtitle: Text(
                                dailySpendingController
                                    .dailySpendings[index].description,
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
                                    "₹${dailySpendingController.dailySpendings[index].amount}",
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
                                        dailySpendingController
                                            .dailySpendings[index].timestamp,
                                        'dd MMM  h:mm a'),
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
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddDailySpendingSheetDesign extends StatefulWidget {
  const AddDailySpendingSheetDesign({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.amountController,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController amountController;

  @override
  State<AddDailySpendingSheetDesign> createState() =>
      _AddDailySpendingSheetDesignState();
}

class _AddDailySpendingSheetDesignState
    extends State<AddDailySpendingSheetDesign> {
  bool showMore = false;

  final DailySpendingController dailySpendingController =
      Get.put(DailySpendingController());

  String selectedIcon = DailySpendingModel.DailySpendingCategories[0];

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
                  "assets/expanses_category_icons/ic_$selectedIcon.png",
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
                            selectedIcon = DailySpendingModel
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

                dailySpendingController.addDailySpending(
                  title: widget.titleController.text,
                  description: widget.descriptionController.text,
                  amount: double.parse(widget.amountController.text),
                  category: selectedIcon,
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
