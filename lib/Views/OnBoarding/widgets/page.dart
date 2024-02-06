import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/onBoardingController.dart';
import 'package:paysa/Models/onBoardingPage.dart';

class OnboardingPageScreen extends StatefulWidget {
  const OnboardingPageScreen({super.key});

  @override
  State<OnboardingPageScreen> createState() => _OnboardingPageScreenState();
}

class _OnboardingPageScreenState extends State<OnboardingPageScreen> {
  onBoardingControllers _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Image.asset(
            OnboardingPageModel.getOnboardingPages()[
                    _controller.selectedPageIndex.value]
                .image,
            height: 300,
          ),
          const SizedBox(height: 20),
          Text(
            OnboardingPageModel.getOnboardingPages()[
                    _controller.selectedPageIndex.value]
                .title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
