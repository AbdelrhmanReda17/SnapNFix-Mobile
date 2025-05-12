import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A circular button that displays an area's first letter with styling based on selection state.
class AreaCircleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ColorScheme colorScheme;

  const AreaCircleButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.27 : 1.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? colorScheme.primary.withOpacity(0.8) : colorScheme.onPrimary,
            width: 3.w,
          ),
        ),
        child: Center(
          child: Container(
            width: 54.w,
            height: 54.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8.r,
                colors: [const Color(0xFF23576D), colorScheme.primary],
                stops: const [0.0, 1.0],
              ),
              border: isSelected ? Border.all(color: Colors.white, width: 1.5.w) : null,
            ),
            child: Center(
              child: Text(
                label[0],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 