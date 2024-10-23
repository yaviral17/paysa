import 'package:flutter/material.dart';
import 'package:paysa/Utils/sizes.dart';

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
    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.pushNamed(context, '/auth');
    });
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
              tag: 'paysa_logo',
              child: Image.asset(
                'assets/images/dark_paysa.png',
                width: PSize.rw(context, 160),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
