import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/SplitModel.dart';
import 'package:uuid/uuid.dart';

class DailySpendingController extends GetxController {
  RxList<DailySpendingModel> dailySpendings = <DailySpendingModel>[].obs;

  RxMap<String, double> data = RxMap<String, double>();

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
