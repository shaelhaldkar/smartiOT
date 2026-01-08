import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  RxString welcomeText = "welcome_home".obs;

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();

      Get.offAllNamed('/login_screen');
    } catch (e) {
      Get.snackbar("error".tr, "logout_failed".tr);
    }
  }
}
