import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _pageIndex = 0;
  late PageController _pageController;
  bool _lastPage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...List.generate(
                  OnBoardData.onBoardData.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DotIndicator(
                      isActive: index == _pageIndex,
                    ),
                  ),
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: TColors.primaryBackground.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          width: 1.5,
                          color: TColors.primaryBackground.withOpacity(0.2),
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: TColors.textWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  _pageIndex = value;
                  if (_pageIndex == OnBoardData.onBoardData.length - 1) {
                    _lastPage = true;
                  } else {
                    _lastPage = false;
                  }
                });
              },
              itemCount: OnBoardData.onBoardData.length,
              controller: _pageController,
              itemBuilder: (context, index) => OnBoardContent(
                title: OnBoardData.onBoardData[index].title,
                description: OnBoardData.onBoardData[index].description,
                image: OnBoardData.onBoardData[index].image,
              ),
            ),
          ),

          // next and skip button here
          _lastPage
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            width: TSizes.displayWidth(context) * 0.4,
                            decoration: BoxDecoration(
                              color: TColors.primaryBackground.withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              border: Border.all(
                                width: 1.5,
                                color:
                                    TColors.primaryBackground.withOpacity(0.2),
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50.0),
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                    color: TColors.textWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            width: TSizes.displayWidth(context) * 0.4,
                            decoration: BoxDecoration(
                              color: TColors.primaryBackground.withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              border: Border.all(
                                width: 1.5,
                                color:
                                    TColors.primaryBackground.withOpacity(0.2),
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50.0),
                              onTap: () {
                                if (_pageIndex <
                                    OnBoardData.onBoardData.length - 1) {
                                  _pageIndex++;
                                } else {
                                  _pageIndex = 0;
                                }

                                _pageController.animateToPage(
                                  _pageIndex,
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    color: TColors.textWhite,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class OnBoardData {
  final String title;
  final String description;
  final String image;

  OnBoardData({
    required this.title,
    this.description = '',
    required this.image,
  });

  static List<OnBoardData> onBoardData = [
    OnBoardData(
      title: 'Paysa',
      description: ' A Smart Way to Manage Your Expenses',
      image: 'assets/lottie/WateringPlant.json',
    ),
    OnBoardData(
      title: ' Expense Tracker',
      description: 'All Your Expenses at One Place',
      image: 'assets/lottie/Anim1.json',
    ),
    OnBoardData(
      title: ' Split Bills',
      description: 'Split Bills with Friends',
      image: 'assets/lottie/Anim2.json',
    ),
  ];
}

class OnBoardContent extends StatelessWidget {
  OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  String image;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const Spacer(),
        const SizedBox(height: 50),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(child: Lottie.asset(image, fit: BoxFit.cover)),
        ),

        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? TColors.primary : Colors.white,
        border: Border.all(color: TColors.white, width: 1.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
