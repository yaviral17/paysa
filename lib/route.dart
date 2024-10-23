import 'package:flutter/material.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/auth_view.dart';
import 'package:paysa/Views/auth/login/login_view.dart';
import 'package:paysa/Views/auth/signup/sign_up_view.dart';
import 'package:paysa/Views/dashboard/navigation_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        {
          return MaterialPageRoute(builder: (_) => const AuthView());
        }
      case '/dashboard':
        {
          return MaterialPageRoute(builder: (_) => const NavigationView());
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

      //
      case '/spending-numpad':
        {
          return MaterialPageRoute(builder: (_) => const SpendingNumpadView());
        }

      case '/statistics':
        {
          return MaterialPageRoute(builder: (_) => const StatisticsView());
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Page not found',
            style: TextStyle(
              color: PColors.primary(context),
            ),
          ),
        ),
        body: Center(
          child: Text(
            'Page does not exist',
            style: TextStyle(
              color: PColors.primary(context),
            ),
          ),
        ),
      );
    });
  }
}
