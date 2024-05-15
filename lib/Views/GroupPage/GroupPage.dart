import 'package:cherry_toast/resources/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/Convo.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/SessionsModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/Views/Chats/ChatBubble.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';
import 'package:uuid/uuid.dart';

import '../../utils/constants/cherryToast.dart';

class GroupPageScreen extends StatefulWidget {
  const GroupPageScreen({
    super.key,
    required this.session,
  });

  final SessionsModel session;

  @override
  State<GroupPageScreen> createState() => _GroupPageScreenState();
}

class _GroupPageScreenState extends State<GroupPageScreen>
    with TickerProviderStateMixin {
  final TextEditingController chatController = TextEditingController();
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  double _userAmountPercentage = 0;
  double _userAmount = 0.0;
  double _totalAmount = 0.0;

  RxBool showSendButton = false.obs;
  RxBool _listning = false.obs;

  fetchAmountData(SessionsModel sessn) {
    setState(() {
      _totalAmount = sessn.users[0]['amount'] + sessn.users[1]['amount'];
      if (sessn.users[0]['uid'] == FirebaseAuth.instance.currentUser!.uid) {
        _userAmount = sessn.users[0]['amount'];
      } else {
        _userAmount = sessn.users[1]['amount'];
      }
      _userAmountPercentage = _userAmount / _totalAmount;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        fetchAmountData(widget.session);
      });
    });
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);
  }

  Stream<SessionsModel> _fetchSession() async* {
    Stream<Map<String, dynamic>?> getSessionData =
        await FireStoreRef.fetchSessionDataByIdStream(widget.session.id);
    yield* getSessionData.map((event) => SessionsModel.fromJson(event!));
  }

  Future<DailySpendingModel> _fetchSplit(String splitId) async {
    Map<String, dynamic> splitData =
        (await FireStoreRef.fetchSplitDataById(splitId))!;
    return DailySpendingModel.fromJson(splitData);
  }

  percentage(double amount) {
    return amount / _totalAmount * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: TSizes.displayHeight(context) * 0.08,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        showSendButton.value = false;
                      } else {
                        showSendButton.value = true;
                      }
                    },
                    controller: chatController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: showSendButton.value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (chatController.text.isEmpty) {
                          showErrorToast(
                              context, "Please enter a message to send.");
                          return;
                        }
                        Convo _convo = Convo(
                          id: Uuid().v1(),
                          sender: FirebaseAuth.instance.currentUser!.uid,
                          senderName:
                              FirebaseAuth.instance.currentUser!.displayName,
                          message: chatController.text,
                          timestamp: DateTime.now(),
                          type: "chat",
                        );
                        //send message to firestore
                        FireStoreRef.postConvoInSession(
                          widget.session.id,
                          _convo,
                        );

                        chatController.clear();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(Iconsax.send_2, color: TColors.white),
                      ),
                    ),
                  ),
                ),

                // Mic Button
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: GestureDetector(
                    onLongPressStart: (details) {
                      details.globalPosition;

                      _listning.value = true;
                    },
                    onLongPressEnd: (details) {
                      _listning.value = false;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.fastOutSlowIn,
                      padding: const EdgeInsets.all(10),
                      width: _listning.value ? 50 : 45,
                      height: _listning.value ? 50 : 45,
                      decoration: BoxDecoration(
                        color:
                            _listning.value ? TColors.error : TColors.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(Iconsax.microphone_2,
                          color: TColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerContainer(),
              // Container(
              //   margin: EdgeInsets.all(10),
              //   padding: EdgeInsets.symmetric(vertical: 10),
              //   // height: TSizes.displayHeight(context) * 0.3,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).primaryColor.withOpacity(0.2),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           IconButton(
              //             onPressed: () {
              //               Get.back();
              //             },
              //             icon: Icon(Iconsax.arrow_left_2),
              //           ),
              //           Hero(
              //             tag: 'group_pfp',
              //             child: CircleAvatar(
              //               radius: 20,
              //               backgroundImage:
              //                   AssetImage('assets/images/ic_session.png'),
              //             ),
              //           ),
              //           SizedBox(width: 10),
              //           Text(
              //             widget.session.title.capitalize!,
              //             style: TextStyle(
              //               fontSize: Theme.of(context)
              //                   .textTheme
              //                   .titleMedium!
              //                   .fontSize!,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),

              //       SizedBox(height: 10),
              //       // Text(
              //       //   "Group Description",
              //       //   style: TextStyle(
              //       //     fontSize:
              //       //         Theme.of(context).textTheme.titleMedium!.fontSize!,
              //       //     fontWeight: FontWeight.bold,
              //       //   ),
              //       // ),
              //       SizedBox(height: 10),

              //       //split bar
              //       Container(
              //         height: TSizes.displayHeight(context) * 0.08,
              //         width: TSizes.displayWidth(context) * 0.7,
              //         decoration: BoxDecoration(
              //           // color: Color(0xFFd9380b).withOpacity(0.6),
              //           border: Border.all(
              //             color: Theme.of(context)
              //                 .colorScheme
              //                 .background
              //                 .withOpacity(0.2),
              //             width: 2,
              //           ),
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             //500rs bar
              //             AnimatedContainer(
              //               height: TSizes.displayHeight(context) * 0.1,
              //               width: TSizes.displayWidth(context) *
              //                   (_user1Amount / _totalAmount),
              //               duration: const Duration(seconds: 1),
              //               alignment: Alignment.center,
              //               padding: EdgeInsets.all(10),
              //               decoration: BoxDecoration(
              //                 color: Theme.of(context)
              //                     .colorScheme
              //                     .primary
              //                     .withOpacity(0.5),
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               curve: Curves.fastOutSlowIn,
              //               child: Text(
              //                 //get split data from the given session id
              //                 "₹${_user1Amount}",

              //                 style: TextStyle(
              //                   fontSize: 30,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //             ),

              //             //50 rs bar
              //             Expanded(
              //               child: AnimatedContainer(
              //                 height: TSizes.displayHeight(context) * 0.1,
              //                 // width: TSizes.displayWidth(context) * 0.7,
              //                 duration: const Duration(seconds: 1),
              //                 alignment: Alignment.center,
              //                 padding: EdgeInsets.all(10),
              //                 decoration: BoxDecoration(
              //                   color:
              //                       // Theme.of(context).primaryColor.withOpacity(0.9),
              //                       Color(0xFFd9380b).withOpacity(0.7),
              //                   borderRadius: BorderRadius.circular(12),
              //                 ),
              //                 curve: Curves.fastOutSlowIn,
              //                 child: Text(
              //                   "₹${_user2Amount}",
              //                   style: TextStyle(
              //                     fontSize: 30,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(height: 10),
              //       Text(
              //         'You owe ₹${_user1Amount} to User',
              //         style: TextStyle(
              //           color: Colors.white.withOpacity(0.8),
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       )
              //     ],
              //   ),
              // ),

              // Divider(
              //   height: 0.1,
              //   thickness: 3,
              //   indent: 20,
              //   endIndent: 20,
              //   color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   " Your Chat ",
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // Chat Container and column
              SizedBox(
                height: TSizes.displayHeight(context) * 0.6,
                child: StreamBuilder(
                  stream: _fetchSession(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    SessionsModel latestSessionData =
                        snapshot.data as SessionsModel;

                    List<Convo> _convoList = latestSessionData.convoAndTags;
                    _convoList
                        .sort((a, b) => a.timestamp.compareTo(b.timestamp));
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            // make chatlist here

                            ...List.generate(
                              _convoList.length,
                              (index) {
                                Convo _chats = _convoList[index];

                                if (_chats.type == "chat") {
                                  return ChatBubble(
                                    isYou: _chats.sender ==
                                        FirebaseAuth.instance.currentUser!.uid,
                                    message: _chats.message,
                                    senderName: _chats.sender ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? 'You'
                                        : _chats.senderName ?? "User",
                                    timestamp: _chats.timestamp,
                                  );
                                }
                                if (_chats.type == "audio") {
                                  return Container();
                                }

                                if (_chats.type == "image") {
                                  return Container();
                                }

                                if (_chats.type == "split") {
                                  return FutureBuilder(
                                      future: _fetchSplit(_chats.id),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (snapshot.hasError) {
                                          return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'),
                                          );
                                        }

                                        DailySpendingModel _splitData =
                                            snapshot.data as DailySpendingModel;

                                        return spendingInfoTile(_splitData);
                                      });

                                  // return Container(
                                  //   margin: EdgeInsets.symmetric(vertical: 4),
                                  //   padding: EdgeInsets.all(8),
                                  //   decoration: BoxDecoration(
                                  //     color: TColors.primary,
                                  //     borderRadius: BorderRadius.only(
                                  //       topLeft: Radius.circular(12),
                                  //       topRight: Radius.circular(12),
                                  //       bottomLeft: Radius.circular(12),
                                  //       bottomRight: Radius.circular(12),
                                  //     ),
                                  //   ),
                                  //   child: Row(
                                  //     children: [
                                  //       Text(
                                  //         'Split',
                                  //         style: TextStyle(
                                  //           fontSize: 12,
                                  //           color: TColors.white.withOpacity(0.6),
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       ),
                                  //       Text(
                                  //         _chats.split.toString(),
                                  //         style: TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize: 16,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // );
                                }

                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: TSizes.displayHeight(context) * 0.1,
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: chatController,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (chatController.text.isEmpty) {
                          showErrorToast(
                              context, "Please enter a message to send.");
                          return;
                        }
                        Convo _convo = Convo(
                          id: Uuid().v1(),
                          sender: FirebaseAuth.instance.currentUser!.uid,
                          senderName:
                              FirebaseAuth.instance.currentUser!.displayName,
                          message: chatController.text,
                          timestamp: DateTime.now(),
                          type: "chat",
                        );
                        //send message to firestore
                        FireStoreRef.postConvoInSession(
                          widget.session.id,
                          _convo,
                        );

                        chatController.clear();
                      },
                      icon: Icon(Iconsax.send_2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton:
      //     //add a bottom text field for chatting with group members
      //     Container(
      //   margin: EdgeInsets.symmetric(horizontal: 10),
      //   padding: EdgeInsets.symmetric(horizontal: 10),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: TextField(
      //           controller: chatController,
      //           decoration: InputDecoration(
      //             hintText: 'Type a message',
      //             border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //           ),
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           if (chatController.text.isEmpty) {
      //             showErrorToast(context, "Please enter a message to send.");
      //             return;
      //           }
      //           Convo _convo = Convo(
      //             id: Uuid().v1(),
      //             sender: FirebaseAuth.instance.currentUser!.uid,
      //             senderName: FirebaseAuth.instance.currentUser!.displayName,
      //             message: chatController.text,
      //             timestamp: DateTime.now(),
      //             type: "chat",
      //           );
      //           //send message to firestore
      //           FireStoreRef.postConvoInSession(
      //             widget.session.id,
      //             _convo,
      //           );

      //           chatController.clear();
      //         },
      //         icon: Icon(Iconsax.send_2),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget headerContainer() {
    return Container(
      margin: const EdgeInsets.all(TSizes.defaultSpace),
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      width: TSizes.displayWidth(context),
      decoration: BoxDecoration(
        color: Color(0xff00430F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: TSizes.displayHeight(context) * (8 / 932),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Iconsax.arrow_left),
              ),
              SizedBox(width: TSizes.displayWidth(context) * 0.002),
              Hero(
                tag: 'group_pfp',
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/ic_session.png'),
                ),
              ),
              SizedBox(width: TSizes.displayWidth(context) * 0.04),
              Text(
                widget.session.title.capitalize!,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize!,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: TSizes.displayHeight(context) * (24 / 932),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Split Amount : ",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: TColors.white.withOpacity(0.6),
                      ),
                ),
                Text(
                  "₹ ${_userAmount.toString()}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: TColors.white,
                        fontSize: 18,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: TSizes.displayHeight(context) * (14 / 932),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Spending with this person : ",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: TColors.white.withOpacity(0.6),
                      ),
                ),
                Text(
                  "₹ ${_totalAmount.toString()}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: TColors.white,
                        fontSize: 18,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: TSizes.displayHeight(context) * (18 / 932),
          ),
          Center(
            child: Text(
              'You owe ₹${_userAmount} to User',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: TSizes.displayHeight(context) * (18 / 932),
          ),
          Divider(
            height: 0.1,
            thickness: 3,
            indent: 20,
            endIndent: 20,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
          SizedBox(
            height: TSizes.displayHeight(context) * (18 / 932),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            height: TSizes.displayHeight(context) * 0.06,
            width: TSizes.displayWidth(context),
            decoration: BoxDecoration(
              // color: Color(0xFFd9380b).withOpacity(0.6),
              color: const Color(0xff111111),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: [
                  LinearProgressIndicator(
                    minHeight: TSizes.displayHeight(context) * 0.058,
                    value: _userAmountPercentage,
                    backgroundColor: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xff00430F)),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹ ${_userAmount.toString()} / ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        Text(
                          '₹ ${_totalAmount.toString()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  spendingInfoTile(DailySpendingModel dailySpending) {
    return Container(
      width: TSizes.displayWidth(context),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: TColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: TSizes.displayWidth(context) * 0.063,
                backgroundImage: AssetImage(
                  'assets/expanses_category_icons/ic_${dailySpending.category}.png',
                ),
              ),
              SizedBox(width: TSizes.displayWidth(context) * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dailySpending.title.capitalizeFirst ?? "No Title",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    dailySpending.description.capitalizeFirst ??
                        "No Description",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹ " + dailySpending.amount.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    THelperFunctions.formateDateTime(
                        dailySpending.timestamp, 'h:mm a'),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
            ],
          ),

          // if (dailySpending.isSplit)

          if (dailySpending.isSplit) splitWidget(dailySpending),
        ],
      ),
    );
  }

  Widget splitWidget(DailySpendingModel _splitData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(_splitData.splits!.length, (index) {
          return FutureBuilder(
            future: FireStoreRef.getuserByUid(_splitData.splits![index].uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data'),
                );
              }

              UserModel user = UserModel.fromJson(snapshot.requireData);

              return usertagTile(user, _splitData, index);
            },
          );
        }),
      ],
    );
  }

  Padding usertagTile(
      UserModel user, DailySpendingModel dailySpending, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Container(
        // height: TSizes.displayWidth(context) * 0.1,
        padding: const EdgeInsets.all(4),
        width: TSizes.displayWidth(context) * 0.4,
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user.profile.isNotEmpty)
              CircleAvatar(
                radius: TSizes.displayWidth(context) * 0.036,
                backgroundImage: NetworkImage(user.profile),
              ),
            SizedBox(width: TSizes.displayWidth(context) * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: TSizes.displayWidth(context) * 0.27,
                  child: Text(
                    user.name ?? "No Name",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    dailySpending.splits![index].amount.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
