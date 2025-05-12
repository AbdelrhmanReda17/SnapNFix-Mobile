import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/complete_profile/complete_profile_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/authentication_content.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/complete_profile/complete_profile_form.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/complete_profile/complete_profile_bloc_listener.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key, this.phoneNumber, this.password});

  final String? phoneNumber;
  final String? password;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return AuthenticationContent(
      title: localization.completeProfileTitle,
      subtitle: localization.completeProfileSubtitle,
      buttonText: localization.complete,
      footerAction: localization.skip,
      form: CompleteProfileForm(password: password),
      blocListener: const CompleteProfileBlocListener(),
      onSubmit: () {
        if (password != null) {
          context.read<CompleteProfileCubit>().submitProfile(password!);
        }
      },
      showSocial: false,
      showTerms: false,
      
    );
  }
}
