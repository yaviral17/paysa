import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/route.dart';
import 'package:paysa/utils/theme/theme.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Paysa',
      theme: PAppTheme.lightTheme,
      darkTheme: PAppTheme.darkTheme,
      navigatorObservers: [routeObserver],
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      themeMode: ThemeMode.system,
    );
  }
}
