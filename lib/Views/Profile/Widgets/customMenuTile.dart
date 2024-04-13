import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

class MenuOptionsTile extends StatelessWidget {
  final String tileText;
  final IconData icon;
  final void Function()? onTap;
  final Color? bgColor;

  MenuOptionsTile({
    super.key,
    required this.tileText,
    required this.icon,
    this.onTap,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: TSizes.displayWidth(context),
        decoration: BoxDecoration(
          color: bgColor ?? bgColor!.withOpacity(0.1),
          // Theme.of(context).colorScheme.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tileText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              icon,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
