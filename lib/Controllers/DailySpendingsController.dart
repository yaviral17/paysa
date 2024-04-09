import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:uuid/uuid.dart';

class DailySpendingController extends GetxController {
  RxList<DailySpendingModel> dailySpendings = <DailySpendingModel>[
    DailySpendingModel(
      id: Uuid().v1(),
      timestamp: DateTime.now(),
      amount: 0.0,
      category: 'Food',
      title: 'Breakfast',
      description: 'Bought breakfast from the local bakery',
    ),
    DailySpendingModel(
      id: Uuid().v1(),
      timestamp: DateTime.now(),
      amount: 0.0,
      category: 'car',
      title: 'Transportation',
      description: 'Took the bus to work today and back home in the evening ',
    ),
    DailySpendingModel(
      id: Uuid().v1(),
      timestamp: DateTime.now(),
      amount: 0.0,
      category: 'entertainment',
      title: 'Movie',
      description: 'Watched a movie with friends',
    ),
  ].obs;

  void addDailySpending({
    required String title,
    required String description,
    required double amount,
    required String category,
  }) async {
    DailySpendingModel dailySpending = DailySpendingModel(
      id: Uuid().v1(),
      timestamp: DateTime.now(),
      amount: amount,
      category: category,
      title: title,
      description: description,
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
}
