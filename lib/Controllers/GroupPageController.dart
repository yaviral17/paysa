import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/Views/Chats/ChatModel.dart';
import 'package:paysa/Views/Transactions/Transactions.dart';
import 'package:uuid/uuid.dart';

class GroupPageController extends GetxController {
  TextEditingController chatController = TextEditingController();

  Rx<Group?> group = Rx<Group?>(null);

  RxList<File> attachments = <File>[].obs;

  RxList<dynamic> tiles = [].obs;
  double owes = 0;

  Future<void> fetchChat(String groupId) async {
    resetValues();
    List<Map<String, dynamic>> data = await FireStoreRef.getConvoList(groupId);
    // log(groupId);
    // log(data.toString());
    for (Map<String, dynamic> chat in data) {
      if (chat['isChat']) {
        tiles.add(ChatMessage.fromJSon(chat));
      } else {
        tiles.add(Transaction.fromJSon(chat));
      }
    }

    tiles.sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  // void fetchData() {}

  void sendChat(String groupId) {
    if (chatController.text.isEmpty) {
      log("Empty message");
      return;
    }

    ChatMessage chatMessage = ChatMessage(
      id: Uuid().v1(),
      createdBy: FirebaseAuth.instance.currentUser!.uid,
      createdByUserName: FirebaseAuth.instance.currentUser!.displayName!,
      message: chatController.text,
      timestamp: DateTime.now(),
      isChat: true,
    );
    tiles.add(chatMessage);
    FireStoreRef.createConvo(
      groupId,
      chatMessage.toJSon(),
    );

    chatController.clear();
  }

  void settleSplit() {}

  void deleteSplit() {}

  void deleteChat() {}

  void editSplit() {}

  void resetValues() {
    chatController.clear();
    attachments.clear();
    tiles.clear();
    owes = 0;
  }
}
