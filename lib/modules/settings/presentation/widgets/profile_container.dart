import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Container(
      height: 148.h,
      color: colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            backgroundColor: colorScheme.primary,
            titleSpacing: 0,
            centerTitle: true,
            title: Text(
              "Settings",
              style: textStyles.headlineLarge?.copyWith(
                fontSize: 20.sp,
                color: colorScheme.surface,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: colorScheme.surface,
                      child:
                          user.profileImage != null
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(30.r),
                                child: Image.network(
                                  user.profileImage!,
                                  width: 60.w,
                                  height: 60.h,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : Text(
                                "${user.firstName![0]}${user.lastName![0]}",
                                style: TextStyle(color: colorScheme.primary),
                              ),
                    ),
                    SizedBox(width: 12.w),
                    SizedBox(
                      width: 200.w,
                      child: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: "Hello\n",
                          style: textStyles.bodySmall?.copyWith(
                            color: colorScheme.surface,
                          ),
                          children: [
                            TextSpan(
                              text: "${user.firstName} ${user.lastName}",
                              style: textStyles.bodyLarge?.copyWith(
                                color: colorScheme.surface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  iconSize: 20.r,
                  icon: Icon(Icons.edit, color: colorScheme.surface),
                  onPressed: () {
                    context.push(Routes.editProfile);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
