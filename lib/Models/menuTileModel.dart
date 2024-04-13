import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paysa/Controllers/UserData.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/Views/Profile/profile.dart';

class MenuTileData {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  MenuTileData({
    required this.title,
    required this.icon,
    this.onTap,
  });
}
