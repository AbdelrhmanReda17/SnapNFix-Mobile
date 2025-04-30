import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_footer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cubit = context.read<OtpCubit>();
    final localization = AppLocalizations.of(context)!;
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
              cubit.updateOtpCode(verificationCode);
            },
            showFieldAsBox: true,
          ),
        ],
      ),
    );
  }
}
