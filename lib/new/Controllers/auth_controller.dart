import 'dart:collection';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paysa/main.dart';
import 'package:paysa/new/Models/user_data.dart';
import 'package:paysa/new/api/firestore_apis.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
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
      log(credential.toString(), name: 'credential');

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        return value.user;
      });
      // log(credential.toString(), name: 'credential-');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return;
    }

    isLoading.value = false;
  }

  Future<void> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      isLoading.value = true;

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      bool emailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

      if (!emailVerified) {
        THelperFunctions.showErrorMessageGet(
            title: 'Email Verification',
            message: 'Please verify your email to continue');
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        FirebaseAuth.instance.signOut();
        return;
      }

      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        FirestoreAPIs.addDeviceToken(
            FirebaseAuth.instance.currentUser!.uid, token);
      }

      navigatorKey.currentState!.pop();
    } catch (e) {
      THelperFunctions.showErrorMessageGet(
          title: 'Sign In Error', message: e.toString());
      log(e.toString(), name: 'Error');
      return;
    }
    isLoading.value = false;
  }

  Future<void> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      User user = FirebaseAuth.instance.currentUser!;
      FirestoreAPIs.createUser(UserData(
        uid: user.uid,
        name: user.displayName!,
        email: user.email!,
        photoUrl: user.photoURL ?? '',
      ));
      FirebaseAuth.instance.currentUser!.sendEmailVerification();

      THelperFunctions.showSuccessMessageGet(
          title: 'Success', message: 'User created successfully');

      navigatorKey.currentState!.pop();
    } catch (e) {
      THelperFunctions.showErrorMessageGet(
          title: 'Error', message: e.toString());
      log(e.toString(), name: 'Error');
      return;
    }
    isLoading.value = false;
  }

  //
}
