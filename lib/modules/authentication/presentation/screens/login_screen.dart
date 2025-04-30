import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/login/login_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/authentication_screen.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/login/login_bloc_listener.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/login/login_form.dart';
import '../../../../../presentation/navigation/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AuthenticationScreen<LoginCubit>(
      title: "Sign In to your account",
      subtitle: "Enter your email and password to log in to your account",
      buttonText: localization.signIn,
      footerQuestion: localization.notRegistered,
      footerAction: localization.createAccount,
      onFooterTap: () {
        context.go(Routes.registerScreen.key);
      },
      form: LoginForm(),
      blocListener: const LoginBlocListener(),
      onSubmit: () {
        context.read<LoginCubit>().emitLoginStates();
      },
      showSocial: true,
    );
  }
}
