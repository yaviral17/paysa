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
  RxBool isLoading = false.obs;
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      // // Trigger the authentication flow
      // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // // Obtain the auth details from the request
      // final GoogleSignInAuthentication? googleAuth =
      //     await googleUser?.authentication;

      // // Create a new credential
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth?.accessToken,
      //   idToken: googleAuth?.idToken,
      // );
      // log(credential.toString(), name: 'credential');

      // // Once signed in, return the UserCredential
      // await FirebaseAuth.instance
      //     .signInWithCredential(credential)
      //     .then((value) {
      //   return value.user;
      // });
      // log(credential.toString(), name: 'credential-');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return;
    }

    isLoading.value = false;
  }
}
