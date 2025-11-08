
import 'package:flutter/material.dart';
import 'package:note_now/view_model/constants/app_color.dart';

class FormTextfield extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType? keyboardType;

  const FormTextfield({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.suffix,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffix: suffix,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 20.0,
        ),
        filled: true,
        fillColor: AppColors.primaryLight.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}