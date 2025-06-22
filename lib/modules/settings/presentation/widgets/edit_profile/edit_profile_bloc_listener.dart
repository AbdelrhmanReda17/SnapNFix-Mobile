import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/mixins/listener_mixin.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';

class EditProfileBlocListener extends StatelessWidget with ListenerMixin {
  const EditProfileBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (editProfileResponse) {
            handleSuccess(
              context,
              showSuccessMessage: true,
              successMessage: localization.profileEditedSuccessfully,
              successTitle: localization.successDialogTitle,
            );
          },
          error: (error) {
            handleError(context, title: localization.errorDialogTitle, error);
          },
          loading: () {
            showLoadingDialog(context);
          },
        );
      },
      child: SizedBox.shrink(),
    );
  }
}
