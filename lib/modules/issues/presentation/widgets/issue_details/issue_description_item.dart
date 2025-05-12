import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_description.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IssueDescriptionItem extends StatelessWidget {
  final IssueDescription description;

  const IssueDescriptionItem({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline, width: 1),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: colorScheme.primary,
                radius: 20.r,
                child: Text(
                  description.username.isNotEmpty
                      ? description.username[0].toUpperCase()
                      : '?',
                  style: textStyle.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.surface,
                  ),
                ),
              ),
              horizontalSpace(10),
              Expanded(
                child: Text(
                  description.username,
                  style: textStyle.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              Text(
                _getTimeAgo(description.createdAt, context),
                style: textStyle.bodyMedium!.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(left: 48.w),
            child: Text(
              description.text,
              style: textStyle.bodyMedium!.copyWith(
                fontSize: 15.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final localization = AppLocalizations.of(context)!;

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} ${(difference.inDays / 365).floor() == 1 ? '${localization.year}' : '${localization.years}'} ${localization.ago}';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} ${(difference.inDays / 30).floor() == 1 ? '${localization.month}' : '${localization.months}'} ${localization.ago}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? '${localization.day}' : '${localization.days}'} ${localization.ago}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? '${localization.hour}' : '${localization.hours}'} ${localization.ago}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? '${localization.minute}' : '${localization.minutes}'} ${localization.ago}';
    } else {
      return localization.justNow;
    }
  }
}
