import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/GroupScreenController.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:pull_down_button/pull_down_button.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  GroupController groupController = Get.put(GroupController());

  Future<List<Group>> getGroups() async {
    List<Group>? groups = await FireStoreRef.getUserGroupList();
    if (groups == null) {
      log('No groups found');
      return [];
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.toNamed('/create-group');
        },
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // search text field
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: TColors.primary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Iconsax.search_normal,
                              color: TColors.primary,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                color: TColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              StreamBuilder(
                  stream: FireStoreRef.getUserGroupListStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    Map<String, dynamic> data =
                        snapshot.requireData.data() ?? {};
                    // log("snapshot data: " + data.toString());
                    if (data['groups'] == null) {
                      return const Center(
                        child: Text('No groups found'),
                      );
                    }

                    groupController.groups.clear();
                    for (String groupId in data['groups']) {
                      FireStoreRef.getGroupByIdStream(groupId).listen((event) {
                        log("event data: " + event.data().toString());
                        if (event.data() != null) {
                          groupController.groups
                              .add(Group.fromJson(event.data()!));
                        }
                        // groupController.groups
                        //     .add(Group.fromJson(event.data()));
                      });
                      // groupController.groups.add(Group.fromJson(groupData));
                    }

                    return Obx(
                      () => GroupedListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        elements: groupController.groups.value,
                        groupBy: (element) => element.category,
                        groupSeparatorBuilder: (String category) => Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            category,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        itemBuilder: (context, Group element) {
                          return ListTile(
                            onTap: () {
                              Get.toNamed('/group-page', arguments: element);
                            },
                            title: Text(
                              element.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: TColors.primary,
                                  ),
                            ),
                            subtitle: Text(element.description),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(element.icon,
                                  scale: 1.0, headers: <String, String>{}),
                            ),
                            trailing: PullDownButton(
                              itemBuilder: (context) => [
                                PullDownMenuItem(
                                  icon: (Icons.supervised_user_circle),
                                  title: 'Share',
                                  onTap: () {},
                                ),
                                const PullDownMenuDivider(),
                                PullDownMenuItem(
                                  icon: (Icons.delete),
                                  title: 'delete',
                                  onTap: () {
                                    groupController.deleteGroup(
                                        element, context);
                                  },
                                ),
                                PullDownMenuItem(
                                  icon: (Icons.exit_to_app_rounded),
                                  title: 'leave',
                                  onTap: () {
                                    groupController.leaveGroup(
                                        element, context);
                                  },
                                ),
                              ],
                              buttonBuilder: (context, showMenu) => IconButton(
                                onPressed: showMenu,
                                // constraints: BoxConstraints(maxWidth: 100),
                                color: TColors.primary,
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.more_vert),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),

              // FutureBuilder(
              //   future: getGroups(),
              //   builder: (context, snapshot) {
              //     if (!snapshot.hasData) {
              //       return const CircularProgressIndicator();
              //     }
              //     return GroupedListView(
              //       shrinkWrap: true,
              //       physics: const NeverScrollableScrollPhysics(),
              //       elements: <Group>[
              //         ...List.from(snapshot.data as List<Group>),
              //       ],
              //       groupBy: (element) => element.category,
              //       groupSeparatorBuilder: (String category) => Container(
              //         margin: const EdgeInsets.only(
              //             top: 10, bottom: 10, left: 10, right: 10),
              //         padding: const EdgeInsets.all(8.0),
              //         decoration: BoxDecoration(
              //           color: TColors.primary.withOpacity(0.5),
              //           borderRadius: BorderRadius.circular(4),
              //         ),
              //         child: Text(
              //           category,
              //           textAlign: TextAlign.start,
              //           style:
              //               Theme.of(context).textTheme.headlineSmall!.copyWith(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //         ),
              //       ),
              //       itemBuilder: (context, Group element) {
              //         return ListTile(
              //           onTap: () {
              //             Get.toNamed('/group-page', arguments: element);
              //           },
              //           title: Text(
              //             element.name,
              //             style:
              //                 Theme.of(context).textTheme.titleMedium!.copyWith(
              //                       color: TColors.primary,
              //                     ),
              //           ),
              //           subtitle: Text(element.description),
              //           leading: CircleAvatar(
              //             radius: 30,
              //             backgroundImage: NetworkImage(element.icon,
              //                 scale: 1.0, headers: <String, String>{}),
              //           ),
              //           trailing: PullDownButton(
              //             itemBuilder: (context) => [
              //               PullDownMenuItem(
              //                 icon: (Icons.supervised_user_circle),
              //                 title: 'Share',
              //                 onTap: () {},
              //               ),
              //               const PullDownMenuDivider(),
              //               PullDownMenuItem(
              //                 icon: (Icons.delete),
              //                 title: 'delete',
              //                 onTap: () {
              //                   groupController.deleteGroup(element, context);
              //                 },
              //               ),
              //               PullDownMenuItem(
              //                 icon: (Icons.exit_to_app_rounded),
              //                 title: 'leave',
              //                 onTap: () {
              //                   groupController.leaveGroup(element, context);
              //                 },
              //               ),
              //             ],
              //             buttonBuilder: (context, showMenu) => IconButton(
              //               onPressed: showMenu,
              //               // constraints: BoxConstraints(maxWidth: 100),
              //               color: TColors.primary,
              //               padding: EdgeInsets.zero,
              //               icon: Icon(Icons.more_vert),
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
