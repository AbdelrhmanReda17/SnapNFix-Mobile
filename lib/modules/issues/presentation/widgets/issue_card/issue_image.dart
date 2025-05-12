import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/marker_dialog/issue_marker_dialog_image.dart';

class IssueImage extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double borderRadius;
  final Widget? overlay;

  const IssueImage({
    super.key,
    required this.imageUrl,
    this.height = 150,
    this.borderRadius = 16,
    this.overlay,
  });

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}