// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paysa/main.dart';
import 'package:paysa/new/Controllers/auth_controller.dart';
import 'package:paysa/new/Controllers/settings_controller.dart';
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
  SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor:
          isDark ? TColors.darkBackground : TColors.lightBackground,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SafeArea(
                child: Text('Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    FirebaseAuth.instance.currentUser?.photoURL != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                FirebaseAuth.instance.currentUser!.photoURL!),
                          )
                        : CircleAvatar(
                            radius: 50,
                            child: Text(
                              FirebaseAuth
                                      .instance.currentUser?.displayName?[0] ??
                                  'J',
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    Positioned(
                      right: 0,
                      // left: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          settingsController.updateProfileInFirebase(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? TColors.black.withOpacity(0.8)
                                : TColors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(CupertinoIcons.pencil,
                              size: 20,
                              color: isDark ? TColors.white : TColors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Account Settings'),
              const SizedBox(
                height: 10,
              ),
              SettingsOptionCard(
                onTap: () {},
                text: 'Name',
                textColor: isDark ? TColors.white : TColors.black,
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: isDark ? TColors.darkTextField : TColors.lightTextField,
                suffixWidget: Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? 'John Doe',
                  style: TextStyle(
                    color: isDark ? Colors.grey : Colors.grey[700],
                    fontSize: 15,
                  ),
                ),
              ),
              SettingsOptionCard(
                text: 'Email',
                fontSize: 15,
                textColor: isDark ? TColors.white : TColors.black,
                height: MediaQuery.of(context).size.height * 0.08,
                color: isDark ? TColors.darkTextField : TColors.lightTextField,
                suffixWidget: Text(
                  FirebaseAuth.instance.currentUser?.email ??
                      'johan.example.com',
                  style: TextStyle(
                    color: isDark ? Colors.grey : Colors.grey[700],
                    fontSize: 15,
                  ),
                ),
              ),
              SettingsOptionCard(
                text: 'Change Password',
                fontSize: 15,
                textColor: isDark ? TColors.white : TColors.black,
                height: MediaQuery.of(context).size.height * 0.08,
                color: isDark ? TColors.darkTextField : TColors.lightTextField,
                suffixWidget: Icon(
                  Icons.arrow_forward_ios,
                  color: isDark ? Colors.grey : Colors.grey[700],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('App Settings'),
              const SizedBox(
                height: 10,
              ),
              SettingsOptionCard(
                text: 'Currency',
                fontSize: 15,
                textColor: isDark ? TColors.white : TColors.black,
                height: MediaQuery.of(context).size.height * 0.08,
                color: isDark ? TColors.darkTextField : TColors.lightTextField,
                suffixWidget: Text(
                  'INR',
                  style: TextStyle(
                    color: isDark ? Colors.grey : Colors.grey[700],
                    fontSize: 15,
                  ),
                ),
              ),
              SettingsOptionCard(
                text: 'Reminder notification',
                fontSize: 15,
                textColor: isDark ? TColors.white : TColors.black,
                height: MediaQuery.of(context).size.height * 0.08,
                color: isDark ? TColors.darkTextField : TColors.lightTextField,
                suffixWidget: Text(
                  'Off',
                  style: TextStyle(
                    color: isDark ? Colors.grey : Colors.grey[700],
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
                          title: const Text("Log Out"),
                          content:
                              const Text("Are you sure you want to log out?"),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text("Log Out"),
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
