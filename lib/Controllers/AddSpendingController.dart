import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/SplitModel.dart';
import 'package:uuid/uuid.dart';

class AddSpendingController extends GetxController {
  RxBool isSplit = false.obs;
  RxString category = DailySpendingModel.DailySpendingCategories[0].obs;
  TabController? tabController;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? timestamp = DateTime.now();

  void addDailySpending({
    required String id,
    required String title,
    required String description,
    required double amount,
    required String category,
    required DateTime timestamp,
    required bool isSplit,
  }) async {
    DailySpendingModel dailySpending = DailySpendingModel(
      id: id,
      timestamp: timestamp,
      amount: amount,
      category: category,
      title: title,
      description: description,
      isSplit: isSplit,
    );

    await FireStoreRef.addDailySpending(dailySpending);
  }
}
