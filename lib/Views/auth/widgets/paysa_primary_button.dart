import 'package:flutter/material.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/utils/theme/colors.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PaysaPrimaryButton extends StatelessWidget {
  final Color color;
  final String text;
  final void Function()? onTap;
  final double width;
  final double height;
  final BorderSide? border;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double borderRadius;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool isLoading;
  final String fontFamily;
  final bool isDisabled;

  const PaysaPrimaryButton({
    super.key,
    this.color = PColors.primaryLight,
    this.text = "",
    this.onTap,
    this.width = double.infinity,
    this.height = 54,
    this.border,
    this.fontSize = 16.0,
    this.borderRadius = 18.0,
    this.textColor = PColors.primaryTextLight,
    this.fontWeight = FontWeight.bold,
    this.fontFamily = 'Inter',
    this.prefixWidget,
    this.suffixWidget,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: isDisabled
          ? null
          : () {
              if (!isLoading) {
                onTap?.call();
              }
            },
      end: 0.98,
      beginCurve: Curves.fastEaseInToSlowEaseOut,
      endCurve: Curves.easeOut,
      child: SmoothClipRRect(
        borderRadius: BorderRadius.circular(PSize.arh(context, borderRadius)),
        side: isDisabled
            ? BorderSide(
                color: PColors.containerSecondary(context),
                width: 2,
                strokeAlign: 0.5,
              )
            : border ?? BorderSide.none,
        smoothness: 0.8,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: isDisabled ? PColors.containerSecondary(context) : color,
          ),
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(
                    color: textColor,
                    strokeAlign: -3.2,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      prefixWidget ?? Container(),
                      Text(
                        text,
                        style: TextStyle(
                          color: isDisabled
                              ? PColors.secondaryTextDark
                              : textColor,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          fontFamily: fontFamily,
                        ),
                      ),
                      suffixWidget ?? Container(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
