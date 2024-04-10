import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnBoardData> boardData = [
    OnBoardData(
      title: 'Welcome to Paysa',
      // description: 'Description 1',
      image: 'assets/images/onboarding1.png',
    ),
    OnBoardData(
      title: 'All Your Expenses at One Place',
      description: 'Description 2',
      image: 'assets/images/onboarding2.png',
    ),
    OnBoardData(
      title: 'Title 3',
      description: 'Description 3',
      image: 'assets/images/onboarding3.png',
    ),
  ];

  int _pageIndex = 0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(initialPage: _pageIndex);

    // _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
    //   if (_pageIndex < 3) {
    //     _pageIndex++;
    //   } else {
    //     _pageIndex = 0;
    //   }

    //   _pageController.animateToPage(
    //     _pageIndex,
    //     duration: const Duration(milliseconds: 1000),
    //     curve: Curves.easeIn,
    //   );
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  _pageIndex = value;
                });
              },
              itemCount: boardData.length,
              controller: _pageController,
              itemBuilder: (context, index) => OnBoardContent(
                title: boardData[index].title,
                description: boardData[index].description,
                image: boardData[index].image,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  boardData.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DotIndicator(
                      isActive: index == _pageIndex,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // next and skip button here
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: TColors.primaryBackground.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          width: 1.5,
                          color: TColors.primaryBackground.withOpacity(0.2),
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () {
                          if (_pageIndex < boardData.length - 1) {
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
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Next',
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Skip',
                  ),
                ),
              ],
            ),
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
      children: [
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
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
        Image.asset(image),
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
        border: isActive ? null : Border.all(color: TColors.primary),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
