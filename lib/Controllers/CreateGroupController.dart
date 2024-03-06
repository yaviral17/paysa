import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/utils/constants/cherryToast.dart';
import 'package:uuid/uuid.dart';

class CreateGroupController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAddMemberLoading = false.obs;
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDescriptionController = TextEditingController();
  TextEditingController groupCategoryController = TextEditingController();
  TextEditingController addMember = TextEditingController();
  RxList<UserModel> members = <UserModel>[].obs;

  void createGroup(BuildContext context) async {
    isLoading.value = true;

    // create group

    if (groupNameController.text.trim().isEmpty) {
      log("hiii");
      isLoading.value = false;
      showErrorToast(context, 'Please enter group name');
      return;
    }

    if (groupDescriptionController.text.trim().isEmpty) {
      isLoading.value = false;
      showErrorToast(context, 'Please enter group description');
      return;
    }

    Group group = Group(
      id: const Uuid().v1(),
      name: groupNameController.text,
      description: groupDescriptionController.text,
      members: members.length == 0
          ? <String>[FirebaseAuth.instance.currentUser!.uid]
          : members.map((e) => e.uid).toList() +
              <String>[FirebaseAuth.instance.currentUser!.uid],
      admins: <String>[FirebaseAuth.instance.currentUser!.uid],
      category: groupCategoryController.text,
      icon:
          "https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg",
      createdBy: FirebaseAuth.instance.currentUser!.uid,
    );
    await FireStoreRef.addGroup(group);

    isLoading.value = false;
    Get.back();
  }

  void onPressAddButton(BuildContext context) async {
    isAddMemberLoading.value = true;
    if (addMember.text.trim().isEmpty) {
      // add member

      showErrorToast(context, 'Please enter email of member to add');
      isAddMemberLoading.value = false;
      return;
    }
    if (addMember.text.trim() == FirebaseAuth.instance.currentUser!.email) {
      showErrorToast(context, 'You cannot add yourself');
      isAddMemberLoading.value = false;
      return;
    }
    Map<String, dynamic>? user =
        await FireStoreRef.getUserByEmail(addMember.text);

    if (user == null) {
      showErrorToast(context, 'User not found');
      isAddMemberLoading.value = false;
      return;
    }
    if (members
        .where((element) => element.email == addMember.text)
        .isNotEmpty) {
      showErrorToast(context, 'User already added');
      isAddMemberLoading.value = false;
      return;
    }
    log(user.toString());

    members.add(UserModel.fromJson(user));
    addMember.clear();
    isAddMemberLoading.value = false;
  }
}
