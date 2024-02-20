import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paysa/Controllers/ProfileController.dart';
import 'package:paysa/Controllers/UserData.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    user.user.value!.photoURL!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),

                // User Name
                Text('Name : ${user.user.value!.displayName}'),

                // User Email
                Text('Email : ${user.user.value!.email!}'),

                // User Phone Number
                Text('Phone Number : ${user.user.value!.phoneNumber}'),

                // User UID
                Text('UID : ${user.user.value!.uid}'),

                // Sign Out Button
                ElevatedButton(
                  onPressed: () async {
                    await user.signOut();
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
