import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AuthenticationHeader extends StatelessWidget {
  const AuthenticationHeader({
    super.key,
    this.showBackButton = false,
    required this.title,
    required this.subtitle,
  });
  final bool showBackButton;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final headerHeight = 200.h;
    final contentHeight = 180.h;
    final logoHeight = 70.h;

    return SizedBox(
      height: headerHeight,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: 'pattern_background',
            child: Image.asset(
              'assets/images/Pattern.png',
              width: double.infinity,
              height: contentHeight,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              Hero(
                tag: 'app_logo',
                child: Image.asset(
                  'assets/images/SnapNFix.png',
                  height: logoHeight,
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 8.h),
                  Text(
                    title,
                    style: textStyles.headlineLarge?.copyWith(
                      color: colorScheme.primary,
                      fontSize: 24.sp,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 280.w,
                    height: 40.h,
                    child: Text(
                      subtitle,
                      style: textStyles.bodyMedium?.copyWith(
                        color: colorScheme.primary.withOpacity(0.7),
                        fontSize: 14.sp,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (showBackButton)
            Positioned(
              top: 16.h,
              left: 16.w,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                color: colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}
