import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/complete_profile/complete_profile_cubit.dart';
import 'package:snapnfix/core/utils/mixins/listener_mixin.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class CompleteProfileBlocListener extends StatelessWidget with ListenerMixin {
  const CompleteProfileBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () => showLoadingDialog(context),
          success: (session) {
            handleSuccess(
              context,
              showSuccessMessage: true,
              successMessage:
                  AppLocalizations.of(context)!.completeProfileSuccessMessage,
              navigationRoute: Routes.home,
            );
          },
          error:
              (error) =>
                  handleError(context, error, fallbackRoute: Routes.register),
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
