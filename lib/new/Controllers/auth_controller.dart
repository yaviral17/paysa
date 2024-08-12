import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class AuthController extends GetxController {
  Rx<UserCredential?> user = Rx<UserCredential?>(null);
  RxBool isLoading = false.obs;
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      // // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      log(credential.toString(), name: 'credential');

      // Once signed in, return the UserCredential
      user.value = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        return value;
      });
      log(credential.toString(), name: 'credential-');

      showCupertinoDialog(
        context: Get.context!,
        builder: (context) {
          return authWidget();
        },
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return;
    }

    isLoading.value = false;
    Get.toNamed('/dashboard');
  }
}

class authWidget extends StatelessWidget {
  authWidget({
    super.key,
  });

  TextEditingController nameController = TextEditingController(
    text: "Aviral Yadav",
    // text: FirebaseAuth.instance.currentUser!.displayName,
  );

  File? image = null;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      actions: [
        CupertinoDialogAction(
          child: const Text('OK'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
      title: const Text(
        'Verify your details',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: TSizes.displayHeight(context) * 0.01),
          Center(
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: TSizes.displayWidth(context) * 0.28,
              height: TSizes.displayWidth(context) * 0.28,
              decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius:
                    BorderRadius.circular(TSizes.displayWidth(context) * 0.2),
              ),
              // child: image == null
              //     ? (FirebaseAuth.instance.currentUser!.photoURL == null
              //         ? Icon(
              //             CupertinoIcons.person,
              //             size: TSizes.displayWidth(context) * 0.1,
              //           )
              //         : Image.network(
              //             FirebaseAuth.instance.currentUser!.photoURL!,
              //             fit: BoxFit.cover,
              //           ))
              //     : Image.file(
              //         image!,
              //         fit: BoxFit.cover,
              //       ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                image =
                    await THelperFunctions.pickImageWithCrop(context, false);
              },
              child: Text(
                'Change Profile Picture',
                style: TextStyle(
                  fontSize: TSizes.displayWidth(context) * 0.028,
                  color: CupertinoColors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: TSizes.displayHeight(context) * 0.01),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                color: CupertinoColors.white,
              ),
            ),
          ),
          SizedBox(height: TSizes.displayHeight(context) * 0.01),
          CupertinoTextField(
            controller: nameController,
            placeholder: 'Enter your name',
            style: const TextStyle(
              fontSize: 16,
              color: CupertinoColors.white,
            ),
          ),
        ],
      ),
      // actions: <CupertinoDialogAction>[
      //   CupertinoDialogAction(
      //     child: const Text('OK'),
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      // ],
    );
  }
}
