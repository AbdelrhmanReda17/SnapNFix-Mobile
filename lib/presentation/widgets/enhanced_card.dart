import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Class to hold card style properties
class CardStyle {
  final Color? backgroundColor;
  final LinearGradient? gradient;

  CardStyle({this.backgroundColor, this.gradient});
}

class EnhancedCard extends StatefulWidget {
  final String title;
  final String mainValue;
  final String valueSuffix;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final String? imageAsset;
  final bool isLoading;
  final CardStyle cardStyle;
  final IconData iconData;

  const EnhancedCard({
    super.key,
    required this.title,
    required this.mainValue,
    required this.valueSuffix,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
    required this.isLoading,
    required this.cardStyle,
    required this.iconData,
    this.imageAsset,
  });

  @override
  State<EnhancedCard> createState() => _EnhancedCardState();
}

class _EnhancedCardState extends State<EnhancedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown() {
    _controller.forward();
  }

  void _onTapUp() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => _onTapDown(),
      onTapUp: (_) => _onTapUp(),
      onTapCancel: () => _onTapUp(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: Container(
          width: 300.w,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: widget.isLoading ? null : widget.cardStyle.gradient,
            color:
                widget.isLoading
                    ? theme.colorScheme.surfaceVariant
                    : widget.cardStyle.backgroundColor,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(
                  alpha: isDarkMode ? 0.3 : 0.1,
                ),
                spreadRadius: isDarkMode ? 1 : 2,
                blurRadius: isDarkMode ? 3 : 8,
                offset: Offset(0, isDarkMode ? 2 : 3),
              ),
            ],
          ),
          child:
              widget.isLoading
                  ? _buildLoadingState(theme)
                  : _buildCardContent(theme),
        ),
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: theme.colorScheme.primary,
            strokeWidth: 3.0,
          ),
          SizedBox(height: 16.h),
          Text('Loading...', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildCardContent(ThemeData theme) {
    final isDarkMode = theme.brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : theme.colorScheme.onPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(widget.iconData, size: 28.sp, color: textColor),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                widget.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.imageAsset != null) ...[
              Image.asset(widget.imageAsset!, width: 60.w, height: 60.w),
            ],
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              widget.mainValue,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 32.sp,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              widget.valueSuffix,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: textColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Expanded(
          child: Text(
            widget.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: textColor.withOpacity(0.9),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isDarkMode ? theme.colorScheme.secondary : textColor,
              foregroundColor:
                  isDarkMode
                      ? Colors.white
                      : widget.cardStyle.gradient?.colors.last ??
                          theme.colorScheme.primary,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              widget.buttonText,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
          ),
        ),
      ],
    );
  }
}
