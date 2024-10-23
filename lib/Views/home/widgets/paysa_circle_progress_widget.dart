import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:paysa/Utils/theme/colors.dart';

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
    return SizedBox(
      width: size,
      height: size,
      child: DashedCircularProgressBar.aspectRatio(
        aspectRatio: 1, // width ÷ height
        valueNotifier: ValueNotifier(value),
        progress: value,
        maxProgress: targetValue,
        corners: StrokeCap.butt,
        foregroundColor: PColors.primary(context),
        backgroundColor: PColors.primary(context).withOpacity(0.2),
        foregroundStrokeWidth: foregroundStrokeWidth,
        backgroundStrokeWidth: backgroundStrokeWidth,
        seekColor: PColors.primary(context),

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
