import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paysa/Models/GroupModel.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key, required this.group});
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(group.icon),
              ),
              SizedBox(
                width: 20,
              ),
              Text(group.name),
            ],
          ),
        ),
        body: Column(
          children: [
            Text("These Are the memebers of the group ${group.name}"),
            ...List.generate(group.members.length,
                (index) => Chip(label: Text(group.members[index]))),
            Text("These Are the admins of the group ${group.name}"),
          ],
        ));
  }
}
