import 'package:flutter/material.dart';

import 'appText.dart';
import 'app_colors.dart';


class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? backgroundColor;
  final double borderRadius;
  final BorderSide? borderSide;
  final EdgeInsetsGeometry padding;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? elevation;
  final Color? shadowColor;

  const AppTextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.backgroundColor,
    this.borderRadius = 12,
    this.borderSide,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.elevation,
    this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        backgroundColor: backgroundColor ?? Colors.transparent,
        foregroundColor: textColor ?? App_colors.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: borderSide ?? BorderSide.none,
        ),
        shadowColor: shadowColor ?? Colors.transparent,
        elevation: elevation ?? 0,
      ),
      child: AppText(
        text,
        color: textColor ?? App_colors.light,
        fontFamily: fontFamily ?? "Poppins",
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w600,
        textAlign: textAlign ?? TextAlign.center,
        overflow: overflow,
        maxLines: maxLines,
      ),
    );
  }
}
