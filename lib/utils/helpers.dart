
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_colors.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class Helpers {
  static const int charLimit25 = 25;
  static const int charLimit15 = 15;
  static const int charLimit50 = 50;
  static final RegExp regExpMobile = RegExp(r'^[6-9]\d*$');
  static final RegExp regEmailExp  = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static toast(String msg) {
    print('Helpers.toast $msg');
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: App_colors.bg_black,
        textColor: App_colors.textColorWhite,
        fontSize: 16.0);
  }
  static String checkIfUrlContainPrefixHttp(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    } else {
      return 'http://' + url;
    }
  }

  static Future<void> signout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Get.offAllNamed('/splash_screen');
  }
  static Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      String body = "Internet not connected, please connect to the internet";
      return false;
    }
    else {
      return true;
    }
  }
  static void showProgressLoader() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideProgressLoader() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

}