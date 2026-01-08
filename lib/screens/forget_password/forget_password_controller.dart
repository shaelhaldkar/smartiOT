import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> sendResetEmail() async {
    if (emailController.text.isEmpty) {
      Get.snackbar("error".tr, "email_required".tr);
      return;
    }

    try {
      isLoading.value = true;

      await _auth.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      Get.snackbar("success".tr, "reset_email_sent".tr);
      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("error".tr, e.message ?? "something_went_wrong".tr);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
