import 'package:flutter/material.dart';
import 'package:paysa/Utils/constants/hero_tags.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Views/auth/auth_view.dart';

class PreAuthView extends StatefulWidget {
  const PreAuthView({super.key});

  @override
  State<PreAuthView> createState() => _PreAuthViewState();
}

class _PreAuthViewState extends State<PreAuthView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transitToAuthView(context);
  }

  transitToAuthView(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    PNavigate.to(const AuthView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: PHeroTags.appLogo,
              child: Image.asset(
                'assets/images/dark_paysa.png',
                width: PSize.rw(context, 140),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
