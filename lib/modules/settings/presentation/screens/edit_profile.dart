import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/settings/logic/cubit/edit_profile_cubit.dart';
import 'package:snapnfix/modules/settings/presentation/widgets/edit_profile/edit_password_bloc_listener.dart';
import 'package:snapnfix/modules/settings/presentation/widgets/edit_profile/edit_password_form.dart';
import 'package:snapnfix/modules/settings/presentation/widgets/edit_profile/profile_image_section.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';

// TODO: Validate password fields and show error messages if they don't match or don't meet the requirements.
// TODO: Add functionality to change the gender and date of birth fields.
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
        title: Text(
          localization?.editProfile ?? 'Edit Profile',
          style: TextStyle(color: colorScheme.surface, fontSize: 18.sp),
        ),
        iconTheme: IconThemeData(color: colorScheme.surface, size: 20.sp),
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
                  SizedBox(height: 30.h),
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
                            color: colorScheme.surface,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: BaseButton(
                          onPressed: () {},
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
