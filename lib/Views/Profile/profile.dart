import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paysa/Controllers/ProfileController.dart';
import 'package:paysa/Controllers/UserData.dart';
import 'package:paysa/Models/menuTileModel.dart';
import 'package:paysa/Views/Profile/Widgets/customMenuTile.dart';
import 'package:paysa/utils/appbar/appbar.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserData user = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              margin: EdgeInsets.all(20),
              width: TSizes.displayWidth(context),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
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
            ...List.generate(
              4,
              (index) => MenuOptionsTile(
                //change the number of tiles
                tileText: MenuTileData.menuTiles[index].title,
                icon: MenuTileData.menuTiles[index].icon,
                onTap: MenuTileData.menuTiles[index].onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
