import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/onBoardingController.dart';
import 'package:paysa/Models/onBoardingPage.dart';
import 'package:paysa/Views/OnBoarding/widgets/page.dart';
import 'package:paysa/utils/appbar/appbar.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  onBoardingControllers _controller = Get.put(onBoardingControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: _controller.selectedPageIndex.value > 0,
                child: FloatingActionButton(
                  backgroundColor: TColors.black,
                  onPressed: () {
                    _controller.backAction();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              _controller.isLastPage
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        // Get.offAllNamed(Routes.LOGIN);
                      },
                      label: Text('Get Started',
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: TColors.white,
                              fontWeight: FontWeight.bold)),
                    )
                  : FloatingActionButton(
                      onPressed: () {
                        _controller.forwardAction();
                      },
                      child:
                          const Icon(Icons.arrow_forward, color: TColors.white),
                    ),
            ],
          ),
        ),
      ),
      body: PageView.builder(
        controller: _controller.pageController,
        itemCount: OnboardingPageModel.getOnboardingPages().length,
        itemBuilder: (context, index) {
          return const OnboardingPageScreen();
        },
      ),
    );
  }
}
