import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appText.dart';
import 'app_colors.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onTap;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onTap,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      AppBar(
      toolbarHeight:preferredSize.height ,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: App_colors.bg_black,
            border: Border.all(width: 1, color: Colors.grey),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 16,
          ),
        ),
      )
          : null,
      title: AppText(
        title.tr,
        fontWeight: FontWeight.w600,
        fontSize: 20,
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      flexibleSpace: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                App_colors.gradient_bg_black,
                App_colors.gradient_bg_grey,
              ],
              transform: GradientRotation(268.1 * 3.1415926535 / 180),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            border: Border(
              left: BorderSide(width: 1, color: App_colors.bg_broder_color),
              right: BorderSide(width: 1, color: App_colors.bg_broder_color),
              bottom: BorderSide(width: 1, color: App_colors.bg_broder_color),

            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+20);
}

