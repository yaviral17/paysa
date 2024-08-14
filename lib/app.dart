import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Views/NavigationMenu.dart';
import 'package:paysa/Views/onboarding.dart';
import 'package:paysa/main.dart';
import 'package:paysa/new/Controllers/auth_controller.dart';
import 'package:paysa/new/Views/auth/auth_view.dart';
import 'package:paysa/new/Views/dashboard/navigation_view.dart';
import 'package:paysa/routes.dart';
import 'package:paysa/utils/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    Get.put(AuthController());
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Paysa',
      // dark only theme
      darkTheme: TFlexTheme.darkTheme,
      theme: TFlexTheme.lightTheme,
      themeMode: ThemeMode.system,

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const NavigationView();
          }
          return const AuthView();
        },
      ),
    );
  }
}
