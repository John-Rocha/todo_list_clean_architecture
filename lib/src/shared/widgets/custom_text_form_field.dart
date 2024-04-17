import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.label,
    this.borderRadius,
    this.controller,
    this.keyboardType,
    this.enabled = true,
    this.initialValue,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    super.key,
  });

  final String? label;
  final double? borderRadius;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? enabled;
  final String? initialValue;
  final bool obscureText;
  final String? Function(String? value)? validator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      readOnly: !enabled!,
      validator: validator,
    );
  }
}
