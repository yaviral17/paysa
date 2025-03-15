import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:icons_plus/icons_plus.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchNode.addListener(() {
      setState(() {});
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: TextField(
                  focusNode: searchNode,
                  decoration: InputDecoration(
                    hintText: 'Search',
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
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ChatTile(
                      // onTap: () {
                      //   PNavigation.push(context, MessagesScreen());
                      // },
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
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
        PNavigate.to(ChatScreenView());
      },
      leading: RandomAvatar(
        "John Doe",
        width: 40,
        height: 40,
      ),
      title: Text(
        'John Doe',
        style: TextStyle(
          color: PColors.primaryText(context),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Hey, how are you?',
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
