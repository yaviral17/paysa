class OnboardingPageModel {
  String title;
  String description;
  String image;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.image,
  });

  static List<OnboardingPageModel> getOnboardingPages() {
    return <OnboardingPageModel>[
      OnboardingPageModel(
        title: 'Welcome to Paysa',
        description:
            'Paysa is a personal finance app that makes it easy to save money and track spending.',
        image: 'assets/images/onboarding1.png',
      ),
      OnboardingPageModel(
        title: 'Track your spending',
        description:
            'Paysa helps you track your spending and find areas where you can save money.',
        image: 'assets/images/onboarding2.png',
      ),
      OnboardingPageModel(
        title: 'Save money',
        description:
            'Paysa helps you save money by setting goals and tracking your progress.',
        image: 'assets/images/onboarding3.png',
      ),
    ];
  }
}
