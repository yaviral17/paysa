import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Models/user_model.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Map<String, dynamic>> currencyData = Rx({});
  Rx<UserModel?> user = Rx(null);
  RxInt currentIndex = 0.obs;
  Rx<String> fcmToken = "".obs;

  Rx<List<SpendingModel>> spendings = Rx([]);
  int spendingModelsLength = 10;

  PageController pageController = PageController(initialPage: 0);

  // init
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    isLoading.value = true;
    // fetching country data (currency rats, currency symbols etc)
    currencyData.value = await FirestoreAPIs.getCurrencyRates();
    // fetching user data
    user.value = await FirestoreAPIs.getUser();
    isLoading.value = false;
    fetchSpendings(spendingModelsLength);
  }

  void fetchSpendings(int range) async {
    spendings.value = await FirestoreAPIs.getSpendings(range);
  }

  void changePage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
    // pageController.animateToPage(index,
    //     duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  void nextPage() {
    currentIndex.value++;
    pageController.animateToPage(currentIndex.value,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  void previousPage() {
    currentIndex.value--;
    pageController.animateToPage(currentIndex.value,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}
