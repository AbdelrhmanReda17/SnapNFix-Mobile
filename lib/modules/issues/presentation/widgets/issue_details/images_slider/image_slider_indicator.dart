import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSliderIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Function(int) onDotTapped;

  const ImageSliderIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.onDotTapped,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 30.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          itemCount,
          (index) => _buildDot(index, colorScheme),
        ),
      ),
    );
  }

  Widget _buildDot(int index, ColorScheme colorScheme) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onDotTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        height: isActive ? 10.h : 8.h,
        width: isActive ? 18.w : 8.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isActive ? 4.r : 4.r),
          color:
              isActive
                  ? colorScheme.primary
                  : colorScheme.secondary.withValues(alpha: 0.2),
          boxShadow:
              isActive
                  ? [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
      ),
    );
  }
}
