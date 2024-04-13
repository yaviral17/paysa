import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/SplitModel.dart';
import 'package:uuid/uuid.dart';

class DailySpendingController extends GetxController {
  RxList<DailySpendingModel> dailySpendings = <DailySpendingModel>[].obs;

  RxMap<String, double> data = RxMap<String, double>();

  void addDailySpending({
    required String id,
    required String title,
    required String description,
    required double amount,
    required String category,
    required DateTime timestamp,
    required List<Split> splits,
    required bool isSplit,
    required String paidBy,
  }) async {
    DailySpendingModel dailySpending = DailySpendingModel(
      id: id,
      timestamp: timestamp,
      amount: amount,
      category: category,
      title: title,
      description: description,
      splits: splits,
      isSplit: isSplit,
      paidBy: paidBy,
    );

    await FireStoreRef.addDailySpending(dailySpending);
  }

  Future<void> removeDailySpending(DailySpendingModel dailySpending) async {
    bool isConfirmed =
        await FireStoreRef.removeDailySpendingById(dailySpending.id);
    if (!(isConfirmed)) {
      Get.snackbar(
        'Error',
        'Failed to remove daily spending',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }

  Future<void> updateDailySpending(DailySpendingModel dailySpending) async {
    bool isConfirmed = await FireStoreRef.updateDailySpending(dailySpending);
    if (!(isConfirmed)) {
      Get.snackbar(
        'Error',
        'Failed to update daily spending',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
  }
}
