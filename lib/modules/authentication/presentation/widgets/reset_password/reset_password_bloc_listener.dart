import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:snapnfix/core/utils/mixins/listener_mixin.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordBlocListener extends StatelessWidget
    with ListenerMixin {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (isSucess) {
            handleSuccess(
              context,
              successMessage: AppLocalizations.of(context)!.resetPasswordSuccessfully,
              navigationRoute: Routes.login,
            );
          },
          loading: () => showLoadingDialog(context),
          error: (error) => handleError(context, error),
        );
      },
      child: SizedBox.shrink(),
    );
  }
}
