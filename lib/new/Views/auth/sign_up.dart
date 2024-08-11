import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/main.dart';
import 'package:paysa/new/Views/auth/login_view.dart';
import 'package:paysa/new/Views/auth/widgets/paysa_primary_button.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor:
          isDark ? TColors.darkBackground : TColors.lightBackground,
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                navigatorKey.currentState!.pop();
                              },
                              icon: const Icon(
                                Iconsax.arrow_left_2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: TSizes.displayHeight(context) * 0.04,
                            ),
                          ],
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
                          'Join us! 🎉',
                          style: TextStyle(
                            fontSize: TSizes.displayWidth(context) * 0.09,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Create an account to start tracking your expenses. 💸\nIt\'s quick and easy!',
                          style: TextStyle(
                            fontSize: TSizes.displayWidth(context) * 0.044,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: TSizes.displayHeight(context) * 0.04,
                    ),
                    // Add your sign-up form fields here
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: TSizes.displayWidth(context) * 0.04,
                              color: TColors.textWhite,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: nameController,
                          hintText: "Name",
                          fillColor: isDark
                              ? TColors.darkTextField
                              : TColors.lightTextField,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: TColors.textSecondary,
                          ),
                        ),
                        SizedBox(
                          height: TSizes.displayHeight(context) * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: TSizes.displayWidth(context) * 0.04,
                              color: TColors.textWhite,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: emailController,
                          hintText: "Email",
                          fillColor: isDark
                              ? TColors.darkTextField
                              : TColors.lightTextField,
                          prefixIcon: const Icon(
                            Icons.alternate_email,
                            color: TColors.textSecondary,
                          ),
                        ),
                        SizedBox(
                          height: TSizes.displayHeight(context) * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: TSizes.displayWidth(context) * 0.04,
                              color: TColors.textWhite,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: passwordController,
                          hintText: "Password",
                          fillColor: isDark
                              ? TColors.darkTextField
                              : TColors.lightTextField,
                          prefixIcon: const Icon(
                            Iconsax.lock,
                            color: TColors.textSecondary,
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: TSizes.displayHeight(context) * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontSize: TSizes.displayWidth(context) * 0.04,
                              color: TColors.textWhite,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: confirmPasswordController,
                          hintText: "Confirm Password",
                          fillColor: isDark
                              ? TColors.darkTextField
                              : TColors.lightTextField,
                          prefixIcon: const Icon(
                            Iconsax.lock,
                            color: TColors.textSecondary,
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: TSizes.displayHeight(context) * 0.01,
                        ),
                        Center(
                          child: PaysaPrimaryButton(
                            text: 'Sign Up',
                            onTap: () {},
                            width: TSizes.displayWidth(context),
                            height: TSizes.displayHeight(context) * 0.058,
                            textColor: TColors.textWhite,
                            fontSize: TSizes.displayWidth(context) * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigate to the login screen
                      navigatorKey.currentState!.pop();
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        fontSize: TSizes.displayWidth(context) * 0.04,
                        color: TColors.textWhite,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
