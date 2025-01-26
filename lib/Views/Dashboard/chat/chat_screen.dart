import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/chat/convo/messages_screen.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PColors.background(context),
        body: CustomScrollView(
          slivers: [
            // Purple top section
            SliverAppBar(
              expandedHeight: PSize.arh(context, 220),
              floating: false,
              pinned: false,
              automaticallyImplyLeading: false,
              // backgroundColor: Colors.purple,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    SizedBox(
                      height: PSize.arh(context, 16),
                    ),
                    // Chat row
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "You Received",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: PSize.arw(context, 16),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: PSize.arh(context, 12),
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "12 Messages",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: PSize.arw(context, 24),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: PSize.arh(context, 16),
                    ),

                    // Contacts row
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Contact List",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: PSize.arw(context, 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: PSize.arh(context, 12),
                    ),
                    // Contacts row
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ZoomTapAnimation(
                              onTap: () {
                                PNavigate.to(const ChatScreenView());
                              },
                              child: Column(
                                children: [
                                  RandomAvatar(
                                    "User ${index + 1}",
                                    width: PSize.arw(context, 60),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "User ${index + 1}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // White scrollable chat section
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: PColors.referCardBg(context),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: PSize.arw(context, 16)),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle:
                                TextStyle(color: PColors.primaryTextLight),
                            border: InputBorder.none,
                            icon: Icon(
                              HugeIcons.strokeRoundedSearch01,
                              color: PColors.primaryDark,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: PSize.arh(context, 2),
                      ),
                      // Chat list
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        padding: EdgeInsets.symmetric(
                            vertical: PSize.arh(context, 8)),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: PSize.arh(context, 8),
                            ),
                            child: Row(
                              children: [
                                SmoothClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                    color: PColors.primary(context)
                                        .withOpacity(0.7),
                                    width: 2,
                                  ),
                                  child: RandomAvatar(
                                    "User ${index + 1}",
                                    width: PSize.arw(context, 50),
                                  ),
                                ),
                                SizedBox(
                                  width: PSize.arw(context, 8),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "User ${index + 1}",
                                      style: TextStyle(
                                        fontSize: PSize.arw(context, 16),
                                      ),
                                    ),
                                    Text(
                                      "Last message from user ${index + 1}",
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey,
                                        fontSize: PSize.arw(context, 14),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  "10:${index}0 AM",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: PSize.arw(context, 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
