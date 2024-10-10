import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paysa/main.dart';
import 'package:paysa/new/Models/user_data.dart';
import 'package:paysa/new/api/firestore_apis.dart';
import 'package:paysa/new/api/flutter_secure_storage_api.dart';
import 'package:paysa/utils/constants/global_values.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class AuthController extends GetxController {
  getCategories() async {
    bool exists = await FlutterSecureStorageAPI.contains('categories');
    if (exists) {
      log("Reading Data ...", name: 'categories');

      GlobalValues.categories =
          await FlutterSecureStorageAPI.readMap('categories') ?? {};
      log(GlobalValues.categories.toString(), name: 'categories');
      return;
    }

    Map<String, dynamic> categoriesData = await FirestoreAPIs.getCategories();
    if (categoriesData['isSuccess']) {
      log("Writing data...", name: 'categories');
      FlutterSecureStorageAPI.writeMap('categories', categoriesData);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCategories();
  }

  RxBool isLoading = false.obs;
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      bool userExists = await FirestoreAPIs.userExists(googleUser!.email);

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

      bool isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (!isEmailVerified) {
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        FirebaseAuth.instance.signOut();
        THelperFunctions.showErrorMessageGet(
            title: 'Email Verification',
            message: 'Please verify your email to continue');
        return;
      }
      if (!userExists) {
        FirestoreAPIs.createUser(
          UserData(
            uid: FirebaseAuth.instance.currentUser!.uid,
            name: FirebaseAuth.instance.currentUser!.displayName!,
            email: FirebaseAuth.instance.currentUser!.email!,
            photoUrl: FirebaseAuth.instance.currentUser!.photoURL ?? '',
            googleAuth: true,
          ),
        );
      }

      // log(credential.toString(), name: 'credential-');
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return;
    }

    isLoading.value = false;
  }

  Future<void> signInWithEmailPassword(
      {required String email, required String password}) async {
    // try {
    isLoading.value = true;

    bool isGoogleAuth = await FirestoreAPIs.isGoogleAuth(email);
    log(isGoogleAuth.toString(), name: 'Google Auth');
    if (isGoogleAuth) {
      log('This email is registered with Google Auth', name: 'Google Auth');
      THelperFunctions.showErrorMessageGet(
          title: 'Sign In With Google',
          message: 'This email is registered with Google Auth');
      return;
    }

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
    // } catch (e) {
    //   THelperFunctions.showErrorMessageGet(
    //       title: 'Sign In Error', message: e.toString());
    //   log(e.toString(), name: 'Error');
    //   return;
    // }
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
      FirestoreAPIs.createUser(
        UserData(
          uid: user.uid,
          name: user.displayName!,
          email: user.email!,
          photoUrl: user.photoURL ?? '',
          googleAuth: false,
        ),
      );
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
}
