import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? errorText;
  final TextInputAction textInputAction;
  final String? initialValue;
  final int? maxLines;
  final bool readOnly;
  final Color? fillColor;
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.errorText,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
    this.initialValue,
    this.maxLines,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      initialValue: initialValue,
      onFieldSubmitted: onSubmitted,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}
