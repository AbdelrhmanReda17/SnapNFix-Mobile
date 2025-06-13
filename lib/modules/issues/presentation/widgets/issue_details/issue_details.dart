import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import './widgets/faq_item.dart';
import './widgets/status_badge.dart';
import './widgets/location_content.dart';
import './widgets/issue_info_content.dart';

class IssueDetails extends StatefulWidget {
  final Issue issue;
  const IssueDetails({super.key, required this.issue});

  @override
  State<IssueDetails> createState() => _IssueDetailsState();
}

class _IssueDetailsState extends State<IssueDetails> {
  bool _isLocationExpanded = false;
  bool _isIssueInfoExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and status badge
            _buildHeader(textStyles, colorScheme, localization),
            verticalSpace(24),

            FaqItem(
              title: 'Location Information',
              icon: Icons.location_on,
              isExpanded: _isLocationExpanded,
              onTap:
                  () => setState(
                    () => _isLocationExpanded = !_isLocationExpanded,
                  ),
              content: LocationContent(issue: widget.issue),
              colorScheme: colorScheme,
            ),

            SizedBox(height: 12.h),

            FaqItem(
              title: 'Issue Information',
              icon: Icons.info_outline,
              isExpanded: _isIssueInfoExpanded,
              onTap:
                  () => setState(
                    () => _isIssueInfoExpanded = !_isIssueInfoExpanded,
                  ),
              content: IssueInfoContent(
                issue: widget.issue,
                colorScheme: colorScheme,
                localization: localization,
              ),
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    TextTheme textStyles,
    ColorScheme colorScheme,
    AppLocalizations localization,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            localization.issueCategory(widget.issue.category.displayName),
            style: textStyles.headlineMedium?.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        StatusBadge(
          status: widget.issue.status,
          colorScheme: colorScheme,
          localization: localization,
        ),
      ],
    );
  }
}
