import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final String? fontFamily;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? height;
  final TextOverflow? overflow;
  final FontStyle? fontstyle;

  const AppText(
      this.text, {
        Key? key,
        this.fontSize,
        this.fontWeight,
        this.color,
        this.fontFamily,
        this.textAlign,
        this.maxLines,
        this.height,
        this.overflow,
        this.fontstyle
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.white,
        fontFamily: fontFamily ?? 'DMSans',
        fontStyle: fontstyle,
        height:height
      ),
    );
  }
}
