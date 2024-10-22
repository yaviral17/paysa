import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';

import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Let\'s get started! 🚀',
                    style: TextStyle(
                      fontSize: PSize.rw(context, 10) * 0.09,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Paysa helps you track your expenses effortlessly. 💸\nStay on top of your spending and save more!',
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
                        fontSize: PSize.rw(context, 10) * 0.04,
                        fontFamily: 'OpenSans',
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
                    height: PSize.rh(context, 10) * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: PSize.rw(context, 10) * 0.04,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  PaysaPrimaryTextField(
                    controller: passwordController,
                    hintText: "Password",
                    fillColor: PColors.primaryText(context),
                    prefixIcon: Icon(
                      Iconsax.lock,
                      color: PColors.primaryText(context),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: PSize.rh(context, 10) * 0.004,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to the forgot password screen
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: PSize.rw(context, 10) * 0.04,
                            color: PColors.primaryText(context),
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: PSize.rh(context, 10) * 0.01,
                  ),
                  Center(
                    child: PaysaPrimaryButton(
                      text: 'Login',
                      onTap: () {},
                      width: PSize.rw(context, 10),
                      height: PSize.rh(context, 10) * 0.058,
                      textColor: PColors.primaryText(context),
                      fontSize: PSize.rw(context, 10) * 0.05,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to the register screen
                    // navigatorKey.currentState!.pushNamed('/register');
                  },
                  child: Text(
                    'Don\'t have an account? Register',
                    style: TextStyle(
                      fontSize: PSize.rw(context, 10) * 0.04,
                      color: PColors.primaryText(context),
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: PSize.rh(context, 10) * 0.02,
              ),
            ],
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
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final FilteringTextInputFormatter? inputFormatter;

  const PaysaPrimaryTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        prefixIcon: prefixIcon,
        fillColor: fillColor ?? PColors.primaryText(context),

        // focusColor: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
