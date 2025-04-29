import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/complete_profile/complete_profile_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/auhentication_screen.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/complete_profile/complete_profile_form.dart';
import 'package:snapnfix/modules/authentication/presentation/widgets/complete_profile/complete_profile_bloc_listener.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AuthenticationScreen<CompleteProfileCubit>(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorScheme.primary, size: 24.sp),
      ),
      title: "Complete Profile",
      subtitle: "Welcome , Let's get to know you better",
      buttonText: "Complete",
      footerQuestion: '',
      footerAction: "Skip",
      form: CompleteProfileForm(),
      blocListener: const CompleteProfileBlocListener(),
      onSubmit: () {
        context.read<CompleteProfileCubit>().submitProfile();
      },
      showSocial: false,
      showTerms: false,
      showLogo: false,
    );
  }
}
