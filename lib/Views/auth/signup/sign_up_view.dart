import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/login/login_view.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.background(context),
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
                                // navigatorKey.currentState!.pop();
                              },
                              icon: const Icon(
                                Iconsax.arrow_left_2,
                              ),
                            ),
                            SizedBox(
                              height: PSize.rh(context, 10) * 0.04,
                            ),
                          ],
                        ),
                        Center(
                          child: Image.network(
                            'https://framerusercontent.com/images/lduGwGeZiKwSs8YHOIWtXi7PnE.png',
                            width: PSize.rw(context, 10) * 0.4,
                          ),
                        ),
                        SizedBox(
                          height: PSize.rh(context, 10) * 0.04,
                        ),
                        Text(
                          'Join us! 🎉',
                          style: TextStyle(
                            fontSize: PSize.rw(context, 10) * 0.09,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Create an account to start tracking your expenses. 💸\nIt\'s quick and easy!',
                          style: TextStyle(
                            fontSize: PSize.rw(context, 10) * 0.044,
                            color: PColors.primaryText(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: PSize.rh(context, 10) * 0.04,
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
                              fontSize: PSize.rw(context, 10) * 0.04,
                              color: PColors.primaryText(context),
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: nameController,
                          hintText: "Name",
                          fillColor: PColors.primaryText(context),
                          prefixIcon: Icon(
                            Icons.person,
                            color: PColors.primary(context),
                          ),
                        ),
                        SizedBox(
                          height: PSize.rh(context, 10) * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: PSize.rw(context, 10) * 0.04,
                              color: PColors.primaryText(context),
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: emailController,
                          hintText: "Email",
                          fillColor: PColors.primary(context),
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: PColors.primary(context),
                          ),
                        ),
                        SizedBox(
                          height: PSize.rh(context, 10) * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: PSize.rw(context, 10) * 0.04,
                              color: PColors.primaryText(context),
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: passwordController,
                          hintText: "Password",
                          fillColor: PColors.primary(context),
                          prefixIcon: Icon(
                            Iconsax.lock,
                            color: PColors.primary(context),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: PSize.rh(context, 10) * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontSize: PSize.rw(context, 10) * 0.04,
                              color: PColors.primaryText(context),
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: confirmPasswordController,
                          hintText: "Confirm Password",
                          fillColor: PColors.primary(context),
                          prefixIcon: Icon(
                            Iconsax.lock,
                            color: PColors.primary(context),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: PSize.rh(context, 10) * 0.02,
                        ),
                        Center(
                          child: PaysaPrimaryButton(
                            text: 'Sign Up',
                            onTap: () {
                              // Add your sign-up logic here
                            },
                            width: PSize.rw(context, 10),
                            height: PSize.rh(context, 10) * 0.058,
                            textColor: PColors.primary(context),
                            fontSize: PSize.rw(context, 10) * 0.05,
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
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        fontSize: PSize.rw(context, 10) * 0.04,
                        color: PColors.primary(context),
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
