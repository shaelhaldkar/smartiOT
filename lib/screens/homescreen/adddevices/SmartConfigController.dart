import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SmartConfigController extends GetxController {

  RxBool isProvisioning = false.obs;

  final TextEditingController ssidCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  Future<void> startProvisioning(
      String ssid,
      String password,
      ) async {

    try {

      isProvisioning.value = true;

      final payload = {
        "Type": 1,
        "SSID": ssid,
        "PWS": password
      };

      final url =
          "http://192.168.10.1/data?name=${Uri.encodeComponent(jsonEncode(payload))}";

      print("Sending request: $url");

      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 20));

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      isProvisioning.value = false;


    } catch (e) {

      print("Provisioning error: $e");

      isProvisioning.value = false;

    }
  }

  @override
  void onInit() {

    super.onInit();

    ssidCtrl.text = "TechAdwik_2.5g";
    passwordCtrl.text = "Tech@2020@";

  }

  @override
  void onClose() {

    ssidCtrl.dispose();
    passwordCtrl.dispose();

    super.onClose();

  }
}