import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/GroupModel.dart';

class GroupController extends GetxController {
  RxList<Group> groups = <Group>[
    Group(
      id: '1',
      name: 'Group 1',
      description: 'Group 1 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category1',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '2',
      name: 'Group 2',
      description: 'Group 2 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category2',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '3',
      name: 'Group 3',
      description: 'Group 3 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category3',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '4',
      name: 'Group 4',
      description: 'Group 1 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category1',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '5',
      name: 'Group 5',
      description: 'Group 2 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category2',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '6',
      name: 'Group 6',
      description: 'Group 3 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category3',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '1',
      name: 'Group 1',
      description: 'Group 1 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category1',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '2',
      name: 'Group 2',
      description: 'Group 2 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category2',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '3',
      name: 'Group 3',
      description: 'Group 3 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category3',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '4',
      name: 'Group 4',
      description: 'Group 1 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category1',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '5',
      name: 'Group 5',
      description: 'Group 2 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category2',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
    Group(
      id: '6',
      name: 'Group 6',
      description: 'Group 3 description',
      members: <String>['1', '2', '3'],
      admins: <String>['1'],
      category: 'category3',
      icon:
          'https://cdn.pixabay.com/photo/2023/07/25/18/42/vector-graphic-8149677_640.jpg',
      createdBy: '1',
    ),
  ].obs;

  TextEditingController searchController = TextEditingController();

  void getGroup() async {
    await FireStoreRef.getUserGroupList().then((value) {
      value.forEach((element) {
        FireStoreRef.groupCollection.doc(element).get().then((value) {
          groups.add(Group.fromJson(value.data()!));
        });
      });
    });

    log(groups.toString());
  }

  void deleteGroup(Group group, BuildContext context) async {
    //check if current user is owner of the group
    if (group.createdBy != FirebaseAuth.instance.currentUser!.uid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('You are not the owner of this group.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    //delete the group from user's group list
    for (String uid in group.members) {
      await FireStoreRef.removeGroupFromUser(group.id, uid);
    }

    FireStoreRef.groupCollection.doc(group.id).delete();
    log(FireStoreRef.groupCollection.doc('members').toString());
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Group Deleted'),
          content: const Text('The group has been deleted.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  //leave group
  void leaveGroup(Group group, BuildContext context) async {
    //check if current user is owner of the group
    if (group.createdBy == FirebaseAuth.instance.currentUser!.uid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'You are the owner of this group. You cannot leave the group.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    //delete the group from user's group list
    await FireStoreRef.removeGroupFromUser(
        group.id, FirebaseAuth.instance.currentUser!.uid);
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Group Left'),
          content: const Text('You have left the group.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
