import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/main.dart';
import 'package:paysa/new/Controllers/spending_controller.dart';
import 'package:paysa/new/Views/auth/widgets/paysa_primary_button.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

class SpendingNumpadView extends StatefulWidget {
  const SpendingNumpadView({super.key});

  @override
  State<SpendingNumpadView> createState() => _SpendingNumpadViewState();
}

class _SpendingNumpadViewState extends State<SpendingNumpadView> {
  final controller = Get.find<SpendingController>();

  void onBussonPress(String text, {bool clearAll = false}) {
    if (clearAll) {
      controller.amount.value = '';
      return;
    }
    if (text == '0' &&
        controller.amount.isNotEmpty &&
        double.parse(controller.amount.value) == 0) {
      return;
    }
    // ignore if dot is already present
    if (text == '.' && controller.amount.value.contains('.')) {
      return;
    }

    // ignore if 2 digits after dot
    if (controller.amount.value.contains('.') &&
        controller.amount.value.split('.')[1].length == 2 &&
        text != '⌫') {
      return;
    }

    if (text == '⌫') {
      if (controller.amount.value.isNotEmpty) {
        controller.amount.value = controller.amount.value.substring(
          0,
          controller.amount.value.length - 1,
        );
      }
      return;
    }
    controller.amount.value += text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            // amount text with currency sign and currency sign fontSize 24 and amount text is 32
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: FittedBox(
                  child: Text(
                    '\$${controller.amount}',
                    style: TextStyle(
                      color: TColors.white,
                      fontSize: TSizes.displayWidth(context) * 0.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: button_view(text: '1'),
                ),
                Expanded(
                  child: button_view(text: '2'),
                ),
                Expanded(
                  child: button_view(text: '3'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: button_view(text: '4'),
                ),
                Expanded(
                  child: button_view(text: '5'),
                ),
                Expanded(
                  child: button_view(text: '6'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: button_view(text: '7'),
                ),
                Expanded(
                  child: button_view(text: '8'),
                ),
                Expanded(
                  child: button_view(text: '9'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: button_view(text: '.'),
                ),
                Expanded(
                  child: button_view(text: '0'),
                ),
                Expanded(
                  child: button_view(text: '⌫'),
                ),
              ],
            ),
            SizedBox(
              height: TSizes.displayHeight(context) * 0.02,
            ),
            PaysaPrimaryButton(
              text: "Continue",
              onTap: () {
                log(controller.amount.value);
                navigatorKey.currentState!.pushNamed('/transaction');
              },
              width: TSizes.displayWidth(context) * 0.9,
            ),
            SizedBox(
              height: TSizes.displayHeight(context) * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  InkWell button_view({required String text}) {
    return InkWell(
      onTap: text.trim().isEmpty
          ? null
          : () {
              log(text);
              onBussonPress(text);
            },
      onLongPress: () {
        log(text);
        onBussonPress(text, clearAll: true);
      },
      splashColor: TColors.white.withOpacity(0.1),
      splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: TColors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: text == '⌫'
              ? Icon(
                  Icons.backspace_rounded,
                  color: TColors.white,
                  size: TSizes.displayWidth(context) * 0.08,
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: TSizes.displayWidth(context) * 0.08,
                    fontWeight: FontWeight.bold,
                    color: TColors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
