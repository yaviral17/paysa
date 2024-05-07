import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Models/SessionsModel.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.session.title.capitalize!),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text('Members'),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.session.members.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(widget.session.members[index]),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text('Spending'),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: widget.session.spending.length,
                      //   itemBuilder: (context, index) {
                      //     return ListTile(
                      //       title: Text(widget.session.spending[index].title),
                      //       subtitle:
                      //           Text(widget.session.spending[index].amount),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
