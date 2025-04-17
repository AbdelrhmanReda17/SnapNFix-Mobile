import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/application_system_ui_overlay.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/base_components/base_password_text_field.dart';
import 'package:snapnfix/core/helpers/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/features/settings/logic/cubit/change_password_cubit.dart';
import 'package:snapnfix/features/settings/presentation/widgets/change_password_bloc_listener.dart';

// TODO: Validate password fields and show error messages if they don't match or don't meet the requirements.
class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context)!;
    final statusBarStyle = ApplicationSystemUIOverlay.getSettingsStyle(
      Theme.of(context).colorScheme.primary,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        systemOverlayStyle: statusBarStyle,
        title: Text(
          localization.changePassword,
          style: TextStyle(color: colorScheme.surface, fontSize: 18.sp),
        ),
        iconTheme: IconThemeData(color: colorScheme.surface, size: 20.sp),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Form(
              key: context.read<ChangePasswordCubit>().formKey,
              child: Column(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable:
                        context.read<ChangePasswordCubit>().oldPasswordVisible,
                    builder: (context, isVisible, child) {
                      return BasePasswordTextField(
                        text: localization.currentPassword,
                        controller:
                            context
                                .read<ChangePasswordCubit>()
                                .oldPasswordController,
                        togglePasswordObscureText:
                            () =>
                                context
                                    .read<ChangePasswordCubit>()
                                    .toggleOldPasswordVisibility(),
                        isPasswordObscureText:
                            !isVisible, // Note the negation if needed based on your BasePasswordTextField
                      );
                    },
                  ),
                  verticalSpace(20),
                  ValueListenableBuilder<bool>(
                    valueListenable:
                        context.read<ChangePasswordCubit>().newPasswordVisible,
                    builder: (context, isVisible, child) {
                      return BasePasswordTextField(
                        text: localization.newPassword,
                        controller:
                            context
                                .read<ChangePasswordCubit>()
                                .newPasswordController,
                        togglePasswordObscureText:
                            () =>
                                context
                                    .read<ChangePasswordCubit>()
                                    .toggleNewPasswordVisibility(),
                        isPasswordObscureText: !isVisible,
                      );
                    },
                  ),
                  verticalSpace(20),
                  ValueListenableBuilder<bool>(
                    valueListenable:
                        context
                            .read<ChangePasswordCubit>()
                            .confirmPasswordVisible,
                    builder: (context, isVisible, child) {
                      return BasePasswordTextField(
                        text: localization.repeatPassword,
                        controller:
                            context
                                .read<ChangePasswordCubit>()
                                .confirmPasswordController,
                        togglePasswordObscureText:
                            () =>
                                context
                                    .read<ChangePasswordCubit>()
                                    .toggleConfirmPasswordVisibility(),
                        isPasswordObscureText: !isVisible,
                      );
                    },
                  ),
                  verticalSpace(24),
                  Text(
                    localization.passwordRequirements,
                    style: textStyles.bodySmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _buildRequirementItem(
                    localization.passwordMinChars,
                    colorScheme,
                    textStyles.bodySmall?.copyWith(color: colorScheme.primary),
                  ),
                  _buildRequirementItem(
                    localization.passwordUppercase,
                    colorScheme,
                    textStyles.bodySmall?.copyWith(color: colorScheme.primary),
                  ),
                  _buildRequirementItem(
                    localization.passwordLowercase,
                    colorScheme,
                    textStyles.bodySmall?.copyWith(color: colorScheme.primary),
                  ),
                  _buildRequirementItem(
                    localization.passwordNumber,
                    colorScheme,
                    textStyles.bodySmall?.copyWith(color: colorScheme.primary),
                  ),
                  _buildRequirementItem(
                    localization.passwordSpecial,
                    colorScheme,
                    textStyles.bodySmall?.copyWith(color: colorScheme.primary),
                  ),
                  SizedBox(height: 32.h),
                  BaseButton(
                    text: localization.changePassword,
                    onPressed:
                        () =>
                            context
                                .read<ChangePasswordCubit>()
                                .emitChangePasswordState(),
                    backgroundColor: colorScheme.primary,
                    textStyle: textStyles.bodyLarge!.copyWith(
                      color: colorScheme.surface,
                    ),
                  ),
                  ChangePasswordBlocListener(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(
    String text,
    ColorScheme colorScheme,
    textStyle,
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
