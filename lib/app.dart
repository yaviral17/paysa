import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/ProfileController.dart';
import 'package:paysa/Views/NavigationMenu.dart';
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
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Paysa',
      // dark only theme
      darkTheme: TAppTheme.darkTheme,
      theme: TAppTheme.lightTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
