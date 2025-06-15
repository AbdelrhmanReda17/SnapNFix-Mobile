import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/core.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/presentation/widgets/issue_severity_icons_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class IssueCommentsCard extends StatelessWidget {
  final bool isSnapReport;
  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final DateTime? createdAt;
  final String? severity;
  final String comment;

  const IssueCommentsCard({
    super.key,
    required this.isSnapReport,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.severity,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final IssueSeverity issueSeverity = _mapSeverityStringToEnum(severity);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80.w,
              height: 80.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child:
                    isSnapReport && imageUrl != null && imageUrl!.isNotEmpty
                        ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Container(
                                color: colorScheme.surface,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: colorScheme.primary,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                color: colorScheme.surface,
                                child: Icon(
                                  Icons.broken_image,
                                  color: colorScheme.outline,
                                ),
                              ),
                        )
                        : Container(
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            isSnapReport ? Icons.photo_camera : Icons.person,
                            color: colorScheme.primary,
                            size: 40.sp,
                          ),
                        ),
              ),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _formatName(),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      if (createdAt != null)
                        Text(
                          _formatDate(createdAt!),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                    ],
                  ),

                  IssueSeverityIconsIndicator(
                    severity: issueSeverity,
                    iconSize: 14,
                    showLabel: true,
                    spacing: 2,
                  ),

                  SizedBox(height: 8.h),
                  Text(
                    comment,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatName() {
    final firstNameValue = firstName?.trim() ?? '';
    final lastNameValue = lastName?.trim() ?? '';

    if (firstNameValue.isEmpty && lastNameValue.isEmpty) {
      return 'Anonymous';
    } else if (firstNameValue.isEmpty) {
      return lastNameValue;
    } else if (lastNameValue.isEmpty) {
      return firstNameValue;
    } else {
      return '$firstNameValue $lastNameValue';
    }
  }

  IssueSeverity _mapSeverityStringToEnum(String? severityStr) {
    if (severityStr == null) return IssueSeverity.notSpecified;

    switch (severityStr.toLowerCase()) {
      case 'low':
        return IssueSeverity.low;
      case 'medium':
        return IssueSeverity.medium;
      case 'high':
        return IssueSeverity.high;
      default:
        return IssueSeverity.notSpecified;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
