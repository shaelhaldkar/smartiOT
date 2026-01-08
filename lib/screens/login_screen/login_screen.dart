import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/appText.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_textformfield.dart';
import '../../utils/app_button.dart';
import '../../utils/images.dart';
import 'login_screen_controller.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App_colors.login_bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(height: 10),
                    AppText(
                      "login".tr,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: App_colors.text_primary,
                    ),
                    const SizedBox(height: 20),
                 //country picker
                    GestureDetector(
                      onTap: controller.openCountryPicker,
                      child: AbsorbPointer(
                        child: AppTextField(
                          controller: controller.countryController,
                          hintText: "",
                          style: const TextStyle(
                            color: App_colors.bg_black,
                            fontSize: 16,
                          ),
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: App_colors.bg_black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      hintText: "enter_account".tr,
                      style: const TextStyle(color: App_colors.text_color),
                      controller: controller.emailController,
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      hintText: "password".tr,
                      style: const TextStyle(color: App_colors.text_color),
                      controller: controller.passwordController,
                    ),
                    const SizedBox(height: 12),
                    Obx(
                          () => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: controller.isChecked.value,
                            onChanged: (v) => controller.isChecked.value =
                                v ?? false,
                          ),
                          Expanded(
                            child: AppText(
                              "agree_privacy_text".tr,
                              color: App_colors.text_color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: "login_btn".tr,
                        onPressed: () => controller.emailPasswordLogin(),
                        backgroundColor: App_colors.primary_blue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: () => Get.toNamed('/forget_password'),
                        child: AppText(
                          "forgot_password".tr,
                          color: App_colors.primary_blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap:
                    controller.googleLogin,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: App_colors.login_border,
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          Images.ic_google,
                          height: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
