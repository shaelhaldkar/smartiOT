import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appText.dart';
import 'app_colors.dart';


showScaffoldError(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.redAccent,
    content: AppText(
      message,
      color: App_colors.bg_white,
    ),
  ));
}

showLoading({String text = "", bool isPreventBack = false}) {
  Get.dialog(
    Dialog(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: PopScope(
          canPop: !isPreventBack,
          child: UnconstrainedBox(
            child: Column(
              children: [
                UnconstrainedBox(child: CircularProgressIndicator()),
              ],
            ),
          ),
        )),
    barrierDismissible: kDebugMode,
  );
  return;
}

dismissLoadingWidget() {
  if (Get.isDialogOpen == true) {
    Get.back();
  }
}

showScaffoldSuccess(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: App_colors.gradient_bg_blue,
    content: AppText(message,
        color: Colors.white
    ),
  ));
}

