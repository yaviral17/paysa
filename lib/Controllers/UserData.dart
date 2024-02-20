import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserData extends GetxController {
  Rx<User?> user = Rx(null);

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  void getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    user.value = auth.currentUser;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
    googleUser?.clearAuthCache();
    user.value = null;
    Get.offAllNamed('/');
  }
}
