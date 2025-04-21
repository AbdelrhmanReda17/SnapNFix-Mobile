import 'package:flutter/material.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
// import 'package:snapnfix/core/theming/colors.dart';

class BasePasswordTextField extends StatelessWidget {
  final String text;
  final bool isPasswordObscureText;
  final void Function() togglePasswordObscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const BasePasswordTextField({
    super.key,
    required this.text,
    required this.isPasswordObscureText,
    required this.togglePasswordObscureText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BaseTextField(
      hintText: text,
      controller: controller,
      isObscureText: isPasswordObscureText,
      suffixIcon: GestureDetector(
        onTap: togglePasswordObscureText,
        child: Icon(
          color: colorScheme.primary,
          isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
        ),
      ),
      toggleObscureText: togglePasswordObscureText,
      validator: validator,
    );
  }
}
