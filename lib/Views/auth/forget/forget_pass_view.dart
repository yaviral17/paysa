import 'dart:developer';

import 'package:clean_captcha/clean_captcha.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paysa/Utils/constants/hero_tags.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/login/login_view.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';

class ForgetPassView extends StatefulWidget {
  const ForgetPassView({super.key});

  @override
  State<ForgetPassView> createState() => _ForgetPassViewState();
}

class _ForgetPassViewState extends State<ForgetPassView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController captchaController = TextEditingController();

  void onResetPasswordClicked({required CaptchaController captchaController}) {
    if (emailController.text.isEmpty) {
      PHelper.showErrorMessageGet(
          title: "Email missing 😕", message: "Please enter your email");
      log('Email missing 😕');
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      PHelper.showErrorMessageGet(
          title: "Invalid Email 😕", message: "Please enter a valid email");
      return;
    }

    // bottom sheet
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(),
      builder: (context) {
        return CaptchaBottomSheetWidget(
          onTap: () {
            FirebaseAuth.instance.sendPasswordResetEmail(
              email: emailController.text,
            );
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CaptchaController _captchaController =
        CaptchaController(length: 6, textStyle: [
      TextStyle(
        fontSize: 24,
        color: PColors.background(context),
      ),
      TextStyle(
        fontSize: 24,
        color: PColors.background(context),
      ),
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PColors.background(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: PColors.primaryText(context),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginView(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                height: PSize.arw(context, 20),
              ),
              Text(
                'Forget Password',
                style: TextStyle(
                  fontSize: PSize.arw(context, 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: PSize.arw(context, 20),
              ),
              Text(
                'Enter your email to reset your password, you will receive an email with instructions on how to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  color: PColors.secondaryText(context),
                ),
              ),
              SizedBox(
                height: PSize.arw(context, 20),
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
                height: PSize.arw(context, 20),
              ),
              PaysaPrimaryButton(
                onTap: () => onResetPasswordClicked(
                    captchaController: _captchaController),
                text: "Reset Password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CaptchaBottomSheetWidget extends StatefulWidget {
  final Function? onTap;

  const CaptchaBottomSheetWidget({super.key, this.onTap});

  @override
  State<CaptchaBottomSheetWidget> createState() =>
      _CaptchaBottomSheetWidgetState();
}

class _CaptchaBottomSheetWidgetState extends State<CaptchaBottomSheetWidget> {
  final CaptchaController controller = CaptchaController(length: 6);
  TextEditingController captchaController = TextEditingController();

  void validateCaptcha() {
    log(controller.value);
    if (captchaController.text.trim().isEmpty) {
      PHelper.showErrorMessageGet(
        title: "Captcha missing 😕",
        message: "Please enter the text in the captcha",
      );
      return;
    }
    if (controller.value.toLowerCase() !=
        captchaController.text.toLowerCase()) {
      PHelper.showErrorMessageGet(
        title: "Invalid Captcha 😕",
        message: "Please enter the correct captcha",
      );
      return;
    }

    PHelper.showSuccessMessageGet(
        title: "Email Sent 😊",
        message: "Captcha verification success, Email sent !");
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(PSize.arw(context, 20)),
          width: PSize.displayWidth(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please enter the captcha',
                style: TextStyle(
                  fontSize: PSize.arw(context, 20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: PSize.arw(context, 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                      decoration: BoxDecoration(
                        color: PColors.background(context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Captcha(controller: controller),
                    ),
                  ),
                  SizedBox(
                    width: PSize.arw(context, 20),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      controller.changeCaptcha();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: PSize.arw(context, 20),
              ),
              Text(
                'Enter the text shown in the image above, it is not case sensitive so you can enter in any case.',
                style: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  color: PColors.error,
                ),
              ),
              SizedBox(
                height: PSize.arw(context, 20),
              ),
              PaysaPrimaryTextField(
                controller: captchaController,
                hintText: "Enter Captcha",
                maxLength: 6,
                fillColor: PColors.primaryText(context),
                prefixIcon: Icon(
                  Icons.text_format_sharp,
                  color: PColors.primaryText(context),
                ),
              ),
              SizedBox(
                height: PSize.arw(context, 20),
              ),
              PaysaPrimaryButton(
                onTap: validateCaptcha,
                text: "Done",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
