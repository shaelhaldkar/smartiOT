import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_device/utils/app_colors.dart';
import '../../utils/appText.dart';
import '../../utils/images.dart';
import 'home_screen_controller.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: AppText(
          "logout".tr,
          color: App_colors.text_primary,
          fontWeight: FontWeight.w600,
        ),
        content: AppText(
          "logout_confirm".tr,
          color: App_colors.text_primary,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: AppText(
              "cancel".tr,
              color: App_colors.text_primary,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.logout();
            },
            child: AppText(
              "logout".tr,
              color: App_colors.logout_red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: AppText(
              "welcome_home".tr,
              color: App_colors.bg_black,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: _showLogoutDialog,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: App_colors.primary_blue,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  Images.ic_logout,
                  height: 22,
                  width: 22,
                  color: App_colors.bg_white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
