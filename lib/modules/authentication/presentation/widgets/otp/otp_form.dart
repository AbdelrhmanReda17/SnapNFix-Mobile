import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';

class OtpForm extends StatelessWidget {
  final OtpPurpose purpose;
  const OtpForm({super.key, required this.purpose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cubit = context.read<OtpCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          OtpTextField(
            numberOfFields: 6,
            borderColor: colorScheme.primary,
            focusedBorderColor: colorScheme.primary,
            fillColor: colorScheme.primary.withValues(alpha: 0.2),
            enabledBorderColor: colorScheme.primary.withValues(alpha: 0.2),
            filled: true,
            fieldWidth: 45.w,
            onSubmit: (String verificationCode) {
              cubit.updateOtpCode(verificationCode, purpose);
            },
            showFieldAsBox: true,
          ),
        ],
      ),
    );
  }
}
