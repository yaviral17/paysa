import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:smooth_corner/smooth_corner.dart';

class PaysaPrimaryButton extends StatelessWidget {
  final Color color;
  final String text;
  final void Function()? onTap;
  final double width;
  final double height;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double borderRadius;
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  final String fontFamily;

  const PaysaPrimaryButton({
    super.key,
    this.color = TColors.primary,
    this.text = "",
    this.onTap,
    this.width = double.infinity,
    this.height = 54,
    this.fontSize = 16.0,
    this.borderRadius = 12.0,
    this.textColor = TColors.textWhite,
    this.fontWeight = FontWeight.bold,
    this.fontFamily = 'OpenSans',
    this.prefixWidget,
    this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothClipRRect(
      borderRadius: BorderRadius.circular(18),
      smoothness: 0.8,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                prefixWidget ?? Container(),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
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
