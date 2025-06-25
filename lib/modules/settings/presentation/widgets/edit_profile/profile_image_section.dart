import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<EditProfileCubit>();

    return Container(
      width: double.infinity,
      color: colorScheme.primary,
      padding: EdgeInsets.only(bottom: 30.h, top: 10.h),
      child: Center(
        child: Stack(
          children: [
            ValueListenableBuilder<File?>(
              valueListenable: cubit.profileImage,
              builder: (context, profileImage, _) {
                return CircleAvatar(
                  backgroundColor: colorScheme.surface,
                  radius: 50.r,
                  backgroundImage:
                      profileImage != null ? FileImage(profileImage) : null,

                  child:
                      (profileImage == null &&
                              (cubit.userProfileImage == null ||
                                  cubit.userProfileImage!.isEmpty))
                          ? Icon(
                            Icons.person,
                            size: 50.r,
                            color: colorScheme.tertiary,
                          )
                          : null,
                );
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => cubit.pickImage(),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(6.r),
                  child: Icon(
                    Icons.camera_alt,
                    color: colorScheme.surface,
                    size: 20.r,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
