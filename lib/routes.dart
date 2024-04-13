import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/LoginController.dart';
import 'package:paysa/Controllers/ProfileController.dart';
import 'package:paysa/Controllers/UserData.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/Views/AddSpending/AddSpending.dart';
import 'package:paysa/Views/Auth/login.dart';
import 'package:paysa/Views/CreateGroup/CreateGroupScreen.dart';
import 'package:paysa/Views/GroupPage/CreateSplitPage.dart';
import 'package:paysa/Views/GroupPage/GroupPage.dart';
import 'package:paysa/Views/NavigationMenu.dart';
import 'package:paysa/Views/Profile/profileScreen.dart';
import 'package:paysa/Views/onboarding.dart';
import 'package:paysa/utils/appbar/appbar.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    UserData userData = Get.find();
    switch (settings.name) {
      case '/':
        {
          if (userData.user.value == null) {
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());
          } else {
            return MaterialPageRoute(builder: (_) => const NavigationMenu());
          }
        }
      case '/profile':
        {
          return MaterialPageRoute(builder: (_) => const MyProfileScreen());
        }
      case '/login':
        {
          return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      case '/create-group':
        {
          return MaterialPageRoute(builder: (_) => const CreateGroupScreen());
        }

      case '/group-page':
        {
          Group group = settings.arguments as Group;
          return MaterialPageRoute(
              builder: (_) => GroupPage(
                    group: group,
                  ));
        }

      case '/create-split':
        {
          Group group = settings.arguments as Group;

          return MaterialPageRoute(
              builder: (_) => CreateSplitScreen(
                    group: group,
                  ));
        }
      case '/add-spending':
        {
          AddDailySpendingScreen screen =
              settings.arguments as AddDailySpendingScreen;
          return MaterialPageRoute(builder: (_) => screen);
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Page not found',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        body: Center(
          child: Text(
            'Page does not exist',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
    });
  }
}
