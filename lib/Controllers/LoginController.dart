// ignore: file_names
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Controllers/UserData.dart';

class LoginController extends GetxController {
  UserData user = Get.find();
  RxBool isLoading = false.obs;
  Rx<UserCredential?> userCredential = Rx<UserCredential?>(null);
  // login with google
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      userCredential.value = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        return value;
      });
      user.user.value = userCredential.value!.user;
      FireStoreRef.uploadUser(user.user.value!);
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
      return;
    }

    isLoading.value = false;
    Get.toNamed('/dashboard');
  }
}
