import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class CommonDropDownField<T> extends StatelessWidget {
  final T? initialValue;
  final String hintText;
  final String? labelText;
  final List<T> items;
  final String Function(T) labelMapper;
  final dynamic Function(T) valueMapper;
  final void Function(DropDownValueModel) onChanged;
  final VoidCallback? onClear;
  final bool isRequired;
  final bool enableSearch;
  final String? Function(dynamic)? validator; // ★ custom validator support added
  final SingleValueDropDownController? controller;

  const CommonDropDownField({
    super.key,
    this.initialValue,
    required this.hintText,
    this.labelText,
    required this.items,
    required this.labelMapper,
    required this.valueMapper,
    required this.enableSearch,
    required this.onChanged,
    this.onClear,
    this.controller,
    this.validator,
    this.isRequired = true,
  });

  void _resetController() {
    if (controller != null) {
      controller!.dropDownValue = null;
      controller!.clearDropDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    DropDownValueModel? initialModel;

    // Apply initial selected item (only when controller is not used)
    if (controller == null && initialValue != null) {
      initialModel = DropDownValueModel(
        name: labelMapper(initialValue as T),
        value: valueMapper(initialValue as T),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropDownTextField(
          controller: controller,
          initialValue: initialModel,
          clearOption: true,
textStyle: TextStyle(color: Colors.white, fontSize: 14,),
          textFieldDecoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.red),

            hintText: hintText,
            labelText: labelText,
            border: OutlineInputBorder(  borderRadius: BorderRadius.circular(8),),

            hintStyle: const TextStyle(color: Colors.white),
          ),
          enableSearch: enableSearch,
          listPadding: ListPadding(top: 2),
          validator: (value) {
            if (validator != null) return validator!(value);
            if (!isRequired) return null;
            if (value == null) return "Required field";
            if (value is DropDownValueModel &&
                (value.value == null || value.value.toString().trim().isEmpty)) {
              return "Required field";
            }
            return null;
          },
          dropDownList: items.map(
                (e) => DropDownValueModel(
              name: labelMapper(e),
              value: valueMapper(e),
            ),
          ).toList(),
          onChanged: (val) {
            if (val is DropDownValueModel) {
              onChanged(val);
            } else {
              _resetController();
              onClear?.call();
            }
          },
        ),
      ],
    );

  }
}

extension on String {
  get value => null;
}
