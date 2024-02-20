import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paysa/firebase_options.dart';

class ProfileController extends GetxController {
  Rx<User?> user = Rx(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserData();
  }

  void getUserData() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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
