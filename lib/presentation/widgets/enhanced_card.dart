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
        },        child: Container(
          width: MediaQuery.of(context).size.width * 0.75, 
          constraints: BoxConstraints(
            minWidth: 260.w,
            maxWidth: 320.w,
            minHeight: 180.h,
            maxHeight: 220.h,
          ),
          padding: EdgeInsets.all(16.w), 
          decoration: BoxDecoration(
            gradient: widget.isLoading ? null : widget.cardStyle.gradient,
            color:
                widget.isLoading
                    ? theme.colorScheme.surfaceVariant
                    : widget.cardStyle.backgroundColor,
            borderRadius: BorderRadius.circular(20.r), 
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
    final screenWidth = MediaQuery.of(context).size.width;
    final indicatorSize = screenWidth < 350 ? 20.0 : 24.0;
    final fontSize = screenWidth < 350 ? 11.sp : 12.sp;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: indicatorSize,
            height: indicatorSize,
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
              strokeWidth: 2.5,
            ),
          ),
          SizedBox(height: 12.h), 
          Text(
            'Loading...', 
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCardContent(ThemeData theme) {
    final isDarkMode = theme.brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : theme.colorScheme.onPrimary;
    final screenWidth = MediaQuery.of(context).size.width;
 
    final titleFontSize = screenWidth < 350 ? 14.sp : 15.sp;
    final valueFontSize = screenWidth < 350 ? 26.sp : 28.sp;
    final suffixFontSize = screenWidth < 350 ? 12.sp : 13.sp;
    final descriptionFontSize = screenWidth < 350 ? 11.sp : 12.sp;
    final buttonFontSize = screenWidth < 350 ? 12.sp : 13.sp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(widget.iconData, size: 24.sp, color: textColor), 
            SizedBox(width: 8.w), 
            Expanded(
              child: Text(
                widget.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: titleFontSize,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.imageAsset != null) ...[
              Image.asset(widget.imageAsset!, width: 50.w, height: 50.w), // Smaller image
            ],
          ],
        ),
        SizedBox(height: 12.h), 
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: Text(
                widget.mainValue,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: valueFontSize,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 4.w),
            Flexible(
              child: Text(
                widget.valueSuffix,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: textColor.withOpacity(0.8),
                  fontSize: suffixFontSize,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h), 
        Expanded(
          child: Text(
            widget.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: textColor.withOpacity(0.9),
              fontSize: descriptionFontSize,
              height: 1.3,
            ),
            maxLines: 3, 
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 12.h), 
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
              padding: EdgeInsets.symmetric(vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r), 
              ),
              elevation: 0,
            ),
            child: Text(
              widget.buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: buttonFontSize,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
