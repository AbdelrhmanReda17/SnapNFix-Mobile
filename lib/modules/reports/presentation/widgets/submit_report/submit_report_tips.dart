import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

final tips = [
  {
    'icon': Icons.light_mode,
    'title': 'Good Lighting',
    'description':
        'Make sure your photo is well-lit to show all details clearly.',
    "iconBackgroundColor": Colors.amber.shade100,
    "iconColor": Colors.amber.shade800,
  },
  {
    'icon': Icons.visibility,
    'title': 'Clear View',
    'description': 'Capture the issue clearly as the main focus of the image.',
    "iconBackgroundColor": Colors.green.shade100,
    "iconColor": Colors.green.shade800,
  },
  {
    'icon': Icons.map,
    'title': 'Context Matters',
    'description': 'Include surrounding area to help locate the issue.',
    'iconBackgroundColor': Colors.blue.shade100,
    'iconColor': Colors.blue.shade800,
  },
  {
    'icon': Icons.description,
    'title': 'Add Details',
    'description':
        'Describe what happened or any additional important information.',
    'iconBackgroundColor': Colors.purple.shade100,
    'iconColor': Colors.purple.shade800,
  },
];

class SubmitReportTips extends StatelessWidget {
  const SubmitReportTips({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.lightbulb_outline,
        color: Theme.of(context).colorScheme.primary,
        size: 22.sp,
      ),
      onPressed: () => _showTipsDialog(context),
      tooltip: AppLocalizations.of(context)!.reportingTips,
    );
  }

  void _showTipsDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.tips_and_updates,
                          color: colorScheme.primary,
                          size: 24.sp,
                        ),
                      ),
                      horizontalSpace(12.w),
                      Expanded(
                        child: Text(
                          localization.reportingTips,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Divider(height: 1, thickness: 1, color: colorScheme.outline),
                  verticalSpace(10),

                  for (final tip in tips) ...[
                    _buildTipCard(
                      context: context,
                      icon: tip['icon'] as IconData,
                      title: tip['title'] as String,
                      description: tip['description'] as String,
                      iconBackgroundColor: (tip['iconBackgroundColor'] as Color)
                          .withValues(alpha: 0.1),
                      iconColor: (tip['iconColor'] as Color).withValues(
                        alpha: 0.8,
                      ),
                    ),
                    if (tip != tips.last) ...[horizontalSpace(16.h)],
                  ],
                  horizontalSpace(24.h),
                  BaseButton(
                    onPressed: () => Navigator.pop(context),
                    text: localization.gotItConfirmText,
                    textStyle: textTheme.bodyLarge!.copyWith(
                      color: colorScheme.surface,
                      fontWeight: FontWeight.bold,
                    ),
                    horizontalPadding: 24.w,
                    borderColor: colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildTipCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color iconBackgroundColor,
    required Color iconColor,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: iconBackgroundColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 20.sp, color: iconColor),
        ),
        horizontalSpace(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              horizontalSpace(2.h),
              Text(
                description,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: .4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
