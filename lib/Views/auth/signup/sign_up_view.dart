import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/Utils/constants/hero_tags.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/login/login_view.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final authController = Get.find<AuthenticationController>();

  // first name focus node
  final FocusNode firstNameFocusNode = FocusNode();
  // last name focus node
  final FocusNode lastNameFocusNode = FocusNode();

  void signup() async {
    FocusScope.of(Get.context!).unfocus();
    log('signup');
    // check if name is empty
    if (firstNameController.text.trim().isEmpty) {
      PHelper.showErrorMessageGet(
        title: "First name not provided",
        message: "Provide first name to continue !",
      );
      return;
    }
    if (lastNameController.text.trim().isEmpty) {
      PHelper.showErrorMessageGet(
        title: "Last name not provided",
        message: "Provide last name to continue !",
      );
      return;
    }
    if (emailController.text.trim().isEmpty) {
      PHelper.showErrorMessageGet(
        title: "Email is empty",
        message: "Please enter your email address",
      );
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      PHelper.showErrorMessageGet(
        title: "Invalid Email",
        message: "Please enter a valid email address",
      );
      return;
    }

    // check if the password is less than 8 characters
    if (passwordController.text.length < 8) {
      PHelper.showErrorMessageGet(
        title: "Password is too short",
        message: "Password must be at least 6 characters",
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      PHelper.showErrorMessageGet(
        title: "Confirm password mismatch",
        message: "Passwords do not match",
      );
      return;
    }

    // call the signup function
    authController.createAccountWithEmailAndPassword(
      passwordController.text,
      UserModel(
        email: emailController.text,
        firstname: firstNameController.text.trim(),
        lastname: lastNameController.text.trim(),
        authtype: AuthType.email,
        phone: "",
        profile: "",
        uid: "",
      ),
    );
  }

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
                                PNavigate.back();
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
                        Row(
                          children: [
                            Expanded(
                              child: PaysaPrimaryTextField(
                                focusNode: firstNameFocusNode,
                                onChanged: (value) {
                                  if (value.length != value.trim().length) {
                                    firstNameController.text = value.trim();
                                    lastNameFocusNode.requestFocus();
                                  }
                                },
                                controller: firstNameController,
                                hintText: "John",
                                fillColor: PColors.primaryText(context),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: PColors.primary(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: PSize.arw(
                                context,
                                12,
                              ),
                            ),
                            Expanded(
                              child: PaysaPrimaryTextField(
                                focusNode: lastNameFocusNode,
                                controller: lastNameController,
                                hintText: "Doe",
                                fillColor: PColors.primaryText(context),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: PColors.primary(context),
                                ),
                              ),
                            ),
                          ],
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
                          child: Obx(
                            () => PaysaPrimaryButton(
                              text: 'Sign Up',
                              onTap: () => signup(),
                              isLoading: authController.isLoading.value,
                              width: PSize.displayWidth(context),
                              height: PSize.rh(context, 54),
                              textColor: PColors.primaryText(context),
                              fontSize: PSize.rw(context, 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      PNavigate.back();
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
