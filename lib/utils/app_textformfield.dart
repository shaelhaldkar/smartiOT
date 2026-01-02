import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? prefixText;
  final String? labelText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? style;
  final Widget? suffixIcon;
  final InputDecoration? decoration;
  final String? errorText;
  final bool useGradient;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final void Function()? onTap;

  final Widget? Function(
      BuildContext context, {
      required int currentLength,
      required int? maxLength,
      required bool isFocused,
      })? buildCounter;

  final String? counterText;

  AppTextField({
    Key? key,
 this.controller,
    required this.hintText,
    this.labelText,
    this.prefixText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.inputFormatters,
    this.style,
    this.suffixIcon,
    this.decoration,
    this.buildCounter,
    this.initialValue,
    this.onChanged,
    this.errorText,
    this.counterText,
    this.useGradient = false,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.onTap,
  }) : super(key: key);
 /* @override
  Widget build(BuildContext context) {
    final textField = TextFormField(
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLength: maxLength,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      onTap: onTap,
      readOnly: readOnly,
      enableInteractiveSelection: enableInteractiveSelection,
      buildCounter: buildCounter ??
          (maxLength != null
              ? (context,
              {required currentLength,
                required isFocused,
                required maxLength}) =>
          null
              : null),
      style: style ??
          const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 16,
          ),

      decoration: decoration ??
          InputDecoration(
            filled: true,
            fillColor: Colors.transparent, // 🔥 ALWAYS transparent
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: App_colors.gradient_bg_green),
            ),
            prefixText: prefixText,
            prefixStyle: const TextStyle(
              color: App_colors.textColorWhite,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.white70,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
            suffixIcon: suffixIcon,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

            // ❌ REMOVE errorText from here
          ),
    );

    return
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: useGradient
              ? BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                App_colors.gradient_bg_black,
                App_colors.gradient_bg_grey,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          )
              : null,
          child: textField,
        ),

        /// ✅ Error rendered OUTSIDE gradient
        if (errorText != null && errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 6),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
          ),
      ],
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    Widget textFieldWidget = TextFormField(

      initialValue: initialValue,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLength: maxLength,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      onTap: onTap,                                  // ← Added
      readOnly: readOnly,                            // ← Added
      enableInteractiveSelection: enableInteractiveSelection, // ← Added
      buildCounter: buildCounter ??
          (maxLength != null
              ? (context,
              {required currentLength,
                required isFocused,
                required maxLength}) =>
          null
              : null),

      style: style ??
          const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 16,
          ),

      decoration: decoration ??

          InputDecoration(
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: App_colors.gradient_bg_green)),
            filled: true,
            fillColor: useGradient ? App_colors.gradient_bg_grey : Colors.transparent,
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
              //  color: Colors.yellowAccent,
              ),
            ),
            prefixText: prefixText,
            prefixStyle: const TextStyle(
              color: App_colors.textColorWhite,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.white70,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
            suffixIcon: suffixIcon,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
    );

    if (!useGradient) {
      return textFieldWidget;
    }

    return Container(
     decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [
            App_colors.gradient_bg_black,
            App_colors.gradient_bg_grey,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: textFieldWidget,
    );
  }


}
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}