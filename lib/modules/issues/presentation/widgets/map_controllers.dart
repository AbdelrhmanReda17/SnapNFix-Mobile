import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapControllers extends StatelessWidget {
  final VoidCallback onSearchTap;

  const MapControllers({super.key, required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: 10.h,
      left: 10.w,
      child: Column(
        children: [
          _MapButton(
            icon: Icons.filter_list,
            onTap: onSearchTap,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _MapButton({
    required this.icon,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 36.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            icon,
            color: const Color.fromARGB(255, 90, 89, 89),
            size: 24.r,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
