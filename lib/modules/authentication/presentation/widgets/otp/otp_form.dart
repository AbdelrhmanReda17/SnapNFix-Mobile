import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key, required this.onSubmit});
  final Function(String) onSubmit;

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cubit = context.read<OtpCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_buildOtpField(context, colorScheme)],
      ),
    );
  }

  Widget _buildOtpField(BuildContext context, ColorScheme colorScheme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final spacing = 3.w;
        return _buildSingleRowLayout(
          context,
          colorScheme,
          availableWidth,
          spacing,
        );
      },
    );
  }

  Widget _buildSingleRowLayout(
    BuildContext context,
    ColorScheme colorScheme,
    double availableWidth,
    double spacing,
  ) {
    final numberOfFields = 6;
    final totalSpacing = spacing * (numberOfFields - 1);
    final safeAvailableWidth =
        availableWidth - 20.w; 
    final fieldWidth = (safeAvailableWidth - totalSpacing) / numberOfFields;
    final clampedFieldWidth = fieldWidth.clamp(25.w, 45.w);

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: OtpTextField(
        numberOfFields: numberOfFields,
        borderColor: colorScheme.outline,
        focusedBorderColor: colorScheme.primary,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha:0.3),
        enabledBorderColor: colorScheme.outline.withValues(alpha:0.5),
        disabledBorderColor: colorScheme.outline.withValues(alpha:0.3),
        cursorColor: colorScheme.primary,
        filled: true,
        fieldWidth: clampedFieldWidth,
        fieldHeight: 55.h,
        borderWidth: 1.5,
        borderRadius: BorderRadius.circular(12.r),
        margin: EdgeInsets.symmetric(horizontal: spacing / 2),
        textStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
        showFieldAsBox: true,
        autoFocus: true,
        clearText: false,
        keyboardType: TextInputType.number,
        onSubmit: widget.onSubmit,
        onCodeChanged: (String code) {
          if (code.length == 6) {
            FocusScope.of(context).unfocus();
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: colorScheme.outline, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: colorScheme.outline.withValues(alpha:0.5),
              width: 1.5,
            ),
          ),
          fillColor: colorScheme.surfaceContainerHighest.withValues(alpha:0.3),
          filled: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
