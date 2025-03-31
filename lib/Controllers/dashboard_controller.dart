import 'dart:developer';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';

class DashboardController extends GetxController {
  IndicatorController indicatorController = IndicatorController();
  RxBool isLoading = false.obs;
  Rx<Map<String, dynamic>> currencyData = Rx({});
  Rx<UserModel?> user = Rx(null);
  RxInt currentIndex = 0.obs;
  Rx<String> fcmToken = "".obs;

  Rx<List<SpendingModel>> spendings = Rx([]);
  int spendingModelsLength = 10;

  Rx<List<SpendingModel>> shoppingSpendings = Rx(<SpendingModel>[]);
  Rx<List<SpendingModel>> splitSpendings = Rx(<SpendingModel>[]);
  Rx<List<SpendingModel>> transferSpendings = Rx(<SpendingModel>[]);

  PageController pageController = PageController(initialPage: 0);

  // init
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    // fetching country data (currency rats, currency symbols etc)
    currencyData.value = await FirestoreAPIs.getCurrencyRates();
    // fetching user data
    user.value = await FirestoreAPIs.getUser();
    await fetchSpendings(spendingModelsLength).then(
      (value) {
        log('${spendings.value.length} Spendings fetched');
      },
    );
    await divideSpendings().then(
      (value) {
        log('Spendings divided');
      },
    );

    isLoading.value = false;
  }

  Future<void> divideSpendings() async {
    List<SpendingModel> shop = [];
    List<SpendingModel> spit = [];
    List<SpendingModel> trans = [];

    for (var element in spendings.value) {
      if (element.spendingType == SpendingType.shopping) {
        shop.add(element);
      } else if (element.spendingType == SpendingType.split) {
        spit.add(element);
      } else if (element.spendingType == SpendingType.transfer) {
        UserModel otherUser = await FirestoreAPIs.getUser(
            uid: element.users[0] == FirebaseAuth.instance.currentUser!.uid
                ? element.users[1]
                : element.users[0]);

        if (otherUser.uid == element.transferSpendingModel!.transferedFrom) {
          element.transferSpendingModel!.transferdFromUser = otherUser;
          element.transferSpendingModel!.transferdToUser = user.value;
        } else {
          element.transferSpendingModel!.transferdFromUser = user.value;
          element.transferSpendingModel!.transferdToUser = otherUser;
        }
        trans.add(element);
      }
    }
    shoppingSpendings.value = shop;
    splitSpendings.value = spit;
    transferSpendings.value = trans;

    log('Shopping Spendings: ${shoppingSpendings.value.length}');
    log('Split Spendings: ${splitSpendings.value.length}');
    log('Transfer Spendings: ${transferSpendings.value.length}');
  }

  Future<void> fetchSpendings(int? range) async {
    spendings.value = await FirestoreAPIs.getSpendings(range);
    for (var element in spendings.value) {
      log(element.spendingType.value, name: "Spending Type");
    }
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
