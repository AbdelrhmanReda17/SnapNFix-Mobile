import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/authentication_screen.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/reset_password/reset_password_bloc_listener.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/reset_password/reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return AuthenticationScreen<ResetPasswordCubit>(
      title: localization.resetPasswordTitle,
      subtitle: localization.resetPasswordSubtitle,
      buttonText: localization.resetPassword,
      form: const ResetPasswordForm(),
      blocListener: const ResetPasswordBlocListener(),
      onSubmit: () => context.read<ResetPasswordCubit>().resetPassword(),
      showSocial: false,
      showBackButton: true,
      additionalContent: [
        Text(
          localization.passwordRequirements,
          style: textStyles.bodySmall?.copyWith(color: colorScheme.primary),
        ),
        verticalSpace(12),
        _buildPasswordRequirements(context),
        verticalSpace(32),
      ],
    );
  }

  Widget _buildPasswordRequirements(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: colorScheme.primary);

    return Column(
      children: [
        _buildRequirementItem(
          localization.passwordMinChars,
          colorScheme,
          textStyle,
        ),
        _buildRequirementItem(
          localization.passwordUppercase,
          colorScheme,
          textStyle,
        ),
        _buildRequirementItem(
          localization.passwordLowercase,
          colorScheme,
          textStyle,
        ),
        _buildRequirementItem(
          localization.passwordNumber,
          colorScheme,
          textStyle,
        ),
        _buildRequirementItem(
          localization.passwordSpecial,
          colorScheme,
          textStyle,
        ),
      ],
    );
  }

  Widget _buildRequirementItem(
    String text,
    ColorScheme colorScheme,
    TextStyle? textStyle,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(color: colorScheme.primary, fontSize: 14.sp),
          ),
          Expanded(child: Text(text, style: textStyle)),
        ],
      ),
    );
  }
}
