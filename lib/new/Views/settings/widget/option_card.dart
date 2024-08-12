import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SettingsOptionCard extends StatelessWidget {
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

  const SettingsOptionCard({
    super.key,
    this.color = TColors.darkTextField,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SmoothClipRRect(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      prefixWidget ?? Container(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ],
                  ),
                  suffixWidget ?? Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
