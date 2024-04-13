import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/ProfileController.dart';
import 'package:paysa/Controllers/UserData.dart';
import 'package:paysa/Models/menuTileModel.dart';
import 'package:paysa/Views/Profile/Widgets/customMenuTile.dart';
import 'package:paysa/utils/appbar/appbar.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserData user = Get.find();

  @override
  Widget build(BuildContext context) {
    // THelperFunctions.hideBottomBlackStrip();
    return Scaffold(
      appBar: TAppBar(
        title: Text('Profile'),
        showBackArrow: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              margin: EdgeInsets.all(20),
              width: TSizes.displayWidth(context),
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: TColors.light.withOpacity(0.5),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(user.user.value!.photoURL!),
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.user.value!.displayName!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            user.user.value!.email!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: TSizes.xl,
            ),
            MenuOptionsTile(
              tileText: "My Profile",
              icon: Iconsax.user_edit,
              bgColor: TColors.primary.withOpacity(0.1),
              onTap: () {},
            ),
            MenuOptionsTile(
              tileText: "Change Password",
              icon: Iconsax.password_check,
              bgColor: TColors.primary.withOpacity(0.1),
              onTap: () {},
            ),
            MenuOptionsTile(
              tileText: "Privacy Policy",
              icon: Iconsax.security_card,
              bgColor: TColors.primary.withOpacity(0.1),
              onTap: () {},
            ),
            Spacer(),
            MenuOptionsTile(
              tileText: "Log Out",
              icon: Iconsax.logout,
              bgColor: TColors.error.withOpacity(0.1),
              onTap: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text("Log Out"),
                        content: Text("Are you sure you want to log out?"),
                        actions: [
                          CupertinoDialogAction(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text("Log Out"),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              GoogleSignIn().signOut();
                              Get.offAllNamed('/login');
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
            const SizedBox(
              height: TSizes.xl,
            ),
          ],
        ),
      ),
    );
  }
}
