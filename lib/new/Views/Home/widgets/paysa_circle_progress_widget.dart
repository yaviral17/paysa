import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class PaysaCircleProgressWidget extends StatelessWidget {
  final double size;
  final double value;
  final double targetValue;
  final double foregroundStrokeWidth;
  final double backgroundStrokeWidth;
  final Widget? child;
  final bool animation;
  final Duration animationDuration;

  const PaysaCircleProgressWidget({
    super.key,
    this.size = 100,
    this.targetValue = 100,
    this.value = 0,
    this.foregroundStrokeWidth = 12,
    this.backgroundStrokeWidth = 8,
    this.child,
    this.animation = true,
    this.animationDuration = const Duration(milliseconds: 1000),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return SizedBox(
      width: size,
      height: size,
      child: DashedCircularProgressBar.aspectRatio(
        aspectRatio: 1, // width ÷ height
        valueNotifier: ValueNotifier(value),
        progress: value,
        maxProgress: targetValue,
        corners: StrokeCap.butt,
        foregroundColor: TColors.primary,
        backgroundColor: isDark
            ? TColors.white.withOpacity(0.1)
            : TColors.black.withOpacity(0.1),
        foregroundStrokeWidth: foregroundStrokeWidth,
        backgroundStrokeWidth: backgroundStrokeWidth,
        seekColor: TColors.primary,

        circleCenterAlignment: Alignment.center,
        seekSize: 0,
        backgroundDashSize: 0,
        animation: animation,
        animationDuration: animationDuration,

        child: Center(child: child),
      ),
    );
  }
}
