import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/features/authentication/presentation/screens/auhentication_screen.dart';
import 'package:snapnfix/core/helpers/extensions.dart';
import 'package:snapnfix/features/authentication/logic/cubit/login_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/features/authentication/presentation/widgets/login/login_bloc_listener.dart';
import 'package:snapnfix/features/authentication/presentation/widgets/login/login_form.dart';
import '../../../../core/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AuthenticationScreen<LoginCubit>(
      title: localization.welcomeBack,
      subtitle: localization.loginToContinue,
      buttonText: localization.signIn,
      footerQuestion: localization.notRegistered,
      footerAction: localization.createAccount,
      onFooterTap:
          () => context.pushNamedAndRemoveUntil(
            Routes.signUpScreen,
            predicate: (route) => false,
          ),
      form: LoginForm(),
      blocListener: const LoginBlocListener(),
      onSubmit: () {
        context.read<LoginCubit>().emitLoginStates();
      },
    );
  }
}
