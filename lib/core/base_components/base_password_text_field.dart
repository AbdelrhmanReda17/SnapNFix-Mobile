import 'package:flutter/material.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';

class BasePasswordTextField extends StatefulWidget {
  final String text;
  final String? hintText;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const BasePasswordTextField({
    super.key,
    required this.text,
    this.hintText,
    this.initialValue,
    this.validator,
    this.onChanged,
  });

  @override
  State<BasePasswordTextField> createState() => _BasePasswordTextFieldState();
}

class _BasePasswordTextFieldState extends State<BasePasswordTextField> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BaseTextField(
      labelText: widget.hintText != null ? widget.text : null,
      hintText: widget.hintText ?? widget.text,
      initialValue: widget.initialValue,
      isObscureText: !_isPasswordVisible,
      suffixIcon: GestureDetector(
        onTap: _togglePasswordVisibility,
        child: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: colorScheme.primary,
        ),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}