import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:uuid/uuid.dart';

class CreateGroupController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDescriptionController = TextEditingController();
  TextEditingController groupCategoryController = TextEditingController();

  void createGroup() {
    isLoading.value = true;
    // create grou
    if (groupNameController.text.isNotEmpty &&
        groupDescriptionController.text.isNotEmpty &&
        groupCategoryController.text.isNotEmpty) {
      Group group = Group(
        id: const Uuid().v1(),
        name: groupNameController.text,
        description: groupDescriptionController.text,
        members: <String>[FirebaseAuth.instance.currentUser!.uid],
        admins: <String>[FirebaseAuth.instance.currentUser!.uid],
        category: groupCategoryController.text,
        icon:
            "https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg",
        createdBy: FirebaseAuth.instance.currentUser!.uid,
      );
      Get.back();
    } else {
      Get.snackbar('Error', 'All fields are required');
    }

    isLoading.value = false;
  }
}
