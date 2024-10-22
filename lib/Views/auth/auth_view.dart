import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.primary(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // logo image and heading text with description
              authHeader(context),

              // login and sign up buttons
              Center(child: authButtons(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget authButtons(
    BuildContext context,
  ) {
    return Column(
      children: [
        PaysaPrimaryButton(
          width: PSize.rh(context, 10) * 0.88,
          height: PSize.rw(context, 10) * 0.06,
          onTap: () {},
          prefixWidget: Icon(
            Icons.alternate_email,
            color: PColors.primary(context),
          ),
          text: 'Authenticate with Email',
          fontSize: PSize.rh(context, 10) * 0.05,
        ),
        SizedBox(
          height: PSize.rw(context, 10) * 0.01,
        ),
        PaysaPrimaryButton(
          width: PSize.rh(context, 10) * 0.88,
          height: PSize.rw(context, 10) * 0.06,
          onTap: () async {},
          color: PColors.primary(context),
          textColor: PColors.primary(context),
          prefixWidget: Image.asset(
            'assets/images/google.png',
            width: PSize.rh(context, 10) * 0.05,
          ),
          text: 'Authenticate with Google',
          fontSize: PSize.rh(context, 10) * 0.05,
        ),
        SizedBox(
          height: PSize.rw(context, 10) * 0.01,
        ),
      ],
    );
  }

  Widget authHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: PSize.rw(context, 10) * 0.04,
        ),
        Center(
          child: Image.network(
            'https://framerusercontent.com/images/lduGwGeZiKwSs8YHOIWtXi7PnE.png',
            width: PSize.rh(context, 10) * 0.4,
          ),
        ),
        SizedBox(
          height: PSize.rw(context, 10) * 0.04,
        ),
        Text(
          'Welcome\nto Paysa 👋',
          style: TextStyle(
            fontSize: PSize.rh(context, 10) * 0.1,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 20),
        Text(
          'Manage your expenses with ease. 💸\nBecause who doesn\'t love knowing where all their money went? 🤔💰',
          style: TextStyle(
            fontSize: PSize.rh(context, 10) * 0.047,
            fontFamily: 'OpenSans',
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
