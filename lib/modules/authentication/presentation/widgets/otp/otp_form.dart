import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cubit = context.read<OtpCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          OtpTextField(
            numberOfFields: 6,
            borderColor: colorScheme.primary,
            focusedBorderColor: colorScheme.primaryFixedDim,
            showFieldAsBox: true,
            onCodeChanged: (String code) {
              cubit.updateOtpCode(code);
            },
          ),
        ],
      ),
    );
  }
}

