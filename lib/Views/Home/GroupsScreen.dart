import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/GroupScreenController.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/Models/SessionsModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';
import 'package:pull_down_button/pull_down_button.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  GroupController groupController = Get.put(GroupController());
  List<SessionsModel> mySessions = [];

  Future<List<Group>> getGroups() async {
    List<Group>? groups = await FireStoreRef.getUserGroupList();
    if (groups == null) {
      log('No groups found');
      return [];
    }
    return groups;
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
                return Text("Something Went Wrong");
              }
              mySessions = [];
              for (Map<String, dynamic> session in snapshot.requireData) {
                SessionsModel object = SessionsModel.fromJson(session);
                for (var usr in object.users) {
                  if (usr['id'] == FirebaseAuth.instance.currentUser!.uid) {
                    mySessions.add(object);
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
            (index) => GestureDetector(
              onTap: () {
                Get.toNamed(
                  '/group-page',
                  arguments: sessionsIdList[index],
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 12,
                ),
                height: TSizes.displayHeight(context) * 0.12,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularCachedNetworkimage(
                        url: sessionsIdList[index].icon,
                        width: TSizes.displayWidth(context) * 0.2,
                      ),
                    ),
                    SizedBox(
                      width: TSizes.displayWidth(context) * 0.04,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sessionsIdList[index].title.capitalizeFirst ?? "",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "${THelperFunctions.getDateDifference(sessionsIdList[index].timestamp)}",
                        ),
                        // Text("₹ ${snapshot.requireData.}")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
