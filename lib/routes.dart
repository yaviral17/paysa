import 'package:flutter/material.dart';
import 'package:paysa/Models/GroupModel.dart';
import 'package:paysa/Models/SessionsModel.dart';
import 'package:paysa/Views/AddSpending/AddSpending.dart';
import 'package:paysa/Views/CreateGroup/CreateGroupScreen.dart';
import 'package:paysa/Views/GroupPage/CreateSplitPage.dart';
import 'package:paysa/Views/GroupPage/GroupPage.dart';
import 'package:paysa/Views/NavigationMenu.dart';
import 'package:paysa/Views/Profile/Settings/changePassword.dart';
import 'package:paysa/Views/Profile/Settings/privacyPolicy.dart';
import 'package:paysa/Views/Profile/profileScreen.dart';
import 'package:paysa/new/Views/auth/auth_view.dart';
import 'package:paysa/new/Views/auth/login_view.dart';
import 'package:paysa/new/Views/auth/sign_up_view.dart';
import 'package:paysa/utils/appbar/appbar.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        {
          return MaterialPageRoute(builder: (_) => const AuthView());
        }
      case '/dashboard':
        {
          return MaterialPageRoute(builder: (_) => const NavigationMenu());
        }
      case '/profile':
        {
          return MaterialPageRoute(builder: (_) => const MyProfileScreen());
        }
      case '/login':
        {
          return MaterialPageRoute(builder: (_) => LoginView());
        }
      case '/register':
        {
          return MaterialPageRoute(builder: (_) => SignUpView());
        }
      case '/create-group':
        {
          return MaterialPageRoute(builder: (_) => const CreateGroupScreen());
        }

      case '/group-page':
        {
          SessionsModel session = settings.arguments as SessionsModel;
          return MaterialPageRoute(
              builder: (_) => GroupPageScreen(
                    session: session,
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
      case '/privacy-policy':
        {
          return MaterialPageRoute(builder: (_) => const PrivacyPolicy());
        }

      case '/change-password':
        {
          return MaterialPageRoute(
              builder: (_) => const ChangePasswordScreen());
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
