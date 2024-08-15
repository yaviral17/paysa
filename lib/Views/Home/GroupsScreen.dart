import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/GroupScreenController.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/Models/SessionsModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/utils/constants/sizes.dart';

import '../../utils/helpers/helper_functions.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  GroupController groupController = Get.put(GroupController());
  List<SessionsModel> mySessions = [];
  List<String> splitUsersId = [];
  // late UserModel splitUser;

  Future<List<Group>> getGroups() async {
    List<Group>? groups = await FireStoreRef.getUserGroupList();
    if (groups == null) {
      log('No groups found');
      return [];
    }
    return groups;
  }

  Future<UserModel> getSplitUsers(String id) async {
    UserModel splitUser = await UserModel.getUserbodelById(id);
    return splitUser;
  }

  Future<SessionsModel> fetchSession(String id) async {
    Map<String, dynamic> ssn = await FireStoreRef.getSessions(id);

    return SessionsModel.fromJson(ssn);
  }

  @override
  Widget build(BuildContext context) {
    // THelperFunctions.hideBottomBlackStrip();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: FireStoreRef.getSessionsListStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return const Text("Something Went Wrong");
              }
              mySessions = [];
              for (Map<String, dynamic> session in snapshot.requireData) {
                SessionsModel object = SessionsModel.fromJson(session);
                for (var usr in object.users) {
                  if (usr['id'] == FirebaseAuth.instance.currentUser!.uid) {
                    mySessions.add(object);
                    if (object.users[1]['id'] ==
                        FirebaseAuth.instance.currentUser!.uid) {
                      splitUsersId.add(object.users[0]['id']);
                    } else {
                      splitUsersId.add(object.users[1]['id']);
                    }
                  }
                }
              }

              return ScreenUI(mySessions);
            },
          ),
        ),
      ),
    );
  }

  Widget ScreenUI(List<SessionsModel> sessionsIdList) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Search",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              prefixIcon: const Icon(
                Iconsax.search_normal,
              ),
              fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              // focusColor: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          SizedBox(
            height: TSizes.displayHeight(context) * 0.02,
          ),
          ...List.generate(
            sessionsIdList.length,
            (index) => Column(
              children: [
                SizedBox(
                  height: TSizes.displayHeight(context) * 0.02,
                ),
                FutureBuilder(
                    future: getSplitUsers(splitUsersId[index]),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              '/group-page',
                              arguments: sessionsIdList[index],
                            );
                          },
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.startToEnd,
                            confirmDismiss: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                return deleteGroup();
                              }
                              return Future.value(true);
                            },
                            //dismissible background
                            background: Container(
                              height: TSizes.displayHeight(context) * 0.11,
                              margin: const EdgeInsets.only(
                                bottom: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).colorScheme.error,
                              ),
                              padding: const EdgeInsets.only(left: 22),
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),

                            //main container for each group
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 12,
                              ),
                              height: TSizes.displayHeight(context) * 0.07,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Hero(
                                          tag: 'group_pfp',
                                          child: CircularCachedNetworkimage(
                                            url: snapshot.requireData.profile,
                                            width:
                                                TSizes.displayWidth(context) *
                                                    0.12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            TSizes.displayWidth(context) * 0.02,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // sessionsIdList[index].title.capitalizeFirst ?? "",
                                            snapshot.requireData.name,

                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                          SizedBox(
                                            height:
                                                TSizes.displayHeight(context) *
                                                    0.014,
                                          ),
                                          Text("Tap to see more",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                      THelperFunctions.formateDateTime(sessionsIdList[index].timestamp, "dd/MM/yyyy"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Colors.grey,
                                          )),

                                  //add cupertino menu for share,delete and edit groups here
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
          // Text(
          //   "HELLO ",
          //   style: Theme.of(context).textTheme.bodyLarge,
          // ),
        ],
      ),
    );
  }

  Future<bool?> deleteGroup() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Group"),
          content: const Text("Are you sure you want to delete this group?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // FireStoreRef.leaveGroup(
                //     sessionsIdList[index].id);
                Navigator.pop(context, true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}

class CircularCachedNetworkimage extends StatelessWidget {
  String url;
  Widget? placeholder;
  Widget? onError;
  double? width;
  double? height;

  CircularCachedNetworkimage({
    super.key,
    required this.url,
    this.placeholder,
    this.height,
    this.width,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) =>
              placeholder ?? const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              onError ??
              Image.asset(
                "assets/images/ic_session.png",
              ),
          errorListener: (value) {
            value.printError();
            value.printInfo();
          },
        ),
      ),
    );
  }
}
