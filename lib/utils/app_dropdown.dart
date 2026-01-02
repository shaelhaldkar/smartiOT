import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool useGradient;
  final TextStyle? style;
  final Widget? suffixIcon;
  final InputDecoration? decoration;
  final Color? backgroundColor;
  final double? width;
  final InputBorder? defaultBorderDecoration;
  final InputBorder? focusedBorderDecoration;
  final InputBorder? disabledBorderDecoration;
  final InputBorder? enabledBorderDecoration;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsetsGeometry? margin;
  final Color? fillColor;
  final bool? filled;
  final EdgeInsets? contentPadding;
  final bool isBold;
  final double? height;
  final Color? dropdownColor;
  final Widget? icon;
  final bool isExpanded;
  final String? Function(T?)? onSaved;
  final AutovalidateMode autovalidateMode;
  final bool readonly;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final GestureTapCallback? onTap;
  final String? hint;
  final String? label;

  const AppDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.label,
    this.useGradient = false,
    this.hintText,
    this.labelText,
    this.errorText,
    this.style,
    this.hint,
    this.suffixIcon,
    this.decoration,
    this.backgroundColor = Colors.white,
    this.width,
    this.defaultBorderDecoration,
    this.focusedBorderDecoration,
    this.disabledBorderDecoration,
    this.enabledBorderDecoration,
    this.hintStyle,
    this.labelStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.margin,
    this.fillColor,
    this.filled,
    this.contentPadding,
    this.isBold = false,
    this.height,
    this.dropdownColor,
    this.icon,
    this.isExpanded = false,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.readonly = false,
    this.focusNode,
    this.textAlign,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final consistentBorder = defaultBorderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: App_colors.bg_grey),
        );

    final dropdownWidget = Container(
      width: width ?? MediaQuery.of(context).size.width,
      margin: margin ?? EdgeInsets.zero,
      constraints: BoxConstraints(minHeight: height ?? 56),
      child: DropdownButtonFormField<T>(
        onTap: onTap,
        value: value,
        items: items,
        onChanged: readonly ? null : onChanged,
        onSaved: onSaved,
        validator: validator,
        autovalidateMode: autovalidateMode,
        focusNode: focusNode,
        dropdownColor: dropdownColor ?? backgroundColor,
        icon: icon ??
            Icon(
              Icons.keyboard_arrow_down,
              color: App_colors.bg_grey,
            ),
        isExpanded: isExpanded,
        style: style ??
            TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
        decoration: _buildDecoration(context, consistentBorder),
      ),
    );

    /// ✅ GRADIENT HANDLING
    if (!useGradient) {
      return dropdownWidget;
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: dropdownWidget,
    );
  }

  InputDecoration _buildDecoration(
      BuildContext context, InputBorder consistentBorder) {
    return decoration ??
        InputDecoration(
          errorText: errorText,
          filled: filled ?? true,
          fillColor: fillColor ?? backgroundColor,
          constraints: BoxConstraints(minHeight: height ?? 56),

          /// Borders
          border: consistentBorder,
          enabledBorder: enabledBorderDecoration ?? consistentBorder,
          focusedBorder: focusedBorderDecoration ??
              consistentBorder.copyWith(
                borderSide:
                BorderSide(color: App_colors.bg_grey, width: 2),
              ),
          disabledBorder: disabledBorderDecoration ??
              consistentBorder.copyWith(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
          errorBorder: consistentBorder.copyWith(
            borderSide: BorderSide(color: Colors.red.shade400),
          ),
          focusedErrorBorder: consistentBorder.copyWith(
            borderSide: BorderSide(color: Colors.red.shade400, width: 2),
          ),

          /// Label & Hint
          labelText: labelText ?? label,
          labelStyle: labelStyle ??
              TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black54,
              ),
          hintText: hintText ?? hint,
          hintStyle: hintStyle ??
              TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.grey.shade600,
              ),

          /// Icons
          suffixIcon: suffixIcon ?? suffix,
          suffixIconConstraints: suffixConstraints,
          prefixIcon: prefix,
          prefixIconConstraints: prefixConstraints,

          /// Layout
          isDense: true,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

          errorStyle: const TextStyle(
            fontSize: 12,
            height: 1,
            color: Colors.red,
            fontFamily: 'Poppins',
          ),
          errorMaxLines: 1,
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        );
  }
}
