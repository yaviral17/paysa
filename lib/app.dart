import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/ProfileController.dart';
import 'package:paysa/Views/NavigationMenu.dart';
import 'package:paysa/Views/onboarding.dart';
import 'package:paysa/routes.dart';
import 'package:paysa/utils/constants/colors.dart';
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
    return GetMaterialApp(
      useInheritedMediaQuery: true,

      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Paysa',
      // dark only theme
      darkTheme: TFlexTheme.darkTheme,
      theme: TFlexTheme.lightTheme,
      themeMode: ThemeMode.dark,

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const NavigationMenu();
          }
          return const OnboardingScreen();
        },
      ),
    );
  }
}
