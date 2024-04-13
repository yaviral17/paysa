import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:paysa/Controllers/LoginController.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_login23.jpg'),
            opacity: 0.1,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Sign In to Paysa!",
                // "Lets start \n and\n get going!",

                style: TextStyle(
                  fontSize: 32,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: TColors.textWhite.withOpacity(0.9),
                ),
              ),
            ),

            //add lottie animation here
            SizedBox(
              height: 400,
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Lottie.asset(
                    'assets/lottie/Cat2.json',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            // Spacer(),

            Divider(
              color: TColors.textWhite.withOpacity(0.8),
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: Text(
                  'What do you think would be the best way to sign in?\nOf course, Google!',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: TColors.textWhite.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          await loginController.signInWithGoogle();
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          height: TSizes.appBarHeight,
          width: (TSizes.buttonWidth * 3) - 20,
          decoration: BoxDecoration(
            color: TColors.primaryBackground.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: TColors.primaryBackground.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: loginController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                          color: TColors.primaryBackground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image(
                        image: AssetImage('assets/images/google.png'),
                        height: 20,
                        width: 20,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
