import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/route.dart';
import 'package:paysa/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Paysa',
      theme: PAppTheme.lightTheme,
      darkTheme: PAppTheme.darkTheme,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      themeMode: ThemeMode.system,
    );
  }
}
