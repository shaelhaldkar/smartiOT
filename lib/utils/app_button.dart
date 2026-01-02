import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

enum AppButtonType { elevated, outlined }

class AppButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final AppButtonType type;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double borderRadius;
  final double? elevation;
  final Color? shadowColor;
  final BorderSide? borderSide;
  final TextOverflow? overflow;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final OutlinedBorder? shape;

  // Icon support
  final Widget? child;
  final Widget? icon;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double iconSpacing;
  final bool isIconButton;

  const AppButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.type = AppButtonType.elevated,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.borderRadius = 10,
    this.elevation,
    this.padding,
    this.shadowColor,
    this.borderSide,
    this.minimumSize,
    this.overflow,
    this.shape,
    this.maxLines,
    this.child,
    this.icon,
    this.leadingIcon,
    this.trailingIcon,
    this.iconSpacing = 8,
    this.isIconButton = false,
  })  : assert(text != null || child != null || icon != null || isIconButton,
  'Either text, child, icon or isIconButton must be provided'),
        super(key: key);

  // Convenience constructor for icon button
  const AppButton.icon({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.type = AppButtonType.elevated,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 12,
    this.elevation,
    this.padding = const EdgeInsets.all(12),
    this.shadowColor,
    this.borderSide,
    this.minimumSize = const Size(48, 48),
    this.shape,
    this.isIconButton = true,
    // Ignore text-related parameters for icon button
    this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.overflow,
    this.maxLines,
    this.child,
    this.leadingIcon,
    this.trailingIcon,
    this.iconSpacing = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final btnShape = shape ??
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));

    // Default padding based on button type
    final defaultPadding = padding ??
        (isIconButton
            ? const EdgeInsets.all(12)
            : const EdgeInsets.symmetric(horizontal: 24, vertical: 12));

    // Default minimum size based on button type
    final defaultMinimumSize = minimumSize ??
        (isIconButton
            ? const Size(48, 48)
            : (type == AppButtonType.elevated
            ? const Size(64, 36)
            : const Size(0, 0)));

    // Select button type
    switch (type) {
      case AppButtonType.outlined:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: defaultPadding,
            minimumSize: defaultMinimumSize,
            backgroundColor: backgroundColor ?? App_colors.btn_bg_green,
            foregroundColor: foregroundColor??Colors.white,
            side: borderSide ?? const BorderSide(color: App_colors.bg_grey),
            shape: btnShape,
          ),
          onPressed: onPressed,
          child: _buildChild(),
        );

      case AppButtonType.elevated:
      default:
        return
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: defaultPadding,
              minimumSize: defaultMinimumSize,
              backgroundColor: backgroundColor ?? App_colors.btn_bg_green,
              foregroundColor: foregroundColor ?? Colors.white,
              shadowColor:  Colors.greenAccent,
              elevation: 3,
              side: borderSide,
              shape: btnShape,
            ),
            onPressed: onPressed,
            child: _buildChild(),
          );
    }
  }

  Widget _buildChild() {
    // If custom child is provided, use it
    if (child != null) return child!;

    // For icon-only button
    if (isIconButton && icon != null) {
      return icon!;
    }

    // For text with icons
    final hasLeadingIcon = leadingIcon != null;
    final hasTrailingIcon = trailingIcon != null;
    final hasIcon = icon != null;

    // If only icon is provided without text, treat as icon button
    if (hasIcon && text == null) {
      return icon!;
    }

    // Build text widget
    final textWidget = text != null ? Text(
      text!,
      textAlign: TextAlign.center,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: textColor ?? (type == AppButtonType.outlined
            ? App_colors.bg_white
            : Colors.white),
        fontFamily: fontFamily ?? 'DMSans',
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    ) : const SizedBox.shrink();

    // If no icons, return just text
    if (!hasLeadingIcon && !hasTrailingIcon && !hasIcon) {
      return textWidget;
    }

    // Build row with icon and text
    List<Widget> children = [];

    if (hasLeadingIcon) {
      children.add(leadingIcon!);
      children.add(SizedBox(width: iconSpacing));
    } else if (hasIcon) {
      children.add(icon!);
      children.add(SizedBox(width: iconSpacing));
    }

    children.add(textWidget);

    if (hasTrailingIcon) {
      children.add(SizedBox(width: iconSpacing));
      children.add(trailingIcon!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}