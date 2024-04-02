import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/Views/Transactions/Transactions.dart';
import 'package:uuid/uuid.dart';

class CreateSplitController extends GetxController {
  RxList<UserModel> members = <UserModel>[].obs;
  TextEditingController splitNameController = TextEditingController();
  TextEditingController amountController = TextEditingController(text: "0");
  TextEditingController descriptionController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool memberFetch = false.obs;
  Group? group;
  Rx<UserModel?> paidBy = Rx<UserModel?>(null);
  RxList<UserModel> splitWith = <UserModel>[].obs;
  Rx<Map<UserModel, double>> splitAmount = Rx<Map<UserModel, double>>({});

  Future<void> fetchMemberModelList(Group group) async {
    memberFetch.value = true;
    this.group = group;
    members.value = await Group.getMembers(group.members);
    for (var member in members) {
      log("member fetch : " + member.name);
    }

    memberFetch.value = false;
  }

  Future<void> createSplit(BuildContext context) async {
    isLoading.value = true;

    // make member list in Map<String,dynamic> format for transaction
    //  {
    //     uid: "user_id",
    //     amount: 0,
    //     paid: false,
    // }
    //

    if (splitNameController.text.isEmpty) {
      log("Split name is empty");
      isLoading.value = false;
      return;
    }

    if (amountController.text.isEmpty) {
      log("Amount is empty");
      isLoading.value = false;
      return;
    }

    if (splitAmount.value.isEmpty) {
      log("Split amount is empty");
      isLoading.value = false;
      return;
    }

    if (splitAmount.value.values.reduce((a, b) => a + b) !=
        double.parse(amountController.text)) {
      log("Amount not equal to split amount");
    }

    if (splitAmount.value.values.any((element) => element < 0)) {
      log("Negative amount");
      isLoading.value = false;
      return;
    }

    // check if all amount in not 0
    // if (splitAmount.value.values.any((element) => element == 0)) {
    //   log("Amount is 0");
    //   isLoading.value = false;
    //   return;
    // }

    if (paidBy.value == null) {
      log("Paid by is null");
      isLoading.value = false;
      return;
    }

    if (splitWith.isEmpty) {
      log("No split with members selected");
      isLoading.value = false;
      return;
    }

    List<Map<String, dynamic>> transactionMembersList = [];
    for (var member in splitWith) {
      transactionMembersList.add({
        "uid": member.uid,
        "name": member.name,
        "amount": splitAmount.value[member] ?? 0,
        "paid": ((member.uid == paidBy.value!.uid) ||
                (splitAmount.value[member] == 0.0))
            ? true
            : false,
      });
    }
    log("Transaction members list : " + transactionMembersList.toString());

    Transaction transaction = Transaction(
      id: Uuid().v1(),
      amount: double.parse(amountController.text.trim()),
      description: descriptionController.text.trim().isEmpty
          ? ""
          : descriptionController.text,
      paidBy: paidBy.value!.uid,
      members: transactionMembersList,
      createdBy: FirebaseAuth.instance.currentUser!.uid,
      createdByUserName: FirebaseAuth.instance.currentUser!.displayName!,
      isSettled: false,
      splitName: splitNameController.text.trim(),
      timestamp: DateTime.now(),
    );

    await FireStoreRef.createConvo(group!.id, transaction.toJSon())
        .then((value) {
      log("Transaction created");
      Navigator.pop(context);
    }).catchError((error) {
      log("Error in creating transaction : " + error.toString());
    });

    isLoading.value = false;
  }
}
