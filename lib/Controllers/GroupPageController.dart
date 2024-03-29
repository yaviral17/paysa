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

  void makeNewSplit(BuildContext context) async {
    List<UserModel> members = [];
    Rx<UserModel?> PaidBy = Rx<UserModel?>(null);
    TextEditingController amountController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    RxList<UserModel> membersSelected = <UserModel>[].obs;
    RxList<TextEditingController> memberAmmoutControllers =
        <TextEditingController>[].obs;
    Rx<bool> splitEqually = Rx<bool>(false);

    for (String member in group.value!.members) {
      Map<String, dynamic> memberUserData =
          await FireStoreRef.getuserByUid(member);
      UserModel user = UserModel.fromJson(memberUserData);
      members.add(user);
    }

    log("New Split");

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("New Split"),
            content: Obx(
              () => SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Amount",
                      ),
                      onChanged: (value) {
                        owes = double.parse(value);
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Description",
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Paid By"),
                        SizedBox(width: 4),
                        DropdownButton<UserModel>(
                          items: members
                              .map((e) => DropdownMenuItem<UserModel>(
                                    value: e,
                                    child: Text(e.name),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            PaidBy.value = value;
                          },
                          hint: Text("Select"),
                          value: PaidBy.value,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Split Equally"),
                        SizedBox(width: 4),
                        Checkbox(
                          value: splitEqually.value,
                          onChanged: (value) {
                            splitEqually.value = value!;
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Add Members"),
                        SizedBox(width: 4),
                        DropdownButton<UserModel>(
                          items: members
                              .map((e) => DropdownMenuItem<UserModel>(
                                    value: e,
                                    child: Text(e.name),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (!membersSelected.contains(value!)) {
                              membersSelected.add(value!);
                              if (membersSelected.length < 1) {
                                memberAmmoutControllers.add(
                                    TextEditingController(
                                        text: amountController.text));
                              } else {
                                double amount = 0;
                                for (TextEditingController controller
                                    in memberAmmoutControllers) {
                                  amount += double.parse(controller.text);
                                }

                                memberAmmoutControllers.add(
                                    TextEditingController(
                                        text: (double.parse(
                                                    amountController.text) -
                                                amount)
                                            .toString()));
                              }
                            }
                            log(membersSelected[0].toJson().toString());
                          },
                          hint: !(membersSelected.length > 0)
                              ? Text("Select")
                              : Text("Select More"),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        membersSelected.length,
                        (index) => ListTile(
                          title: Text(membersSelected[index].name),
                          trailing: splitEqually.value
                              ? Text((owes / membersSelected.length).toString())
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: TextField(
                                    controller: TextEditingController(),
                                    decoration: InputDecoration(
                                      hintText: "\$",
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  Transaction transaction = Transaction(
                    id: Uuid().v1(),
                    amount: double.parse(amountController.text),
                    description: descriptionController.text,
                    paidBy: PaidBy.value!.uid,
                    createdBy: FirebaseAuth.instance.currentUser!.uid,
                    timestamp: DateTime.now(),
                    members: membersSelected
                        .map((e) => {
                              "uid": e.uid,
                              "amount": splitEqually.value
                                  ? owes / membersSelected.length
                                  : double.parse(memberAmmoutControllers[
                                          membersSelected.indexOf(e)]
                                      .text),
                              "paid": e.uid ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? true
                                  : false
                            })
                        .toList(),
                    isSettled: false,
                    isChat: false,
                  );
                  await FireStoreRef.createConvo(
                    group.value!.id,
                    transaction.toJSon(),
                  );
                  Navigator.pop(context);
                },
                child: Text("Create Split"),
              ),
            ],
          );
        });
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
