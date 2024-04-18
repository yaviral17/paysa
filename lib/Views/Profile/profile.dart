import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:url_launcher/url_launcher.dart';

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
                          Flexible(
                            child: SizedBox(
                              width: TSizes.displayWidth(context) * 0.5,
                              child: Text(
                                user.user.value!.displayName!,
                                // "sagvdgasvfgvafgvasfvajhfasjhfvasjh",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Flexible(
                            child: SizedBox(
                              width: TSizes.displayWidth(context) * 0.5,
                              child: Text(
                                user.user.value!.email!,
                                // "sagvdgasvfgvafgvasfvajhfasjhfvasjh",

                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
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
              onTap: () {
                Get.toNamed('/privacy-policy');
              },
            ),
            // Spacer(),
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

            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Developed with ❤:",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontStyle: FontStyle.normal),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String url = "https://www.linkedin.com/in/yaviral17/";
                          var urllaunchable = await canLaunchUrl(Uri.parse(
                              url)); //canLaunch is from url_launcher package
                          if (urllaunchable) {
                            await launchUrl(Uri.parse(
                                url)); //launch is from url_launcher package to launch URL
                          } else {
                            print("URL can't be launched.");
                          }
                        },
                        child: Text(
                          "@yaviral17  |",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: TColors.primary),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          String url =
                              "https://www.linkedin.com/in/nikhil-singh-168ab7246";
                          var urllaunchable = await canLaunchUrl(Uri.parse(
                              url)); //canLaunch is from url_launcher package
                          if (urllaunchable) {
                            await launchUrl(Uri.parse(
                                url)); //launch is from url_launcher package to launch URL
                          } else {
                            print("URL can't be launched.");
                          }
                        },
                        child: Text(
                          "  @nikhil",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: TColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "App Version : v1.0.1",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontStyle: FontStyle.normal,
                          fontSize: TSizes.displayWidth(context) * 0.025,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
