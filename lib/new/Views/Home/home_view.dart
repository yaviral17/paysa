import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/main.dart';
import 'package:paysa/new/Controllers/spending_controller.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';
import 'package:smooth_corner/smooth_corner.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(SpendingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorKey.currentState!.pushNamed('/spending-numpad');
        },
        backgroundColor: TColors.bottomNavItemActive(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
