import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/utils/constants/colors.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key, required this.group});
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(group.name),
              // Spacer(),
              SizedBox(
                width: 150,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(group.icon),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Column(
              children: [
                Row(children: [
                  const Text(
                    "Group Name ",
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(group.name, style: TextStyle(fontSize: 24)),
                ]),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.primaries[0],
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Due",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          "₹" + ["owes"].toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[400],
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Owes",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          "₹" + ["due"].toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: TColors.primary,
                  thickness: 2,
                ),
              ],
            ),
            // Text("These Are the memebers of the group ${group.name}"),
            // ...List.generate(group.members.length,
            //     (index) => Chip(label: Text(group.members[index]))),
            // Text("These Are the admins of the group ${group.name}"),
          ],
        ));
  }
}
