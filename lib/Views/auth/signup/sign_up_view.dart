import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Utils/constants/hero_tags.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
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
                                PNavigate.back(context);
                              },
                              icon: const Icon(
                                Iconsax.arrow_left_2,
                              ),
                            ),
                            SizedBox(
                              height: PSize.rh(context, 10),
                            ),
                          ],
                        ),
                        Center(
                          child: Hero(
                            tag: PHeroTags.appLogo,
                            child: Image.asset(
                              'assets/images/dark_paysa.png',
                              width: PSize.arw(context, 140),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: PSize.rh(context, 10),
                        ),
                        Text(
                          'Let\'s get you Signed Up! 🚀',
                          style: TextStyle(
                            fontSize: PSize.rw(context, 24),
                            color: PColors.primaryText(context),
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: PSize.rh(context, 10),
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
                              fontSize: PSize.rw(context, 14),
                              color: PColors.primaryText(context),
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: nameController,
                          hintText: "John Doe",
                          fillColor: PColors.primaryText(context),
                          prefixIcon: Icon(
                            Icons.person,
                            color: PColors.primary(context),
                          ),
                        ),
                        SizedBox(
                          height: PSize.rh(context, 10),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: PSize.rw(context, 14),
                              color: PColors.primaryText(context),
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: emailController,
                          hintText: "john@doe.com",
                          fillColor: PColors.primary(context),
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: PColors.primary(context),
                          ),
                        ),
                        SizedBox(
                          height: PSize.rh(context, 10),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: PSize.rw(context, 14),
                              color: PColors.primaryText(context),
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: passwordController,
                          hintText: "*******",
                          fillColor: PColors.primary(context),
                          prefixIcon: Icon(
                            Iconsax.lock,
                            color: PColors.primary(context),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: PSize.rh(context, 10),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontSize: PSize.rw(context, 14),
                              color: PColors.primaryText(context),
                            ),
                          ),
                        ),
                        PaysaPrimaryTextField(
                          controller: confirmPasswordController,
                          hintText: "*******",
                          fillColor: PColors.primary(context),
                          prefixIcon: Icon(
                            Iconsax.lock,
                            color: PColors.primary(context),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: PSize.rh(context, 20),
                        ),
                        Center(
                          child: PaysaPrimaryButton(
                            text: 'Sign Up',
                            onTap: () {
                              // Add your sign-up logic here
                            },
                            width: PSize.displayWidth(context),
                            height: PSize.rh(context, 54),
                            textColor: PColors.primaryText(context),
                            fontSize: PSize.rw(context, 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      PNavigate.back(context);
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        fontSize: PSize.rw(context, 14),
                        color: PColors.primaryText(context),
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
