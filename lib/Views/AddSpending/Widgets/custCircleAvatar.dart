import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(14),
            child: CircleAvatar(
              backgroundColor: TColors.primary,
              child: Image.asset(
                'assets/images/google.png',
                height: 20,
                width: 20,
              ),
            ),
          ),
          Text(
            'You',
            style: TextStyle(
              color: TColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }
}
