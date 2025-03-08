import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Utils/constants/hero_tags.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/dashboard_view.dart';
import 'package:paysa/Views/auth/auth_view.dart';
import 'package:paysa/Views/auth/login/login_view.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';

class PostAuthView extends StatelessWidget {
  PostAuthView({super.key});
  TextEditingController totalBalanceController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  final AuthenticationController authController =
      Get.find<AuthenticationController>();
  RxBool isLoading = false.obs;

  void update() {
    FocusScope.of(Get.context!).unfocus();

    try {
      isLoading.value = true;
      authController.user.value!.balance =
          double.parse(totalBalanceController.text);
      authController.user.value!.username = userNameController.text;
      authController.user.value!.isOnboarded = true;
      UserModel userModel = authController.user.value!;
      FirestoreAPIs.updateUserData(userModel);
      PNavigate.to(DashMenuView());
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: PSize.rh(context, 36),
            ),
            Center(
              child: Hero(
                tag: PHeroTags.appLogo,
                child: Image.asset(
                  'assets/images/dark_paysa.png',
                  width: PSize.rw(context, 140),
                ),
              ),
            ),
            SizedBox(
              height: PSize.rh(context, 20),
            ),
            Center(
              child: Text(
                'One final step left to go🚀',
                style: TextStyle(
                  fontSize: PSize.arw(context, 24),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Paysa helps you track your expenses effortlessly.💸\nStay on top of your spending and save more!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: PSize.rw(context, 16),
                  color: PColors.secondaryText(context),
                ),
              ),
            ),
            SizedBox(
              height: PSize.rh(context, 20),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Text(
                'Total Balance',
                style: TextStyle(
                  fontSize: PSize.rw(context, 14),
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            PaysaPrimaryTextField(
              keyboardType: TextInputType.number,
              controller: totalBalanceController,
              hintText: 'Total Balance',
              fillColor: PColors.primaryText(context),
              prefixIcon: Icon(
                Iconsax.money,
                color: PColors.primaryText(context),
              ),
            ),
            SizedBox(
              height: PSize.arh(context, 4),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Text(
                'Username',
                style: TextStyle(
                  fontSize: PSize.rw(context, 14),
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            PaysaPrimaryTextField(
              controller: userNameController,
              hintText: 'Username',
              fillColor: PColors.primaryText(context),
              prefixIcon: Icon(
                Iconsax.user,
                color: PColors.primaryText(context),
              ),
            ),
            Spacer(),
            Obx(() => PaysaPrimaryButton(
                  text: 'Update',
                  isLoading: isLoading.value,
                  onTap: () => update(),
                  width: PSize.displayWidth(context),
                  height: PSize.arh(context, 54),
                  textColor: PColors.primaryText(context),
                  fontSize: PSize.arw(context, 16),
                )),
            SizedBox(
              height: PSize.arh(context, 8),
            ),
            Obx(() => PaysaPrimaryButton(
                  text: 'Logout',
                  isLoading: isLoading.value,
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    PNavigate.toAndReplace(AuthView());
                  },
                  color: PColors.error,
                  width: PSize.displayWidth(context),
                  height: PSize.arh(context, 54),
                  textColor: PColors.primaryText(context),
                  fontSize: PSize.arw(context, 16),
                ))
          ],
        ),
      )),
    );
  }
}
