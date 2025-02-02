import 'package:flutter/material.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:smooth_corner/smooth_corner.dart';

class OptionButtons extends StatelessWidget {
  final IconData icon;
  final String title;
  const OptionButtons({
    required this.icon,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmoothClipRRect(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.green.withOpacity(0.3), width: 1),
          smoothness: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: PSize.arw(context, 10),
                vertical: PSize.arw(context, 10)),
            child: Icon(icon, size: PSize.arw(context, 35)),
          ),
        ),
        SizedBox(
          height: PSize.arw(context, 5),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: PSize.arw(context, 18),
          ),
        ),
      ],
    );
  }
}
