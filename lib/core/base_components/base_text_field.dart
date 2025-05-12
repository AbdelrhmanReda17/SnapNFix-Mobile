import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final int maxLines;
  final int maxErrorLines;
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const BaseTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.validator,
    this.isObscureText = false,
    this.suffixIcon,
    this.backgroundColor,
    this.inputTextStyle,
    this.hintStyle,
    this.contentPadding,
    this.maxLines = 1,
    this.maxErrorLines = 2,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    widget.onChanged?.call(_controller.text);
  }

  InputBorder _buildBorder(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1.3),
      borderRadius: BorderRadius.circular(12.r),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: textStyles.bodyMedium?.copyWith(
              color: colorScheme.primary.withValues(alpha: 0.5),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 2.h),
        ],
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            key: ValueKey(_controller.hashCode),
            focusNode: FocusNode(),
            controller: _controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: false,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              isDense: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
              border: _buildBorder(colorScheme.primary.withValues(alpha: 0.2)),
              focusedBorder: _buildBorder(colorScheme.primary),
              enabledBorder: _buildBorder(colorScheme.primary.withValues(alpha: 0.2)),
              errorBorder: _buildBorder(colorScheme.error),
              focusedErrorBorder: _buildBorder(colorScheme.error),
              hintText: widget.hintText,
              hintStyle:
                  widget.hintStyle ??
                  textStyles.bodyMedium?.copyWith(
                    color: colorScheme.primary.withValues(alpha: 0.5),
                    fontSize: 16.sp,
                  ),
              suffixIcon: widget.suffixIcon,
              fillColor:
                  widget.backgroundColor ??
                  colorScheme.primary.withValues(alpha: 0.1),
              filled: true,
              errorMaxLines: widget.maxErrorLines,
            ),
            obscureText: widget.isObscureText,
            style:
                widget.inputTextStyle ??
                textStyles.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontSize: 16.sp,
                ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
