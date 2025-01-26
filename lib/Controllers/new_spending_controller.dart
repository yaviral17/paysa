import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';

class NewSpendingController {
  Rx<SpendingType> spendingMode = SpendingType.shopping.obs;
  RxString amount = "".obs;

  Rx<Contact?> transferContact = Rx<Contact?>(null);
  RxList<Contact> searchedContacts = <Contact>[].obs;

  TextEditingController messageControler = TextEditingController();

  Future<void> createSpending() async {
    switch (spendingMode) {
      case SpendingType.shopping:
        await shoppingCreation();
        break;
      case SpendingType.transfer:
        await transferCreation();
        break;
      case SpendingType.split:
        await splitCreation();
        break;
      case SpendingType.other:
        log("Other");
        break;
    }
  }

  Future<void> shoppingCreation() async {}

  Future<void> transferCreation() async {
    log("Transfer");
  }

  Future<void> splitCreation() async {
    log("Split");
  }

  Future<void> incomeCreation() async {
    log("Income");
  }

  Future<void> otherCreation() async {
    log("Other");
  }
}
