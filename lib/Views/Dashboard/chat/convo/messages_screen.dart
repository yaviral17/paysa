import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Models/chat_model.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ChatScreenView extends StatelessWidget {
  const ChatScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChatMessage> messages = [
      ChatMessage(
        id: "1",
        message:
            "Hi, good to see you! We're starting work on a presentation for a new product today, right?",
        sender: UserModel(),
        time: DateTime.now(),
      ),
      ChatMessage(
        id: "2",
        message:
            "Yes, that's right. Let's discuss the main points and structure of the presentation.",
        sender: UserModel(),
        time: DateTime.now(),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * 0.25,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(HugeIcons.strokeRoundedArrowLeft01),
              onPressed: () {
                PNavigate.back();
              },
            ),
            //message count
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                '12',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: PSize.arw(context, 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        //user name and status
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'John Doe',
              style: TextStyle(
                letterSpacing: 0.4,
                color: Colors.white,
                fontSize: PSize.arw(context, 24),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Online',
              style: TextStyle(
                color: Colors.grey,
                fontSize: PSize.arw(context, 14),
              ),
            ),
          ],
        ),
        //more options button
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(HugeIcons.strokeRoundedMoreHorizontal),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                return Align(
                  alignment: (message.sender.uid ==
                          FirebaseAuth.instance.currentUser!.uid)
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: (message.sender.uid ==
                            FirebaseAuth.instance.currentUser!.uid)
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      // User avatar
                      (message.sender.uid ==
                              FirebaseAuth.instance.currentUser!.uid)
                          ? Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: SmoothClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                  color:
                                      PColors.primary(context).withOpacity(0.7),
                                  width: 2,
                                ),
                                child: Image.network(
                                  "https://avatars.githubusercontent.com/u/109690866?v=4",
                                  width: PSize.arw(context, 50),
                                  height: PSize.arw(context, 50),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      (message.sender.uid ==
                              FirebaseAuth.instance.currentUser!.uid)
                          ? const SizedBox(width: 8)
                          : const SizedBox(),

                      //chat message box

                      CustChatBubble(message: message),
                      const SizedBox(width: 8),
                      // User avatar
                      if (message.sender.uid !=
                          FirebaseAuth.instance.currentUser!.uid)
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: SmoothClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(
                              color: PColors.primary(context).withOpacity(0.7),
                              width: 2,
                            ),
                            child: Image.network(
                              "https://avatars.githubusercontent.com/u/58760825?s=400&u=735ec2d81037c15adfbeea61a5a3112aef3afb85&v=4",
                              width: PSize.arw(context, 50),
                              height: PSize.arw(context, 50),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Message input text field
        ],
      ),
      bottomNavigationBar: CustChatTextField(),
    );
  }
}

class CustChatTextField extends StatefulWidget {
  const CustChatTextField({
    super.key,
  });

  @override
  State<CustChatTextField> createState() => _CustChatTextFieldState();
}

class _CustChatTextFieldState extends State<CustChatTextField> {
  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[800],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your message...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          //add attachment button
          IconButton(
            icon: const Icon(HugeIcons.strokeRoundedAddCircleHalfDot),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class CustChatBubble extends StatelessWidget {
  const CustChatBubble({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return (message.sender.uid == FirebaseAuth.instance.currentUser!.uid)
        ?
        // user chat bubble
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: const EdgeInsets.only(bottom: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: const BoxDecoration(
              color: Color(0xffc1f6a7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender.username ?? "-",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  message.message,
                  // "Hi, good to see you! We're starting work on a presentation for a new product today, right?",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    letterSpacing: 0.4,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      message.time.toString(),
                      // "8:36 PM",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        :
        // receiver chat bubble
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: const EdgeInsets.only(bottom: 10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender.username ?? "-",
                  style: const TextStyle(
                    color: Color(0xffc1f6a7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  message.message,
                  // "Hi, good to see you! We're starting work on a presentation for a new product today, right?",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 0.4,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      message.time.toString(),
                      // "8:36 PM",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
