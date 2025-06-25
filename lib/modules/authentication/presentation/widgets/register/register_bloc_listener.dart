import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/register/register_cubit.dart';
import 'package:snapnfix/core/utils/mixins/listener_mixin.dart';
import '../../../../../../presentation/navigation/routes.dart';

class RegisterBlocListener extends StatelessWidget with ListenerMixin {
   const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        state.whenOrNull(
          requiresOtp: () {
            final cubit = context.read<RegisterCubit>();
            handleSuccess(
              context,
              navigationRoute: Routes.otp,
              navigationExtra: {
                'emailOrPhoneNumber': cubit.phone,
                'password': cubit.password,
                'purpose': OtpPurpose.registration,
                'isRegister': true,
              },
            );
          },
          loading: () => showLoadingDialog(context),
          error: (error) => handleError(context, error),
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}