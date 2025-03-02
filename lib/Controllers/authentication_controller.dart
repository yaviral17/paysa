import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Views/Dashboard/dashboard_view.dart';
import 'package:paysa/Views/auth/auth_view.dart';

class AuthenticationController extends GetxController {
  final firebaseAuth = FirebaseAuth.instance;

  final Rx<UserModel?> user = Rx<UserModel?>(null);

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void loginWithEmailAndPassword(String email, String password) async {
    isLoading.value = true;
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!credential.user!.emailVerified) {
        log("Email not verified");
        PHelper.showErrorMessageGet(
          title: "Email not verified",
          message: "A verification email has been sent to your email address.",
        );

        await credential.user!.sendEmailVerification();
        FirebaseAuth.instance.signOut();
        isLoading.value = false;
        return;
      }

      if (credential.user != null) {
        user.value = await FirestoreAPIs.getUser();
      }

      PNavigate.to(const DashMenuView());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log("User not found");
        PHelper.showWarningMessageGet(
          title: "User not found",
          message: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        log("Wrong password");
        PHelper.showWarningMessageGet(
          title: "Wrong password",
          message: "Wrong password provided for that user.",
        );
      }
    } catch (e) {
      log(e.toString());
      PHelper.showErrorMessageGet(
        title: "Something went wrong",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void createAccountWithEmailAndPassword(
    String password,
    UserModel newUser,
  ) async {
    isLoading.value = true;
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: newUser.email!,
        password: password,
      );

      newUser.uid = credential.user!.uid;

      credential.user!.sendEmailVerification();

      if (credential.user != null) {
        user.value = newUser;
        await FirestoreAPIs.createUser(newUser);
      }

      PNavigate.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        PHelper.showWarningMessageGet(
          title: "Enter a strong password",
          message: "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        PHelper.showWarningMessageGet(
          title: "Email already in use",
          message: "The account already exists for that email.",
        );
      }
    } catch (e) {
      PHelper.showErrorMessageGet(
        title: "Something went wrong",
        message: e.toString(),
      );
    } finally {
      FirebaseAuth.instance.signOut();
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    UserModel? newUser;
    user.value = newUser;
    PNavigate.toAndRemoveUntil(const AuthView());
  }
}
