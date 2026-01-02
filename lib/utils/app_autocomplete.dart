import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppAutocompleteDropdown<T extends Object> extends StatelessWidget {
  final List<T> items;
  final String hintText;
  final String Function(T) displayStringForOption;
  final ValueChanged<T> onSelected;
  final ValueChanged<String>? onTextChanged;
  final String? initialValue;
  final FocusNode? focusNode;
  final bool useGradient;
  final String? Function(String?)? validator;


  final String? labelText;
  final String? errorText;
  final String? prefixText;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextStyle? style;

  const AppAutocompleteDropdown({
    Key? key,
    required this.items,
    required this.hintText,
    required this.displayStringForOption,
    required this.onSelected,
    this.onTextChanged,
    this.initialValue,
    this.focusNode,
    this.useGradient = false,
    this.labelText,
    this.errorText,
    this.prefixText,
    this.suffixIcon,
    this.hintStyle,
    this.style,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller =
    TextEditingController(text: initialValue ?? '');

    return RawAutocomplete<T>(
      focusNode: focusNode,
      textEditingController: _controller,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return Iterable<T>.empty();
        }
        return items.where((T item) {
          return displayStringForOption(item)
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      displayStringForOption: displayStringForOption,
      onSelected: onSelected,

      fieldViewBuilder:
          (context, textEditingController, fieldFocusNode, onFieldSubmitted) {
        final textFieldWidget = TextFormField(
          controller: textEditingController,
          focusNode: focusNode ?? fieldFocusNode,
          onChanged: onTextChanged,



          style: style ??
              const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 16,
              ),

          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: App_colors.gradient_bg_green),
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.transparent,
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
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
            hintStyle: hintStyle ??
                TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
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
          padding: const EdgeInsets.all(1),
          child: textFieldWidget,
        );
      },

      optionsViewBuilder: (context, onSelectedOption, options) {
        return Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(8),
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelectedOption(option);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(displayStringForOption(option)),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
