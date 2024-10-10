import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/text_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: TSizes.figmaRatioWidth(context, 24),
              ),
              SizedBox(width: TSizes.figmaRatioWidth(context, 8)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, Aviral",
                    style: TTextStyles.secondaryHeading.copyWith(
                      fontSize: TSizes.figmaRatioWidth(context, 18),
                      color: TColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Welcome to Paysa ",
                    style: TextStyle(
                      fontSize: TSizes.figmaRatioWidth(context, 16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
