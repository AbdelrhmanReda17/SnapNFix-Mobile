import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/image_builder.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

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
      return _buildErrorPlaceholder(context, colorScheme);
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius.r),
        topRight: Radius.circular(borderRadius.r),
      ),
      child: ImageBuilder.buildImage(
        imageName: imageUrl,
        fit: BoxFit.cover,
        colorScheme: colorScheme,
        width: double.infinity,
        height: height.h,
        loadingBuilder: (colorScheme) => _buildLoadingPlaceholder(colorScheme),
        errorBuilder: (context, colorScheme) => _buildErrorPlaceholder(context, colorScheme),
      ),
      // CachedNetworkImage(
      //   imageUrl: imageUrl!,
      //   height: height.h,
      //   width: double.infinity,
      //   fit: BoxFit.cover,
      //   placeholder: (context, url) => _buildLoadingPlaceholder(colorScheme),
      //   errorWidget: (context, url, error) => _buildErrorPlaceholder(context, colorScheme),
      // ),
    );
  }

  Widget _buildLoadingPlaceholder(ColorScheme colorScheme) {
    return Container(
      height: height.h,
      width: double.infinity,
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: CircularProgressIndicator(
          color: colorScheme.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder(BuildContext context, ColorScheme colorScheme) {
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
          verticalSpace(8),
          Text(
            AppLocalizations.of(context)!.imageNotAvailable,
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