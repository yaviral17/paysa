import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PaysaNavbarIcon extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final String label;
  final bool isActive;
  const PaysaNavbarIcon({
    super.key,
    required this.icon,
    this.onPressed,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      begin: 1.0,
      end: 0.9,
      onTap: () {
        HapticFeedback.lightImpact();
        onPressed?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GlowIcon(
            icon,
            blurRadius: 10.0,
            glowColor: isActive
                ? PColors.bottomNavIconActive(context)
                : Colors.transparent,
            color: isActive
                ? PColors.bottomNavIconActive(context)
                : PColors.bottomNavIconInactive(context),
            size: PSize.arw(context, 27),
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? PColors.bottomNavIconActive(context)
                  : PColors.bottomNavIconInactive(context),
              fontSize: PSize.arw(context, 12),
            ),
          ),
        ],
      ),
    );
  }
}
