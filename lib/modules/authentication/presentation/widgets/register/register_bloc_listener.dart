import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/register/register_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/mixins/authentication_listener_mixin.dart';
import '../../../../../../presentation/navigation/routes.dart';

class RegisterBlocListener extends StatelessWidget
    with AuthenticationListenerMixin {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (_, state) {
        state.whenOrNull(
          requiresOtp: () {
            context.pop();
            context.push(
              Routes.otp,
              extra: {
                'emailOrPhoneNumber': context.read<RegisterCubit>().phone,
                'password': context.read<RegisterCubit>().password,
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
