import 'package:flutter/material.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/theming/colors.dart';

class BasePasswordTextField extends StatelessWidget {
  final String text;
  final bool isPasswordObscureText;
  final void Function() togglePasswordObscureText;
  final TextEditingController controller;
  const BasePasswordTextField({
    super.key,
    required this.text,
    required this.isPasswordObscureText,
    required this.togglePasswordObscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      hintText: text,
      controller: controller,
      isObscureText: isPasswordObscureText,
      suffixIcon: GestureDetector(
        onTap: togglePasswordObscureText,
        child: Icon(
          color: ColorsManager.primaryColor,
          isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
        ),
      ),
      toggleObscureText: togglePasswordObscureText,
    );
  }
}
