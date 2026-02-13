import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/appText.dart';
import '../../utils/app_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_textformfield.dart';
import 'forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App_colors.login_bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back),
              ),

              const SizedBox(height: 20),

              AppText(
                "forget_password".tr,
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: App_colors.text_primary,
              ),

              const SizedBox(height: 10),

              AppText(
                "reset_email_info".tr,
                color: App_colors.text_color,
              ),

              const SizedBox(height: 24),

              AppTextField(
                controller: controller.emailController,
                hintText: "email_hint".tr,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: App_colors.text_color),
              ),

              const SizedBox(height: 30),

              Obx(
                    () => SizedBox(
                  width: double.infinity,
                  child: controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : AppButton(
                    text: "send_reset_link".tr,
                    backgroundColor: App_colors.primary_blue,
                    onPressed: () => controller.sendResetEmail(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
