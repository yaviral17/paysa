import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/device/device_utility.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? PColors.darkBackground : PColors.white,
      child: TabBar(
          isScrollable: true,
          indicatorColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: PColors.darkGrey,
          labelColor:
              dark ? PColors.white : Theme.of(context).colorScheme.primary,
          tabs: tabs),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
