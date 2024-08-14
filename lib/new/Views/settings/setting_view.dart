import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paysa/main.dart';
import 'package:paysa/new/Controllers/auth_controller.dart';
import 'package:paysa/new/Views/settings/widget/option_card.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Text('Settings',
                    style: TextStyle(
                      color: TColors.textWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: FirebaseAuth.instance.currentUser?.photoURL != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            FirebaseAuth.instance.currentUser!.photoURL!),
                      )
                    : CircleAvatar(
                        radius: 50,
                        child: Text(
                          FirebaseAuth.instance.currentUser?.displayName?[0] ??
                              'J',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Account Settings'),
              SizedBox(
                height: 10,
              ),
              SettingsOptionCard(
                onTap: () {},
                text: 'Name',
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.darkTextField,
                suffixWidget: Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? 'John Doe',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SettingsOptionCard(
                text: 'Email',
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.darkTextField,
                suffixWidget: Text(
                  FirebaseAuth.instance.currentUser?.email ??
                      'johan.example.com',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SettingsOptionCard(
                text: 'Change Password',
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.darkTextField,
                suffixWidget: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('App Settings'),
              SizedBox(
                height: 10,
              ),
              SettingsOptionCard(
                text: 'Currency',
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.darkTextField,
                suffixWidget: Text(
                  'INR',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SettingsOptionCard(
                text: 'Reminder notification',
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.darkTextField,
                suffixWidget: Text(
                  'Off',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SettingsOptionCard(
                text: 'Log out',
                textColor: Colors.red,
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.error.withOpacity(0.2),
                suffixWidget: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (ctx) {
                        return CupertinoAlertDialog(
                          title: Text("Log Out"),
                          content: Text("Are you sure you want to log out?"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text("Log Out"),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                GoogleSignIn().signOut();
                                //pops correctly to the first screen and disappears from the stack
                                navigatorKey.currentState!.pop();
                              },
                            ),
                          ],
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
