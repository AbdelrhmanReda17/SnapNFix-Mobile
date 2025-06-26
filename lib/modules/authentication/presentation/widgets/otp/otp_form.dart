import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/responsive_dimensions.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key, required this.onSubmit});
  final Function(String) onSubmit;

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String firstRowCode = '';
  String secondRowCode = '';

  void _handleCodeChange() {
    final fullCode = firstRowCode + secondRowCode;
    if (fullCode.length == 6) {
      widget.onSubmit(fullCode);
    }
  }

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
        final spacing = 3.w; // Reduced spacing to prevent overflow

        const minWidthForSingleRow = 320.0;
        final shouldUseTwoRows = availableWidth < minWidthForSingleRow;

        if (shouldUseTwoRows) {
          return _buildTwoRowLayout(
            context,
            colorScheme,
            availableWidth,
            spacing,
          );
        } else {
          return _buildSingleRowLayout(
            context,
            colorScheme,
            availableWidth,
            spacing,
          );
        }
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
    // Add safety margin to prevent overflow
    final safeAvailableWidth =
        availableWidth - 20.w; // 10w padding on each side
    final fieldWidth = (safeAvailableWidth - totalSpacing) / numberOfFields;
    final clampedFieldWidth = fieldWidth.clamp(25.w, 45.w);

    // Final safety check: ensure total width doesn't exceed available space
    final totalWidth = (clampedFieldWidth * numberOfFields) + totalSpacing;

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: OtpTextField(
        numberOfFields: numberOfFields,
        borderColor: colorScheme.outline,
        focusedBorderColor: colorScheme.primary,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        enabledBorderColor: colorScheme.outline.withOpacity(0.5),
        disabledBorderColor: colorScheme.outline.withOpacity(0.3),
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
              color: colorScheme.outline.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
          filled: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildTwoRowLayout(
    BuildContext context,
    ColorScheme colorScheme,
    double availableWidth,
    double spacing,
  ) {
    final numberOfFieldsPerRow = 3;
    final totalSpacing = spacing * (numberOfFieldsPerRow - 1);
    final fieldWidth = (availableWidth - totalSpacing) / numberOfFieldsPerRow;
    final clampedFieldWidth = fieldWidth.clamp(40.w, 70.w);

    return Column(
      children: [
        // First row (digits 1-3)
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: OtpTextField(
            numberOfFields: numberOfFieldsPerRow,
            borderColor: colorScheme.outline,
            focusedBorderColor: colorScheme.primary,
            fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
            enabledBorderColor: colorScheme.outline.withOpacity(0.5),
            disabledBorderColor: colorScheme.outline.withOpacity(0.3),
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
            onCodeChanged: (String code) {
              setState(() {
                firstRowCode = code;
              });
              _handleCodeChange();

              // Auto-focus second row when first row is complete
              if (code.length == 3) {
                FocusScope.of(context).nextFocus();
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
                  color: colorScheme.outline.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
              filled: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // Second row (digits 4-6)
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: OtpTextField(
            numberOfFields: numberOfFieldsPerRow,
            borderColor: colorScheme.outline,
            focusedBorderColor: colorScheme.primary,
            fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
            enabledBorderColor: colorScheme.outline.withOpacity(0.5),
            disabledBorderColor: colorScheme.outline.withOpacity(0.3),
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
            autoFocus: false,
            clearText: false,
            keyboardType: TextInputType.number,
            onCodeChanged: (String code) {
              setState(() {
                secondRowCode = code;
              });
              _handleCodeChange();

              // Unfocus when complete
              if (code.length == 3) {
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
                  color: colorScheme.outline.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
              filled: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
