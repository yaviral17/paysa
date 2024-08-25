import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/SplitModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:uuid/uuid.dart';

class AddSpendingController extends GetxController {
  RxBool isSplit = false.obs;
  RxString category = DailySpendingModel.DailySpendingCategories[0].obs;
  TabController? tabController;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? timestamp = DateTime.now();
  Rx<UserModel> paidBy = Rx(UserModel.empty());
  // RxList<Split> splits = <Split>[].obs;
  RxList<UserModel> users = <UserModel>[].obs;

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

  Future<void> addSplit() async {
    DailySpendingModel model = DailySpendingModel(
      id: const Uuid().v1(),
      amount: double.parse(amountController.text),
      category: category.value,
      description: descriptionController.text,
      isSplit: true,
      timestamp: timestamp!,
      title: titleController.text,
      // splits: splits.toList(),
      paidy: paidBy.value.uid,
    );

    await FireStoreRef.addSplitData(model);
  }
}
