import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Utils/constants/hero_tags.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/forget/forget_pass_view.dart';
import 'package:paysa/Views/auth/signup/sign_up_view.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthenticationController authController =
      Get.find<AuthenticationController>();

  void login() {
    FocusScope.of(Get.context!).unfocus();
    // check if the email is empty
    if (emailController.text.trim().isEmpty) {
      log('Email is empty');
      PHelper.showErrorMessageGet(
        title: "Email is empty",
        message: "Please enter your email address",
      );
      return;
    }
    // check if email is valid
    if (!GetUtils.isEmail(emailController.text.trim())) {
      log('Invalid Email');
      PHelper.showErrorMessageGet(
        title: "Invalid Email",
        message: "Please enter a valid email address",
      );
      return;
    }

    // check if the password is less than 8 characters
    // if (passwordController.text.length < 8) {
    //   PHelper.showErrorMessageGet(
    //     title: "Password is too short",
    //     message: "Password must be at least 6 characters",
    //   );
    //   return;
    // }

    // call the login function from the controller
    authController.loginWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text,
    );
  }

  RxBool isVisibility = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PColors.background(context),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_2,
            color: PColors.primaryText(context),
          ),
          onPressed: () {
            PNavigate.back();
          },
        ),
      ),
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: PSize.rh(context, 36),
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
                      height: PSize.arh(context, 24),
                    ),
                    Text(
                      'Let\'s get started! 🚀',
                      style: TextStyle(
                        fontSize: PSize.arw(context, 24),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FittedBox(
                      child: Text(
                        'Paysa helps you track your expenses effortlessly.💸\nStay on top of your spending and save more!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: PSize.rw(context, 16),
                          color: PColors.secondaryText(context),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: PSize.rh(context, 12),
                ),
                // Add your login form fields here
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
                      child: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: PSize.rw(context, 14),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    PaysaPrimaryTextField(
                      controller: emailController,
                      hintText: "Email",
                      fillColor: PColors.primaryText(context),
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: PColors.primaryText(context),
                      ),
                    ),
                    SizedBox(
                      height: PSize.arh(context, 4),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 14),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    Obx(
                      () => PaysaPrimaryTextField(
                        controller: passwordController,
                        hintText: "Password",
                        // isPassword: true,
                        // onObsecure: () =>
                        //     isVisibility.value = !isVisibility.value,
                        fillColor: PColors.primaryText(context),
                        prefixIcon: Icon(
                          Iconsax.lock,
                          color: PColors.primaryText(context),
                        ),
                        // obscureText: isVisibility.value,
                      ),
                    ),
                    SizedBox(
                      height: PSize.arh(context, 14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            PNavigate.to(ForgetPassView());
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: PSize.arw(context, 14),
                              color: PColors.primaryText(context),
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: PSize.arh(context, 12),
                    ),
                    Center(
                      child: Obx(
                        () => PaysaPrimaryButton(
                          // isLoading: true,
                          text: 'Login',
                          isLoading: authController.isLoading.value,
                          onTap: () => login(),
                          width: PSize.displayWidth(context),
                          height: PSize.arh(context, 54),
                          textColor: PColors.primaryText(context),
                          fontSize: PSize.arw(context, 16),
                        ),
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      PNavigate.to(SignUpView());
                    },
                    child: Text(
                      'Don\'t have an account? Register',
                      style: TextStyle(
                        fontSize: PSize.rw(context, 14),
                        color: PColors.primaryText(context),
                      ),
                    ),
                  ),
                ),
                Align(
                  child: SizedBox(
                    height: PSize.rh(context, 12),
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

class PaysaPrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool isPassword;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final FilteringTextInputFormatter? inputFormatter;
  final FocusNode? focusNode;
  final void Function()? onObsecure;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;

  const PaysaPrimaryTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.isPassword = false,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    this.focusNode,
    this.onObsecure,
    this.maxLength,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      maxLength: maxLength,
      readOnly: readOnly,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
      onChanged: onChanged,
      onTap: onTap,
      maxLines: maxLength,
      minLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? GestureDetector(
                onTap: onObsecure,
                child: Icon(
                  !obscureText ? Iconsax.eye : Iconsax.eye_slash,
                ),
              )
            : suffixIcon,
        suffixIconColor: PColors.backgroundLight,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: PColors.secondaryText(context),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: PColors.secondaryText(context),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: PColors.secondaryText(context),
          ),
        ),
        prefixIcon: prefixIcon,
        fillColor: fillColor ?? PColors.secondaryText(context),
      ),
    );
  }
}
