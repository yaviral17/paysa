import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Utils/constants/hero_tags.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
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
            PNavigate.back(context);
          },
        ),
      ),
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
                    height: PSize.arh(context, 4),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: PSize.arw(context, 14),
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
                    height: PSize.arh(context, 14),
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
                            fontSize: PSize.arw(context, 14),
                            color: PColors.primaryText(context),
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: PSize.arh(context, 12),
                  ),
                  Center(
                    child: PaysaPrimaryButton(
                      isLoading: true,
                      text: 'Login',
                      onTap: () {},
                      width: PSize.displayWidth(context),
                      height: PSize.arh(context, 54),
                      textColor: PColors.primaryText(context),
                      fontSize: PSize.arw(context, 16),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Don\'t have an account? Register',
                    style: TextStyle(
                      fontSize: PSize.rw(context, 14),
                      color: PColors.primaryText(context),
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: PSize.rh(context, 12),
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

        // focusColor: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
