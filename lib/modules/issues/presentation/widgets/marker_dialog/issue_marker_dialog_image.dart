import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueMarkerDialogImage extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double borderRadius;

  const IssueMarkerDialogImage({
    super.key,
    required this.imageUrl,
    this.height = 150,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (imageUrl == null) {
      return _buildErrorPlaceholder(colorScheme);
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius.r),
        topRight: Radius.circular(borderRadius.r),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        height: height.h,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildLoadingPlaceholder(colorScheme),
        errorWidget: (context, url, error) => _buildErrorPlaceholder(colorScheme),
      ),
    );
  }

  Widget _buildLoadingPlaceholder(ColorScheme colorScheme) {
    return Container(
      height: height.h,
      width: double.infinity,
      color: colorScheme.surfaceVariant,
      child: Center(
        child: CircularProgressIndicator(
          color: colorScheme.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder(ColorScheme colorScheme) {
    return Container(
      height: height.h,
      width: double.infinity,
      color: colorScheme.surfaceContainerHighest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            size: 48.r,
            color: colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 8.h),
          Text(
            'Image not available',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}