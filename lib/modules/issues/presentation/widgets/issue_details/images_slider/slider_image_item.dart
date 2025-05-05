import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/image_builder.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_details/images_slider/fullscreen_image_view.dart';

class SliderImageItem extends StatelessWidget {
  final String image;

  const SliderImageItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: GestureDetector(
            onTap: () => _showFullScreenImage(context, image),
            child: Hero(
              tag: 'issue_image_$image',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ImageBuilder.buildImage(
                    imageName: image,
                    fit: BoxFit.cover,
                    colorScheme: colorScheme,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                FullScreenImageView(imageUrl: imageUrl),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation.drive(
              Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
