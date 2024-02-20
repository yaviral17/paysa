import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
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
}
