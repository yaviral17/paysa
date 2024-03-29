import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/GroupPageController.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/Views/Chats/ChatBubble.dart';
import 'package:paysa/Views/Chats/ChatModel.dart';
import 'package:paysa/Views/Chats/TransactionBubble.dart';
import 'package:paysa/Views/Transactions/Transactions.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

class GroupPage extends StatefulWidget {
  GroupPage({super.key, required this.group});

  final Group group;

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  late GroupPageController controller = Get.put(GroupPageController());

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // log("page reseted");
    // controller.fetchChat(widget.group.id);
    // controller.fetchData();
    controller.group.value = widget.group;
    super.initState();
  }

  final List<ChatMessage> chatMessages = [];

  @override
  Widget build(BuildContext context) {
    // log(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.group.name),
            // Spacer(),
            SizedBox(
              width: 150,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.group.icon),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Row(children: [
                  const Text(
                    "Group Name ",
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(widget.group.name, style: TextStyle(fontSize: 24)),
                ]),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.primaries[0],
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Due",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          "₹" + ["owes"].toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[400],
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Owes",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          "₹" + ["due"].toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: TColors.primary,
                  thickness: 2,
                ),

                StreamBuilder(
                  stream: FireStoreRef.getConvoStream(widget.group.id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.requireData.docs.isEmpty) {
                      return const Center(
                        child: Text("No messages yet"),
                      );
                    }

                    // get data from snapshot
                    // final data = snapshot.data as List<Map<String, dynamic>>;
                    log("Snapshot data : \n" +
                        snapshot.requireData.docs[0].data().toString());
                    controller.tiles.clear();
                    for (final chat in snapshot.requireData.docs) {
                      if (chat['isChat']) {
                        controller.tiles.add(ChatMessage.fromJSon(chat.data()));
                      } else {
                        controller.tiles.add(Transaction.fromJSon(chat.data()));
                      }
                    }
                    controller.tiles
                        .sort((a, b) => a.timestamp.compareTo(b.timestamp));

                    return Obx(() => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            controller.tiles.length,
                            (index) {
                              final message = controller.tiles[index];
                              if (message.isChat) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    // top: 2.0,
                                    // bottom: 2.0,
                                  ),
                                  child: ChatBubble(
                                    senderName: message.createdByUserName,
                                    message: message.message,
                                    timestamp: message.timestamp,
                                    isYou: message.createdBy ==
                                        FirebaseAuth.instance.currentUser!.uid,
                                  ),
                                );
                              }
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                              return TransactionBubble(
                                transaction: message,
                              );
                            },
                          ),
                        ));
                  },
                ),

                SizedBox(
                  height: TSizes.displayHeight(context) * 0.1,
                )
                // Text("These Are the members of the group ${group.name}"),
                // ...List.generate(group.members.length,
                //     (index) => Chip(label: Text(group.members[index]))),
                // Text("These Are the admins of the group ${group.name}"),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ChatBottomBar(
              group: widget.group,
            ),
          )
        ],
      ),
    );
  }
}

class ChatBottomBar extends StatelessWidget {
  ChatBottomBar({
    super.key,
    required this.group,
  });

  final GroupPageController controller = Get.put(GroupPageController());
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.all(8),
          width: TSizes.displayWidth(context) * 0.98,
          height: 0,
          decoration: BoxDecoration(
            color: TColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Container(
            width: TSizes.displayWidth(context),
            height: TSizes.appBarHeight,
            decoration: BoxDecoration(
              color: TColors.primary,
            ),
            child: Row(
              children: [
                // Create Split
                IconButton(
                  onPressed: () {
                    controller.makeNewSplit(context);
                  },
                  icon: const Icon(
                    Icons.payments_sharp,
                    color: Colors.white,
                  ),
                ),

                // Icon button for attachments
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.attach_file,
                    color: Colors.white,
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.chatController,
                      decoration: const InputDecoration(
                        hintText: "Type a message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.sendChat(group.id);
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
