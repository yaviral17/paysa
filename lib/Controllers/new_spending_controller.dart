import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Models/shopping_model.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:uuid/uuid.dart';

class NewSpendingController {
  Rx<SpendingType> spendingMode = SpendingType.shopping.obs;
  RxString amount = "".obs;
  RxBool isLoading = false.obs;

  Rx<Contact?> transferContact = Rx<Contact?>(null);
  RxList<Contact> searchedContacts = <Contact>[].obs;

  TextEditingController messageControler = TextEditingController();

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
    if (transferContact.value == null) {
      PHelper.showErrorMessageGet(
        title: "No Contact Selected 😕",
        message: "Please select a contact !",
      );
      log("No Contact Selected");
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

    // SpendingModel spending = SpendingModel(
    //   id: Uuid().v4(),
    //   createdAt: DateTime.now().toIso8601String(),
    //   createdBy: FirebaseAuth.instance.currentUser!.uid,
    //   updatedAt: DateTime.now().toIso8601String(),
    //   updatedBy: FirebaseAuth.instance.currentUser!.uid,
    //   spendingType: spendingMode.value,
    //   transferSpendingModel: TransferSpendingModel(
    //     amount: amount.value,
    //     message: messageControler.text.trim(),
    //     billImage: "",
    //     dateTime: DateTime.now(),
    //     location: "",
    //     transferedFrom: FirebaseAuth.instance.currentUser!.phoneNumber!,
    //     transferedTo: transferContact.value!.phones.first.number,
    //   ),
    // );
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
