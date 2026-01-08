import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController countryController =
  TextEditingController(text: 'India');

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isChecked = false.obs;
  RxString selectedCountry = 'India'.obs;

  void openCountryPicker() {
    showCountryPicker(
      context: Get.context!,
      showPhoneCode: false,
      onSelect: (Country country) {
        selectedCountry.value = country.name;
        countryController.text = country.name;
      },
    );
  }

  //mail/password
  Future<void> emailPasswordLogin() async {
    if (!isChecked.value) {
      Get.snackbar("Error", "Please accept privacy policy");
      return;
    }

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar("Error", "Email and password required");
      return;
    }

    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Get.offAllNamed('/home_screen');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        Get.offAllNamed('/home_screen');
      } else {
        Get.snackbar("Error", e.message ?? "Login failed");
      }
    } finally {
      isLoading.value = false;
    }
  }

  //google
  Future<void> googleLogin() async {
    try {
      isLoading.value = true;

      final GoogleSignInAccount? googleUser =
      await _googleSignIn.signIn();

      if (googleUser == null) {
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      Get.offAllNamed('/home_screen');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    countryController.dispose();
    super.onClose();
  }
}
