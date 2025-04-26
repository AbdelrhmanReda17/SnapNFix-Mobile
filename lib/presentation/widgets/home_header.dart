import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final session = getIt<ApplicationConfigurations>().currentSession;

    if (session == null) {
      return const SizedBox.shrink();
    }

    final user = session.user;
    final initials = '${user.firstName[0]}${user.lastName[0]}'.toUpperCase();

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 32.w,
            bottom: 16.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go(Routes.settingsScreen.key),
                    child: CircleAvatar(
                      radius: 28.r,
                      backgroundColor: theme.colorScheme.primary,
                      child: Text(
                        initials,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hello, ',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: const Color.fromARGB(255, 47, 115, 94),
                                fontSize: 16.sp,
                              ),
                            ),
                            TextSpan(
                              text: '${user.firstName} ${user.lastName}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 16.sp,
                                color: const Color.fromARGB(255, 47, 115, 94),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 2.h),
                      Text(
                        'Keep Our City Safe!',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color.fromARGB(255, 47, 115, 94),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14.sp,
                            color: Colors.grey,
                          ),
                          Text(
                            '36 Dokki st, Giza',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 16.h,
          right: 8.w,
          child: IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: 32.r,
              color: theme.colorScheme.primary,
            ),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
      ],
    );
  }
}
