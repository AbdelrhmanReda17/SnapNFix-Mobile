import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/utils/helpers/image_builder.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorScheme.onSurface.withValues(alpha: 0.85),
      body: GestureDetector(
        onTap: () => context.pop(),
        child: Stack(
          children: [
            Positioned(
              top: 40.h,
              right: 16.w,
              child: IconButton(
                icon: Icon(Icons.close, color: colorScheme.surface, size: 28.r),
                onPressed: () => context.pop(),
              ),
            ),

            // Full screen image
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: ImageBuilder.buildImage(
                    imageName: imageUrl,
                    fit: BoxFit.contain,
                    colorScheme: colorScheme,
                    errorBuilder:
                        (context, colorScheme) =>
                            _buildFullscreenErrorPlaceholder(
                              context,
                              colorScheme,
                              localization.imageNotAvailable,
                            ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullscreenErrorPlaceholder(
    BuildContext context,
    ColorScheme colorScheme,
    String errorMessage,
  ) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.broken_image, color: colorScheme.surface, size: 48.r),
          verticalSpace(16),
          Text(
            errorMessage,
            style: TextStyle(color: colorScheme.surface, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
