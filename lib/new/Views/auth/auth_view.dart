import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/LoginController.dart';
import 'package:paysa/main.dart';
import 'package:paysa/new/Controllers/auth_controller.dart';
import 'package:paysa/new/Views/auth/login_view.dart';
import 'package:paysa/new/Views/auth/widgets/paysa_primary_button.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    final AuthController controller = Get.find();
    return Scaffold(
      backgroundColor:
          isDark ? TColors.darkBackground : TColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // logo image and heading text with description
              authHeader(context),

              // login and sign up buttons
              Center(child: authButtons(context, controller)),
            ],
          ),
        ),
      ),
    );
  }

  Widget authButtons(BuildContext context, AuthController controller) {
    return Column(
      children: [
        PaysaPrimaryButton(
          width: TSizes.displayWidth(context) * 0.88,
          height: TSizes.displayHeight(context) * 0.06,
          onTap: () {
            navigatorKey.currentState!.pushNamed('/login');
          },
          prefixWidget: const Icon(
            Icons.alternate_email,
            color: TColors.textWhite,
          ),
          text: 'Authenticate with Email',
          fontSize: TSizes.displayWidth(context) * 0.05,
        ),
        SizedBox(
          height: TSizes.displayHeight(context) * 0.01,
        ),
        PaysaPrimaryButton(
          width: TSizes.displayWidth(context) * 0.88,
          height: TSizes.displayHeight(context) * 0.06,
          onTap: () async {
            await controller.signInWithGoogle();
          },
          color: TColors.white,
          textColor: TColors.black,
          prefixWidget: Image.asset(
            'assets/images/google.png',
            width: TSizes.displayWidth(context) * 0.05,
          ),
          text: 'Authenticate with Google',
          fontSize: TSizes.displayWidth(context) * 0.05,
        ),
        SizedBox(
          height: TSizes.displayHeight(context) * 0.01,
        ),
      ],
    );
  }

  Widget authHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: TSizes.displayHeight(context) * 0.04,
        ),
        Center(
          child: Image.network(
            'https://framerusercontent.com/images/lduGwGeZiKwSs8YHOIWtXi7PnE.png',
            width: TSizes.displayWidth(context) * 0.4,
          ),
        ),
        SizedBox(
          height: TSizes.displayHeight(context) * 0.04,
        ),
        Text(
          'Welcome\nto Paysa 👋',
          style: TextStyle(
            fontSize: TSizes.displayWidth(context) * 0.1,
            fontWeight: FontWeight.bold,
            color: TColors.textWhite,
            fontFamily: 'OpenSans',
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 20),
        Text(
          'Manage your expenses with ease. 💸\nBecause who doesn\'t love knowing where all their money went? 🤔💰',
          style: TextStyle(
            fontSize: TSizes.displayWidth(context) * 0.047,
            color: TColors.textWhite.withOpacity(0.9),
            fontFamily: 'OpenSans',
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
