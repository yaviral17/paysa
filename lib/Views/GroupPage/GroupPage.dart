import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Models/SessionsModel.dart';
import 'package:paysa/Views/Chats/ChatBubble.dart';
import 'package:paysa/utils/constants/sizes.dart';

class GroupPageScreen extends StatefulWidget {
  const GroupPageScreen({
    super.key,
    required this.session,
  });

  final SessionsModel session;

  @override
  State<GroupPageScreen> createState() => _GroupPageScreenState();
}

class _GroupPageScreenState extends State<GroupPageScreen> {
  double barWidth = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        barWidth = 0.7;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(vertical: 10),
                // height: TSizes.displayHeight(context) * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Iconsax.arrow_left_2),
                        ),
                        Hero(
                          tag: 'group_pfp',
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/images/ic_session.png'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.session.title.capitalize!,
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize!,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: TSizes.displayWidth(context) * 0.9,
                      decoration: BoxDecoration(
                        // color: Color(0xFFd9380b).withOpacity(0.6),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //500rs bar
                          AnimatedContainer(
                            height: TSizes.displayHeight(context) * 0.1,
                            width: TSizes.displayWidth(context) * barWidth,
                            duration: const Duration(seconds: 1),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            curve: Curves.fastOutSlowIn,
                            child: Text(
                              "\$${500}",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          //50 rs bar
                          Expanded(
                            child: AnimatedContainer(
                              height: TSizes.displayHeight(context) * 0.1,
                              // width: TSizes.displayWidth(context) * 0.7,
                              duration: const Duration(seconds: 1),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    // Theme.of(context).primaryColor.withOpacity(0.9),
                                    Color(0xFFd9380b).withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              curve: Curves.fastOutSlowIn,
                              child: Text(
                                "\$${50}",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'You owe \$${450} to User',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.6),
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 0.1,
                thickness: 3,
                indent: 20,
                endIndent: 20,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),

              // Chat Container and column
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Members'),
                    ChatBubble(
                      senderName: "AVIRAL",
                      message: "CHUP KARJAA",
                      timestamp: DateTime.now(),
                      isYou: true,
                    ),
                    ChatBubble(
                      senderName: "AVIRAL",
                      message: "CHUP KARJAA",
                      timestamp: DateTime.now(),
                      isYou: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: //add a bottom text field for chatting with group members
          Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Iconsax.send_2),
            ),
          ],
        ),
      ),
    );
  }
}
