import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/register/register_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/authentication_screen.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/register/register_form.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/register/register_bloc_listener.dart';
import '../../../../../presentation/navigation/routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return AuthenticationScreen<RegisterCubit>(
      title: "Get started now",
      subtitle: "Your one-stop solution for all your needs",
      buttonText: localization.signUp,
      footerQuestion: localization.alreadyHaveAcc,
      footerAction: localization.signIn,
      onFooterTap: () {
        context.go(Routes.loginScreen.key);
      },
      form: RegisterForm(),
      blocListener: const RegisterBlocListener(),
      onSubmit: () {
        context.read<RegisterCubit>().emitRegisterStates();
      },
      showTerms: true,
      
      showSocial: false,
    );
  }
}
