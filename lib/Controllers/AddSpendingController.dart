import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Models/DailySpendingModel.dart';

class AddSpendingController extends GetxController {
  RxBool isSplit = false.obs;
  RxString category = DailySpendingModel.DailySpendingCategories[0].obs;
  TabController? tabController;
}
