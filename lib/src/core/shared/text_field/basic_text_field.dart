import 'package:flutter/material.dart';

class BasicTextField extends StatelessWidget {
  const BasicTextField(
      {super.key,
      this.controller,
      this.isObscureText = false,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.validator,
      this.onChanged});

  final TextEditingController? controller;
  final bool isObscureText;
  final String? hintText, labelText;
  final Widget? suffixIcon, prefixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
