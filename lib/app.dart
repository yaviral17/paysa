import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Views/Dashboard/dashboard_view.dart';
import 'package:paysa/Views/auth/auth_view.dart';
import 'package:paysa/route.dart';
import 'package:paysa/utils/theme/theme.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Paysa',
      theme: PAppTheme.lightTheme,
      navigatorKey: navigatorKey,
      darkTheme: PAppTheme.darkTheme,
      navigatorObservers: [routeObserver],
      initialRoute: '/',
      // builder: (context, child) {
      //   if (FirebaseAuth.instance.currentUser != null) {
      //     return const DashMenuView();
      //   }
      //   return const AuthView();
      // },
      onGenerateRoute: RouteGenerator.generateRoute,
      themeMode: ThemeMode.system,
    );
  }
}
