import 'package:flutter/material.dart';

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
