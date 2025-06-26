import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/index.dart';
import 'package:snapnfix/presentation/widgets/issue_severity_icons_indicator.dart';

class AreaIssueCard extends StatelessWidget {
  final AreaIssue issue;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final bool showSeverity;
  final bool showImage;

  const AreaIssueCard({
    super.key,
    required this.issue,
    this.onTap,
    this.margin,
    this.showSeverity = true,
    this.showImage = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showImage) _buildIssueImageSection(context),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, localization),
                    SizedBox(height: 8.h),
                    _buildFooter(context, localization),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIssueImageSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 80.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        child: Stack(
          children: [
            ImageBuilder.buildImage(
              imageName: issue.imagePath,
              height: 80.h,
              width: double.infinity,
              fit: BoxFit.cover,
              colorScheme: colorScheme,
            ),
            // Status overlay
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        color: _getStatusColor(issue.status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _getStatusDisplayName(issue.status),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations localization) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        // Category icon
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            _getCategoryIcon(issue.category),
            size: 16.sp,
            color: colorScheme.primary,
          ),
        ),

        SizedBox(width: 10.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                issue.category.getLocalizedName(localization),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                  height: 1.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Text(
                '#${issue.id.substring(0, 8).toUpperCase()}',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),

        // Creation date chip
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            _formatDate(issue.createdAt),
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, AppLocalizations localization) {
    return Row(
      children: [
        // Severity indicator
        if (showSeverity) ...[
          IssueSeverityIconsIndicator(
            severity: issue.severity,
            iconSize: 12,
            showLabel: false,
            spacing: 4,
          ),

          SizedBox(width: 8.w),

          Text(
            issue.severity.getLocalizedName(localization),
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: issue.severity.color,
            ),
          ),

          const Spacer(),
        ],

        // Status badge (only show if no image to avoid duplication)
        if (!showImage)
          IssueStatusBadge(
            status: issue.status,
            size: 14,
            showIcon: true,
            showText: true,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          ),
      ],
    );
  }

  // Helper methods
  Color _getStatusColor(IssueStatus status) {
    switch (status) {
      case IssueStatus.pending:
        return Colors.orange;
      case IssueStatus.inProgress:
        return Colors.blue;
      case IssueStatus.completed:
        return Colors.green;
    }
  }

  String _getStatusDisplayName(IssueStatus status) {
    switch (status) {
      case IssueStatus.pending:
        return 'Pending';
      case IssueStatus.inProgress:
        return 'In Progress';
      case IssueStatus.completed:
        return 'Done';
    }
  }

  IconData _getCategoryIcon(category) {
    final categoryString = category.toString().split('.').last.toLowerCase();
    switch (categoryString) {
      case 'garbage':
        return Icons.delete_outline_rounded;
      case 'defectivemanhole':
        return Icons.engineering_outlined;
      case 'pothole':
        return Icons.construction_outlined;
      case 'streetlight':
        return Icons.lightbulb_outline_rounded;
      case 'waterleak':
        return Icons.water_drop_outlined;
      case 'roadcrack':
        return Icons.linear_scale_outlined;
      default:
        return Icons.report_problem_outlined;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}
