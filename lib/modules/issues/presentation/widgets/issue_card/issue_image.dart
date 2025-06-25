import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_card/issue_status_badge.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/marker_dialog/issue_marker_dialog_image.dart';

class IssueImage extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double borderRadius;
  final Widget? overlay;
  final Issue issue;

  const IssueImage({
    super.key,
    required this.imageUrl,
    this.height = 150,
    this.borderRadius = 16,
    this.overlay,
    required this.issue,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius.r),
          child: IssueMarkerDialogImage(
            imageUrl: imageUrl,
            height: height,
            borderRadius: borderRadius,
          ),
        ),
        if (overlay != null) overlay!,
        Positioned(
          top: 12.r,
          right: 12.r,
          child: Row(children: [IssueStatusBadge(status: issue.status)]),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),            child: Text(
              issue.category.getLocalizedName(AppLocalizations.of(context)!),
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}