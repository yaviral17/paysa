import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Views/NavigationMenu.dart';
import 'package:paysa/routes.dart';
import 'package:paysa/utils/constants/colors.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Paysa',
      // dark only theme
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: MaterialColor(
          TColors.primary.value,
          const {
            50: TColors.primary,
            100: TColors.primary,
            200: TColors.primary,
            300: TColors.primary,
            400: TColors.primary,
            500: TColors.primary,
            600: TColors.primary,
            700: TColors.primary,
            800: TColors.primary,
            900: TColors.primary,
          },
        ),
      ),
    );
  }
}
