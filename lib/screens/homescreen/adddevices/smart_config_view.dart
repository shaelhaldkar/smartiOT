import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_device/utils/app_colors.dart';

import 'SmartConfigController.dart';

class SmartConfigScreen extends GetView<SmartConfigController> {

  const SmartConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("ESP SmartConfig"),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: App_colors.bg_white,

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              TextField(
                controller: controller.ssidCtrl,
                decoration: const InputDecoration(
                  labelText: "WiFi SSID",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: controller.passwordCtrl,
                decoration: const InputDecoration(
                  labelText: "WiFi Password",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

            /*  TextField(
                controller: controller.bssidCtrl,
                decoration: const InputDecoration(
                  labelText: "Router BSSID",
                  border: OutlineInputBorder(),
                ),
              ),
*/
              const SizedBox(height: 25),

              Obx(() {

                if (controller.isProvisioning.value) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: () {
                    controller.startProvisioning(
                      controller.ssidCtrl.text,
                      controller.passwordCtrl.text,
                    );
                  },
                  child: const Text("Start Provisioning"),
                );

              }),

              const SizedBox(height: 15),

             /* ElevatedButton(
                onPressed: controller.stopProvisioning,
                child: const Text("Stop Provisioning"),
              ),*/

            ],
          ),
        ),
      ),
    );
  }
}