import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/complete_profile/complete_profile_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/mixins/authentication_listener_mixin.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class CompleteProfileBlocListener extends StatelessWidget
    with AuthenticationListenerMixin {
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
              message: 'Your profile has been successfully completed.',
              route: Routes.homeScreen.key,
            );
          },
          error: (error) => handleError(context, error),
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
