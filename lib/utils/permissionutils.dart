import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionUtils {
  /// Ensures location permission and GPS service are enabled.
  /// Returns `true` if everything is fine, otherwise `false`.
  static Future<bool> ensureLocationPermissionAndService() async {
    if (!Platform.isAndroid) return true;

    // 1️⃣ Check location permission
    var status = await Permission.location.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.location.request();
    }

    if (!status.isGranted) {
      _showDialog(
        title: "Permission Required",
        message:
        "Location permission is required to fetch Wi-Fi details. Please enable it in Settings.",
        openSettings: openAppSettings,
      );
      return false;
    }

    // 2️⃣ Check if location service (GPS) is ON
    final serviceEnabled = await Permission.location.serviceStatus.isEnabled;
    if (!serviceEnabled) {
      _showDialog(
        title: "Turn On Location",
        message:
        "Your location service (GPS) is turned off.\nPlease enable it to continue.",
        openSettings: _openLocationSettings,
      );
      return false;
    }

    return true;
  }

  /// Opens Android Location Settings
  static Future<void> _openLocationSettings() async {
    if (Platform.isAndroid) {
      final intent =  AndroidIntent(
        action: 'android.settings.LOCATION_SOURCE_SETTINGS',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      await intent.launch();
    }
  }

  /// Common dialog using GetX
  static void _showDialog({
    required String title,
    required String message,
    required VoidCallback openSettings,
  }) {
    if (Get.isDialogOpen == true) return;

    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      middleText: message,
      textConfirm: "Open Settings",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        openSettings();
      },
    );
  }

  void showCustomDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    if (Get.isDialogOpen == true) return;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),

              // Message
              Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                    ),
                    child: const Text("Cancel"),
                  ),

                  // Confirm Button
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Open Settings"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
