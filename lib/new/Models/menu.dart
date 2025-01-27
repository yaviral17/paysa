import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/colors.dart';

class Menu {
  String title;
  IconData icon;
  bool isActived;
  Color iconActiveColor;
  Color iconColor;

  Menu({
    required this.title,
    required this.icon,
    required this.isActived,
    required this.iconActiveColor,
    required this.iconColor,
  });
}

List<Menu> bottomNavItems = [
  Menu(
    title: 'Home',
    icon: Iconsax.home,
    isActived: true,
    iconActiveColor: PColors.primary,
    iconColor: PColors.black,
  ),
  Menu(
    title: 'Statistics',
    icon: Iconsax.graph,
    isActived: false,
    iconActiveColor: PColors.primary,
    iconColor: PColors.black,
  ),
  Menu(
    title: 'Settings',
    icon: Iconsax.setting_2,
    isActived: false,
    iconActiveColor: PColors.primary,
    iconColor: PColors.black,
  ),
];
