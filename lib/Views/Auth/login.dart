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
    return SafeArea(
      child: Scaffold(
        backgroundColor: TColors.primary,
        body: Container(
          decoration: BoxDecoration(
            // backgroundBlendMode: BlendMode.lighten,

            image: DecorationImage(
              image: AssetImage('assets/images/bg_login23.jpg'),
              opacity: 0.1,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 60),
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

              Column(
                children: [
                  Center(
                    child: Text(
                      "Lets in and get going!",
                      style: TextStyle(
                        fontSize: 32,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: TColors.black,
                      ),
                    ),
                  ),

                  // Sign In with google button

                  // GestureDetector(
                  //   onTap: () async {
                  //     await loginController.signInWithGoogle();
                  //   },
                  //   child: Container(
                  //     margin: const EdgeInsets.all(8),
                  //     height: TSizes.appBarHeight,
                  //     width: (TSizes.buttonWidth * 3) - 20,
                  //     decoration: BoxDecoration(
                  //       color: TColors.textWhite,
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: loginController.isLoading.value
                  //         ? const Center(
                  //             child: CircularProgressIndicator(),
                  //           )
                  //         : Padding(
                  //             padding: const EdgeInsets.all(12.0),
                  //             child: const Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Text(
                  //                   'Sign in with Google',
                  //                   style: TextStyle(
                  //                     color: TColors.textPrimary,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Image(
                  //                   image:
                  //                       AssetImage('assets/images/google.png'),
                  //                   height: 20,
                  //                   width: 20,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 40,
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
              color: TColors.textWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: loginController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: TColors.textPrimary,
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
      ),
    );
  }
}
