import 'package:flutter/material.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      duration: const Duration(milliseconds: 300),
      height: PSize.arw(context, 10),
      width: isActive ? PSize.arw(context, 22) : PSize.arw(context, 10),
      decoration: BoxDecoration(
        color:
            isActive ? PColors.primaryLight : PColors.containerSecondaryLight,
        // border: Border.all(color: Colors.white, width: 1.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
