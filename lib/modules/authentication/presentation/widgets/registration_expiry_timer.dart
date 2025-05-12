import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

class RegistrationExpiryTimer extends StatelessWidget {
  final int remainingTime;

  const RegistrationExpiryTimer({super.key, required this.remainingTime});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    final minutes = (remainingTime / 60).floor();
    final seconds = remainingTime % 60;

    final isNearExpiry = remainingTime < 120; // Less than 2 minutes

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color:
            isNearExpiry
                ? colorScheme.error.withValues(alpha: 0.1)
                : colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isNearExpiry ? colorScheme.error : colorScheme.primary,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer_outlined,
            color: isNearExpiry ? colorScheme.error : colorScheme.primary,
            size: 20.w,
          ),
          horizontalSpace(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization.codeExpiresIn,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color:
                        isNearExpiry ? colorScheme.error : colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color:
                        isNearExpiry ? colorScheme.error : colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
