import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportDateIndicator extends StatelessWidget {
  final DateTime createdAt;

  const ReportDateIndicator({
    super.key,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        _getTimeAgo(createdAt, context),
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final localization = AppLocalizations.of(context)!;

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} ${(difference.inDays / 365).floor() == 1 ? localization.year : localization.years} ${localization.ago}';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} ${(difference.inDays / 30).floor() == 1 ? localization.month : localization.months} ${localization.ago}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? localization.day : localization.days} ${localization.ago}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? localization.hour : localization.hours} ${localization.ago}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? localization.minute : localization.minutes} ${localization.ago}';
    } else {
      return localization.justNow;
    }
  }
}