import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_alert_component/alert_type.dart';
import 'package:snapnfix/core/base_components/base_alert_component/base_alert.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';

class EditProfileBlocListener extends StatelessWidget {
  const EditProfileBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (editProfileResponse) {
            if (context.canPop()) {
              context.pop();
            }
            baseDialog(
              context: context,
              title: localization.successDialogTitle,
              message: localization.profileEditedSuccessfully,
              alertType: AlertType.success,
              confirmText: localization.gotItConfirmText,
              onConfirm: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
              showCancelButton: false,
            );
          },
          error: (error) {
            setupErrorState(context, error);
          },
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (context) => Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  ),
            );
          },
        );
      },
      child: SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    if (context.canPop()) {
      context.pop();
    }
    baseDialog(
      context: context,
      title: AppLocalizations.of(context)!.errorDialogTitle,
      message: error,
      alertType: AlertType.error,
      confirmText: AppLocalizations.of(context)!.gotItConfirmText,
      onConfirm: () {
        if (context.canPop()) {
          context.pop();
        }
      },
      showCancelButton: false,
    );
  }
}
