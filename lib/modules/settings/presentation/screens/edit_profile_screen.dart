import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';
import 'package:snapnfix/modules/settings/presentation/widgets/edit_profile/edit_profile_bloc_listener.dart';
import 'package:snapnfix/modules/settings/presentation/widgets/edit_profile/edit_profile_form.dart';
import 'package:snapnfix/modules/settings/presentation/widgets/edit_profile/profile_image_section.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context);
    final statusBarStyle = ApplicationSystemUIOverlay.getSettingsStyle(
      colorScheme.primary,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        systemOverlayStyle: statusBarStyle,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          localization?.editProfile ?? 'Edit Profile',
          style: TextStyle(color: colorScheme.onPrimary, fontSize: 20.sp),
        ),
        iconTheme: IconThemeData(color: colorScheme.onPrimary, size: 20.sp),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileImageSection(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  const EditProfileForm(),
                  verticalSpace(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BaseButton(
                          onPressed:
                              () =>
                                  context
                                      .read<EditProfileCubit>()
                                      .emitEditProfile(),
                          text: localization?.save ?? 'Save Changes',
                          textStyle: textTheme.bodyLarge!.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      horizontalSpace(16),
                      Expanded(
                        child: BaseButton(
                          onPressed: () {
                            final cubit = context.read<EditProfileCubit>();
                            cubit.initializeUserData();
                            // cubit.profileImage.value = null;
                            cubit.formKey.currentState?.reset();
                          },
                          text: localization?.reset ?? 'Reset',
                          textStyle: textTheme.bodyLarge!.copyWith(
                            color: colorScheme.primary,
                          ),
                          backgroundColor: colorScheme.surface,
                          buttonHeight: 48.h,
                          borderRadius: 8.r,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const EditProfileBlocListener(),
          ],
        ),
      ),
    );
  }
}
