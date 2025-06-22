import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/responsive_dimensions.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key, required this.onSubmit});
  final Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cubit = context.read<OtpCubit>();
    final dimensions = getResponsiveDimensions(context);
    
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildResponsiveOtpField(context, colorScheme, dimensions),
        ],
      ),
    );
  }

  Widget _buildResponsiveOtpField(
    BuildContext context,
    ColorScheme colorScheme,
    ResponsiveDimensions dimensions,
  ) {
    // Calculate responsive field width based on screen width and device type
    double fieldWidth;
    double borderWidth;
    double borderRadius;
    double fontSize;
    double fieldHeight;
    double fieldSpacing;

    if (dimensions.isTablet) {
      // Tablet dimensions
      fieldWidth = 60.w;
      borderWidth = 2.0;
      borderRadius = 12.r;
      fontSize = 24.sp;
      fieldHeight = 65.h;
      fieldSpacing = 16.w;
    } else if (dimensions.screenWidth < 350) {
      // Small phone dimensions (very small screens)
      fieldWidth = 35.w;
      borderWidth = 1.5;
      borderRadius = 8.r;
      fontSize = 18.sp;
      fieldHeight = 45.h;
      fieldSpacing = 8.w;
    } else if (dimensions.screenWidth < 400) {
      // Medium phone dimensions
      fieldWidth = 40.w;
      borderWidth = 1.8;
      borderRadius = 10.r;
      fontSize = 20.sp;
      fieldHeight = 50.h;
      fieldSpacing = 10.w;
    } else {
      // Large phone dimensions (default)
      fieldWidth = 45.w;
      borderWidth = 2.0;
      borderRadius = 10.r;
      fontSize = 22.sp;
      fieldHeight = 55.h;
      fieldSpacing = 12.w;
    }

    // Ensure minimum spacing for landscape mode
    if (dimensions.isLandscape && !dimensions.isTablet) {
      fieldSpacing = fieldSpacing * 0.8; // Reduce spacing in landscape
      fieldWidth = fieldWidth * 0.9; // Slightly smaller fields in landscape
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate maximum available width for OTP fields
        final maxWidth = constraints.maxWidth;
        final totalFieldsWidth = (fieldWidth * 6) + (fieldSpacing * 5);
        
        // If calculated width exceeds available space, scale down
        if (totalFieldsWidth > maxWidth) {
          final scaleFactor = maxWidth / totalFieldsWidth;
          fieldWidth = fieldWidth * scaleFactor * 0.95; // 5% margin for safety
          fieldSpacing = fieldSpacing * scaleFactor * 0.95;
        }

        return Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: OtpTextField(
            numberOfFields: 6,
            borderColor: colorScheme.primary,
            focusedBorderColor: colorScheme.primary,
            fillColor: colorScheme.primary.withValues(alpha: 0.1),
            enabledBorderColor: colorScheme.outline.withValues(alpha: 0.3),
            disabledBorderColor: colorScheme.outline.withValues(alpha: 0.2),
            cursorColor: colorScheme.primary,
            filled: true,
            fieldWidth: fieldWidth,
            fieldHeight: fieldHeight,
            borderWidth: borderWidth,
            borderRadius: BorderRadius.circular(borderRadius),
            margin: EdgeInsets.symmetric(horizontal: fieldSpacing / 2),
            textStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
            showFieldAsBox: true,
            autoFocus: true,
            clearText: false,
            keyboardType: TextInputType.number,
            onSubmit: onSubmit,
            onCodeChanged: (String code) {
              // Optional: Handle code changes for real-time validation
              if (code.length == 6) {
                // Auto-submit when all fields are filled
                FocusScope.of(context).unfocus();
              }
            },
          ),
        );
      },
    );
  }
}
