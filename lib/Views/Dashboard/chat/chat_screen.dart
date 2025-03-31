import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Controllers/dashboard_controller.dart';
import 'package:paysa/Models/chat_session.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/chat/convo/messages_screen.dart';
import 'package:paysa/Views/auth/login/login_view.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FocusNode searchNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchNode.addListener(() {
      setState(() {});
    });
  }

  Stream<List<ChatSession>> getChatSessions() {
    return FirestoreAPIs.getChatSessions().map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatSession.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.background(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Chats',
                          style: TextStyle(
                            color: PColors.primaryText(context),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            '12 unread',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: PSize.arw(context, 18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          HugeIcons.strokeRoundedFilter,
                          color: PColors.primaryText(context),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          HugeIcons.strokeRoundedNotification03,
                          color: PColors.primaryText(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SearchTextField(
                searchNode: searchNode,
                controller: searchController,
              ),
              const SizedBox(height: 20),
              // Obx(
              //   () => ListView.builder(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemCount: dashboardController.chatSessions.length,
              //     itemBuilder: (context, index) {
              //       ChatSession chatSession =
              //           dashboardController.chatSessions[index];
              //       return ChatTile(
              //         chatSession: chatSession,
              //       );
              //     },
              //   ),
              // ),
              StreamBuilder<List<ChatSession>>(
                stream: getChatSessions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(
                          color: PColors.primaryText(context),
                        ),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No chat sessions found',
                        style: TextStyle(
                          color: PColors.primaryText(context),
                        ),
                      ),
                    );
                  }

                  // Use the data from the snapshot to build the list
                  final chatSessions = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: chatSessions.length,
                    itemBuilder: (context, index) {
                      ChatSession chatSession = chatSessions[index];
                      return ChatTile(
                        chatSession: chatSession,
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.searchNode,
    required this.controller,
    this.onChanged,
    this.hintText,
  });

  final FocusNode searchNode;
  final TextEditingController controller;
  final String? hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: TextField(
        focusNode: searchNode,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText ?? 'Search',
          hintStyle: TextStyle(
            color: PColors.secondaryText(context),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            HugeIcons.strokeRoundedSearch01,
            color: searchNode.hasFocus
                ? PColors.primaryText(context)
                : PColors.secondaryText(context),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: PColors.searchtextField(context),
        ),
        style: TextStyle(
          color: PColors.primaryText(context),
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final ChatSession chatSession;
  const ChatTile({
    super.key,
    required this.chatSession,
  });

  @override
  Widget build(BuildContext context) {
    bool isBetweenTwoUsers = chatSession.users.length == 2;
    bool isGroupChat = chatSession.users.length > 2;

    return ListTile(
      splashColor: PColors.containerSecondary(context),
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        SmoothRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        1,
      ),
      onTap: () {
        PNavigate.to(ChatScreenView(
          sessionId: chatSession.id,
        ));
      },
      leading: RandomAvatar(
        isBetweenTwoUsers
            ? chatSession.participants[0].uid ==
                    FirebaseAuth.instance.currentUser!.uid
                ? chatSession.participants[1].username!
                : chatSession.participants[0].username!
            : chatSession.id,
        width: 40,
        height: 40,
      ),
      title: Text(
        isBetweenTwoUsers
            ? chatSession.participants[0].uid ==
                    FirebaseAuth.instance.currentUser!.uid
                ? chatSession.participants[1].username!
                : chatSession.participants[0].username!
            : chatSession.id,
        style: TextStyle(
          color: PColors.primaryText(context),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        chatSession.lastMessage ?? " ",
        maxLines: 1,
        style: TextStyle(
          color: PColors.secondaryText(context),
          fontSize: 14,
        ),
      ),
      trailing: Text(
        '12:30 PM',
        style: TextStyle(
          color: PColors.secondaryText(context),
          fontSize: 14,
        ),
      ),
    );
  }
}
