import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paysa/Utils/constants/hero_tags.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/login/login_view.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  void goToLogin(BuildContext context) {
    PNavigate.to(context, LoginView());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        SystemNavigator.pop();
      },
      child: Scaffold(
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
      ),
    );
  }

  Widget authButtons(
    BuildContext context,
  ) {
    return Column(
      children: [
        PaysaPrimaryButton(
          width: PSize.displayWidth(context),
          height: PSize.rh(context, 54),
          onTap: () => goToLogin(context),
          prefixWidget: Icon(
            Icons.alternate_email,
            color: PColors.primaryTextLight,
            size: PSize.arw(context, 24),
          ),
          text: 'Authenticate with Email',
          fontSize: PSize.arw(context, 18),
        ),
        SizedBox(
          height: PSize.rh(context, 10),
        ),
        PaysaPrimaryButton(
          width: PSize.displayWidth(context),
          height: PSize.rh(context, 54),
          onTap: () async {},
          color: PColors.primaryTextDark,
          textColor: PColors.primaryTextLight,
          border: BorderSide(
            color: PColors.primaryText(context),
          ),
          prefixWidget: Image.asset(
            'assets/images/google.png',
            width: PSize.arw(context, 24),
          ),
          text: 'Authenticate with Google',
          fontSize: PSize.arw(context, 18),
        ),
        SizedBox(
          height: PSize.rh(context, 12),
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
          height: PSize.rh(context, 20),
        ),
        Center(
          child: Text(
            'Welcome to Paysa 👋',
            style: TextStyle(
              fontSize: PSize.arw(context, 36),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            'Manage your expenses with ease. 💸\nBecause who doesn\'t love knowing where all their money went? 🤔💰',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: PSize.arw(context, 18),
            ),
          ),
        ),
      ],
    );
  }
}
