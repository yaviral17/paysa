import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:paysa/APIs/firebsae_functions_api.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Controllers/dashboard_controller.dart';
import 'package:paysa/Models/notification_model.dart';
import 'package:paysa/Models/shopping_model.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Models/transfer_spending_model.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:uuid/uuid.dart';

class NewSpendingController {
  Rx<SpendingType> spendingMode = SpendingType.shopping.obs;
  RxString amount = "".obs;
  RxBool isLoading = false.obs;

  Rx<UserModel?> transferUser = Rx<UserModel?>(null);
  RxList<UserModel> searchedUsers = <UserModel>[].obs;

  TextEditingController messageControler = TextEditingController();
  final dashboardController = Get.find<DashboardController>();

  Future<void> createSpending() async {
    log("Create Spending : isloading : ${isLoading.value}");
    if (isLoading.value) {
      PHelper.showInfoMessageGet(
        title: "Please Wait",
        message: "Please wait for the current operation to complete",
      );
      log("Please Wait");
      return;
    }

    if (messageControler.text.trim().isEmpty) {
      PHelper.showErrorMessageGet(
        title: "Message is empty 😕",
        message: "Please enter a message for the spending !",
      );
      log("Message is empty");
      return;
    }

    isLoading.value = true;
    switch (spendingMode.value) {
      case SpendingType.shopping:
        await shoppingCreation();
        break;
      case SpendingType.transfer:
        await transferCreation();
        break;
      case SpendingType.split:
        await splitCreation();
        break;
      case SpendingType.income:
        await incomeCreation();
        break;
      case SpendingType.other:
        log("Other");
        break;
    }
    isLoading.value = false;
    dashboardController.fetchData();
  }

  Future<void> shoppingCreation() async {
    if (amount.value.isEmpty) {
      PHelper.showErrorMessageGet(
          title: "Amount is empty", message: "Please enter the amount");
      log("Amount is empty");
      return;
    }

    double amountValue = double.parse(amount.value);

    if (amountValue <= 0) {
      PHelper.showErrorMessageGet(
          title: "Amount is invalid", message: "Please enter a valid amount");
      log("Amount is invalid");
      return;
    }

    SpendingModel spending = SpendingModel(
      id: Uuid().v4(),
      createdAt: DateTime.now().toIso8601String(),
      createdBy: FirebaseAuth.instance.currentUser!.uid,
      updatedAt: DateTime.now().toIso8601String(),
      updatedBy: FirebaseAuth.instance.currentUser!.uid,
      spendingType: spendingMode.value,
      users: [FirebaseAuth.instance.currentUser!.uid],
      shoppingModel: ShoppingModel(
        amount: amount.value,
        message: messageControler.text.trim(),
        billImage: "",
        dateTime: DateTime.now(),
        location: "",
        category: "",
      ),
    );
    await FirestoreAPIs.addSpendingToUser(
        FirebaseAuth.instance.currentUser!.uid, spending.id);
    await FirestoreAPIs.addSpending(spending);
    Get.back();
    PHelper.showSuccessMessageGet(
        title: "Spending Created", message: "Spending created successfully");
    log("Spending Created");
  }

  Future<void> transferCreation() async {
    if (transferUser.value == null) {
      PHelper.showErrorMessageGet(
        title: "No User Selected 😕",
        message: "Please select a user !",
      );
      log("No user Selected");
      return;
    }

    if (amount.value.isEmpty) {
      PHelper.showErrorMessageGet(
        title: "Amount is empty",
        message: "Please enter the amount",
      );
      log("Amount is empty");
      return;
    }

    double amountValue = double.parse(amount.value);

    if (amountValue <= 0) {
      PHelper.showErrorMessageGet(
        title: "Amount is invalid",
        message: "Please enter a valid amount",
      );
      log("Amount is invalid");
      return;
    }

    SpendingModel spending = SpendingModel(
      id: Uuid().v4(),
      createdAt: DateTime.now().toIso8601String(),
      createdBy: FirebaseAuth.instance.currentUser!.uid,
      updatedAt: DateTime.now().toIso8601String(),
      updatedBy: FirebaseAuth.instance.currentUser!.uid,
      spendingType: spendingMode.value,
      transferSpendingModel: TransferSpendingModel(
        amount: amount.value,
        message: messageControler.text.trim(),
        billImage: "",
        dateTime: DateTime.now(),
        location: "",
        transferedFrom: FirebaseAuth.instance.currentUser!.uid,
        transferedTo: transferUser.value!.uid!,
      ),
      users: [FirebaseAuth.instance.currentUser!.uid, transferUser.value!.uid!],
    );
    await FirestoreAPIs.addSpendingToUser(
        FirebaseAuth.instance.currentUser!.uid, spending.id);
    await FirestoreAPIs.addSpendingToUser(
        transferUser.value!.uid!, spending.id);
    await FirestoreAPIs.addSpending(spending);
    String myToken = Get.find<DashboardController>().fcmToken.value;

    await FirebsaeFunctionsApi.sendNotifications(
      [
        NotificationModel(
            title: "New Transfer Added",
            body:
                "You have received a transfer of ${amount.value} from ${FirebaseAuth.instance.currentUser!.displayName}",
            token: transferUser.value!.token!),
        NotificationModel(
          title: "New Transfer Added",
          body:
              "You have sent a transfer of ${amount.value} to ${transferUser.value!.firstname}",
          token: Get.find<DashboardController>().fcmToken.value,
        ),
      ],
    );

    Get.back();
    PHelper.showSuccessMessageGet(
        title: "Spending Created", message: "Spending created successfully");
    log("Spending Created");
  }

  Future<void> splitCreation() async {
    if (amount.value.isEmpty) {
      PHelper.showErrorMessageGet(
        title: "Amount is empty",
        message: "Please enter the amount",
      );
      log("Amount is empty");
      return;
    }
    double amountValue = double.parse(amount.value);
    if (amountValue <= 0) {
      PHelper.showErrorMessageGet(
        title: "Amount is invalid",
        message: "Please enter a valid amount",
      );
      log("Amount is invalid");
      return;
    }
  }

  Future<void> incomeCreation() async {
    log("Income");
  }

  Future<void> otherCreation() async {
    log("Other");
  }
}
