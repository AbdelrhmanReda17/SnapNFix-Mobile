import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

class QuickActionsPanel extends StatelessWidget {
  const QuickActionsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildActionItem(
                        context,
                        Icons.add_circle_outline,
                        "Report Issue",
                        Routes.submitReport,
                        colorScheme.primary,
                      ),
                      _buildActionItem(
                        context,
                        Icons.checklist_rounded,
                        localization.myReports,
                        Routes.userReports,
                        colorScheme.tertiary,
                      ),
                      _buildActionItem(
                        context,
                        Icons.map_outlined,
                        "View Map",
                        Routes.map,
                        colorScheme.secondary,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      _buildActionItem(
                        context,
                        Icons.trending_up,
                        'Analytics',
                        Routes.settings,
                        Colors.teal,
                      ),
                      _buildActionItem(
                        context,
                        Icons.notifications_outlined,
                        'Notifications',
                        Routes.settings,
                        Colors.amber.shade700,
                      ),
                      _buildActionItem(
                        context,
                        Icons.help_outline,
                        'Help',
                        Routes.settings,
                        Colors.blueGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    IconData icon,
    String label,
    String route,
    Color color,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.go(route),
        child: Column(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
