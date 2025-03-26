import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/features/authentication/logic/cubit/sign_up_cubit.dart';
import 'package:snapnfix/features/authentication/presentation/screens/auhentication_screen.dart';
import 'package:snapnfix/features/authentication/presentation/widgets/signup/sign_up_bloc_listener.dart';
import 'package:snapnfix/features/authentication/presentation/widgets/signup/sign_up_form.dart';
import '../../../../core/routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return AuthenticationScreen<SignUpCubit>(
      title: localization.createAccountTitle,
      subtitle: localization.registerToContinue,
      buttonText: localization.signUp,
      footerQuestion: localization.alreadyHaveAcc,
      footerAction: localization.signIn,
      onFooterTap: () => context.go(Routes.loginScreen.key),
      form: SignUpForm(),
      blocListener: const SignUpBlocListener(),
      onSubmit: () {
        context.read<SignUpCubit>().emitSignUpStates();
      },
    );
  }
}
