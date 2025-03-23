import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Controllers/dashboard_controller.dart';
import 'package:paysa/Controllers/new_spending_controller.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Models/user_split_model.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/chat/chat_screen.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddMemebersView extends StatefulWidget {
  const AddMemebersView({
    super.key,
  });

  @override
  State<AddMemebersView> createState() => _AddMemebersViewState();
}

class _AddMemebersViewState extends State<AddMemebersView> {
  final newSpendingController = Get.find<NewSpendingController>();
  final DashboardController dashboardController =
      Get.find<DashboardController>();

  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  List<UserModel> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var user in newSpendingController.splitmembers) {
      if (user.user!.uid! == FirebaseAuth.instance.currentUser!.uid) {
        continue;
      }
      users.add(user.user!);
      setState(() {});
    }
  }

  void searchUser(String query) async {
    if (query.isEmpty) {
      newSpendingController.searchedUsers.clear();
      return;
    }
    log('Searching User: $query');

    List<UserModel> users =
        await FirestoreAPIs.getUsersByEmailOrUsername(query);

    log('Users: $users');
    newSpendingController.searchedUsers.clear();
    newSpendingController.searchedUsers.addAll(users);
  }

  void onDoneClicked() {
    newSpendingController.splitmembers.clear();
    double amount = double.parse(newSpendingController.amount.value);
    for (var user in users) {
      newSpendingController.splitmembers.add(
        UserSplitModel(
          amount: (amount / (users.length + 1)).toPrecision(2).toString(),
          user: user,
          createdAt: DateTime.now().toIso8601String(),
          isPaid: false,
          paidAt: null,
          token: user.token,
          uid: user.uid!,
        ),
      );
    }
    newSpendingController.splitmembers.add(
      UserSplitModel(
        amount: (amount / (users.length + 1)).toPrecision(2).toString(),
        user: dashboardController.user.value,
        createdAt: DateTime.now().toIso8601String(),
        isPaid: true,
        paidAt: null,
        token: dashboardController.user.value!.token,
        uid: dashboardController.user.value!.uid!,
      ),
    );

    PNavigate.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Members'),
        surfaceTintColor: PColors.background(context),
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchTextField(
                searchNode: searchNode,
                controller: searchController,
                hintText: 'Search user by username or email',
                onChanged: (value) {
                  if (value.isEmpty) {
                    newSpendingController.searchedUsers.clear();
                    return;
                  }
                  searchUser(value);
                },
              ),
              SizedBox(
                height: PSize.arh(context, 20),
              ),
              Visibility(
                visible: users.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Selected Members",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${users.length} Selected",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: PColors.primary(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: users.isNotEmpty,
                child: SizedBox(
                  height: PSize.arh(context, 12),
                ),
              ),
              Visibility(
                visible: users.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: List.generate(
                      users.length,
                      (index) {
                        UserModel user = users[index];
                        return ZoomTapAnimation(
                          onTap: () {
                            users.remove(user);
                            setState(() {});
                          },
                          end: 0.98,
                          beginCurve: Curves.fastEaseInToSlowEaseOut,
                          endCurve: Curves.easeOut,
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: PColors.containerSecondary(context),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                RandomAvatar(
                                  user.username!,
                                  width: PSize.arw(context, 60),
                                  height: PSize.arw(context, 60),
                                ),
                                SizedBox(
                                  height: PSize.arh(context, 4),
                                ),
                                Text('${user.firstname!} ${user.lastname!}'),
                                Container(
                                  width: PSize.arw(context, 70),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: PColors.error,
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: PColors.primaryText(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: users.isNotEmpty,
                child: SizedBox(
                  height: PSize.arh(context, 20),
                ),
              ),
              Visibility(
                visible: newSpendingController.searchedUsers.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Searched Members",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${newSpendingController.searchedUsers.length} Results",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: PColors.primary(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: newSpendingController.searchedUsers.isNotEmpty,
                child: SizedBox(
                  height: PSize.arh(context, 4),
                ),
              ),
              newSpendingController.searchedUsers.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'Search for users above with their\n username, email or name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: PColors.secondaryText(context),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: newSpendingController.searchedUsers.length,
                        itemBuilder: (context, index) {
                          UserModel user =
                              newSpendingController.searchedUsers[index];
                          return ListTile(
                            leading: RandomAvatar(
                              user.username!,
                              width: PSize.arw(context, 45),
                            ),
                            title: Text('${user.firstname!} ${user.lastname!}'),
                            subtitle: Text(user.email!),
                            onTap: () {
                              if (!users.contains(user)) {
                                users.add(user);
                                setState(() {});
                              }
                            },
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: PSize.arh(context, 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: PaysaPrimaryButton(
                  onTap: onDoneClicked,
                  text: 'Done',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
