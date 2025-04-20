import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/modules/settings/logic/cubit/edit_profile_cubit.dart';

class EditProfileBlocListener extends StatelessWidget {
  const EditProfileBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (editProfileResponse) {
            context.pop();
            baseDialog(
              context: context,
              title: 'Success',
              message: 'Profile Edited successfully',
              alertType: AlertType.success,
              confirmText: 'Got it',
              onConfirm: () => context.pop(),
              showCancelButton: false,
            );
          },
          error: (error) {
            setupErrorState(context, error);
          },
          loading: () {
            showDialog(
              context: context,
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
    context.pop();
    baseDialog(
      context: context,
      title: 'Error',
      message: error,
      alertType: AlertType.error,
      confirmText: 'Got it',
      onConfirm: () {},
      showCancelButton: false,
    );
  }
}
