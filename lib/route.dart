import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/dashboard_view.dart';
import 'package:paysa/Views/auth/auth_view.dart';
import 'package:paysa/Views/auth/login/login_view.dart';
import 'package:paysa/Views/auth/pre_auth_view.dart';
import 'package:paysa/Views/auth/signup/sign_up_view.dart';

import 'Views/Dashboard/home/profile/profile_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        {
          Widget view = FirebaseAuth.instance.currentUser != null
              ? const DashMenuView()
              : const PreAuthView();

          return MaterialPageRoute(builder: (_) => view);
        }
      case '/auth':
        {
          return MaterialPageRoute(builder: (_) => const AuthView());
        }

      case '/login':
        {
          return MaterialPageRoute(builder: (_) => LoginView());
        }
      case '/signup':
        {
          return MaterialPageRoute(builder: (_) => SignUpView());
        }
      case '/dashboard':
        {
          return MaterialPageRoute(builder: (_) => DashMenuView());
        }
      case '/profile':
        {
          return MaterialPageRoute(builder: (_) => ProfileView());
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
