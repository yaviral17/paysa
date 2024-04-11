import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MenuTileData {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  MenuTileData({
    required this.title,
    required this.icon,
    this.onTap,
  });

  //pass the text and icon to the constructor
  static List<MenuTileData> menuTiles = [
    MenuTileData(
      title: 'My Profile',
      icon: Icons.person,
      onTap: () {
        //navigate to profile screen
      },
    ),
    MenuTileData(
      title: 'Change Password',
      icon: Icons.lock,
      onTap: () {
        //navigate to change password screen
      },
    ),
    MenuTileData(
      title: 'Privacy Policy',
      icon: Icons.privacy_tip,
      onTap: () {
        //navigate to privacy policy screen
      },
    ),
    MenuTileData(
      title: 'Logout',
      icon: Icons.logout_outlined,
      onTap: () async {
        //navigate to logout screen
        await FirebaseAuth.instance.signOut();
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
        googleUser?.clearAuthCache();
      },
    ),
  ];
}
