import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/Views/Chats/ChatModel.dart';
import 'package:paysa/Views/Transactions/Transactions.dart';
import 'package:uuid/uuid.dart';

class GroupPageController extends GetxController {
  TextEditingController chatController = TextEditingController();

  RxList<File> attachments = <File>[].obs;

  RxList<dynamic> tiles = [
    ChatMessage(
      id: "1",
      createdBy: "You",
      message: "Hello, how are you?",
      timestamp: DateTime.now(),
      isChat: true,
    ),
    ChatMessage(
      id: "1",
      createdBy: "l9HAU9uitCOlAAtGwlaaOQhKCxv1",
      message: "I'm good, thank you!",
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isChat: true,
    ),
    Transaction(
      id: "1",
      createdBy: "l9HAU9uitCOlAAtGwlaaOQhKCxv1",
      amount: 100,
      timestamp: DateTime.now(),
      isChat: false,
      isSettled: false,
      description: "Lunch",
      paidBy: "l9HAU9uitCOlAAtGwlaaOQhKCxv1",
      members: [
        {"uid": "l9HAU9uitCOlAAtGwlaaOQhKCxv1", "paid": true},
        {"uid": "PgUpuuGHMva4URqxU0s5eKxM3Mm2", "paid": false},
      ],
    ),
  ].obs;
  double owes = 0;

  void makeNewSplit() {
    log("New Split");
  }

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
