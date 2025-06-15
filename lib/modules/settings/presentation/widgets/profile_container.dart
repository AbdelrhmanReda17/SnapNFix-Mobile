import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 150.h,
      width: double.infinity,
      color: colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            backgroundColor: colorScheme.primary,
            titleSpacing: 0,
            centerTitle: true,
            title: Text(
              localization.settings,
              style: textStyles.headlineLarge?.copyWith(
                fontSize: 20.sp,
                color: isDarkMode ? Colors.white : colorScheme.onPrimary,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                children: [
                  // Avatar - Fixed width
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
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildInitialsAvatar(
                                    colorScheme,
                                    isDarkMode,
                                  );
                                },
                              ),
                            )
                            : _buildInitialsAvatar(colorScheme, isDarkMode),
                  ),

                  // Spacing
                  horizontalSpace(12),

                  // User info - Flexible to take remaining space
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          localization.hello,
                          style: textStyles.bodySmall?.copyWith(
                            color:
                                isDarkMode
                                    ? Colors.white
                                    : colorScheme.onPrimary,
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "${user.firstName ?? ''} ${user.lastName ?? ''}"
                              .trim(),
                          style: textStyles.bodyLarge?.copyWith(
                            color:
                                isDarkMode
                                    ? Colors.white
                                    : colorScheme.onPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Edit button - Fixed width
                  SizedBox(
                    width: 40.w,
                    height: 40.h,
                    child: IconButton(
                      iconSize: 20.r,
                      icon: Icon(
                        Icons.edit,
                        color:
                            isDarkMode ? Colors.white : colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        context.push(Routes.editProfile);
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialsAvatar(ColorScheme colorScheme, bool isDarkMode) {
    final firstName = user.firstName ?? '';
    final lastName = user.lastName ?? '';
    final initials =
        '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
            .toUpperCase();

    return Text(
      initials.isNotEmpty ? initials : '?',
      style: TextStyle(
        color: isDarkMode ? Colors.white : colorScheme.primary,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
