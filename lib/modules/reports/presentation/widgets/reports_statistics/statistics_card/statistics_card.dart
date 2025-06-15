import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/responsive_dimensions.dart';

// Class to hold card style properties
class CardStyle {
  final Color? backgroundColor;
  final LinearGradient? gradient;

  CardStyle({this.backgroundColor, this.gradient});
}

class StatisticsCard extends StatefulWidget {
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

  const StatisticsCard({
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
  State<StatisticsCard> createState() => _StatisticsCardState();
}

class _StatisticsCardState extends State<StatisticsCard>
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
    final dimensions = getResponsiveDimensions(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final theme = Theme.of(context);
        final isDarkMode = theme.brightness == Brightness.dark;
        final dimensions = getResponsiveDimensions(context);

        return GestureDetector(
          onTapDown: (_) => _onTapDown(),
          onTapUp: (_) => _onTapUp(),
          onTapCancel: () => _onTapUp(),
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: Container(
              width: _getCardWidth(dimensions),
              constraints: _getCardConstraints(dimensions),
              padding: _getCardPadding(dimensions),
              decoration: BoxDecoration(
                gradient: widget.isLoading ? null : widget.cardStyle.gradient,
                color:
                    widget.isLoading
                        ? theme.colorScheme.primaryContainer
                        : widget.cardStyle.backgroundColor,
                borderRadius: BorderRadius.circular(
                  _getBorderRadius(dimensions),
                ),
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
                      ? _buildLoadingState(theme, dimensions)
                      : _buildCardContent(theme, dimensions),
            ),
          ),
        );
      },
    );
  }

  // Responsive card width
  double _getCardWidth(ResponsiveDimensions dimensions) {
    if (dimensions.isTablet) {
      return dimensions.isLandscape
          ? dimensions.screenWidth * 0.35
          : dimensions.screenWidth * 0.45;
    }
    return dimensions.screenWidth * 0.75;
  }

  // Responsive card constraints
  BoxConstraints _getCardConstraints(ResponsiveDimensions dimensions) {
    if (dimensions.isTablet) {
      return BoxConstraints(
        minWidth: 300.w,
        maxWidth: 400.w,
        minHeight: 200.h,
        maxHeight: 280.h,
      );
    }

    if (dimensions.screenWidth < 350) {
      return BoxConstraints(
        minWidth: 240.w,
        maxWidth: 280.w,
        minHeight: 160.h,
        maxHeight: 200.h,
      );
    } else if (dimensions.screenWidth < 400) {
      return BoxConstraints(
        minWidth: 260.w,
        maxWidth: 320.w,
        minHeight: 180.h,
        maxHeight: 220.h,
      );
    } else {
      return BoxConstraints(
        minWidth: 280.w,
        maxWidth: 350.w,
        minHeight: 190.h,
        maxHeight: 240.h,
      );
    }
  }

  // Responsive padding
  EdgeInsets _getCardPadding(ResponsiveDimensions dimensions) {
    if (dimensions.isTablet) {
      return EdgeInsets.all(20.w);
    }
    return dimensions.screenWidth < 350
        ? EdgeInsets.all(12.w)
        : EdgeInsets.all(16.w);
  }

  // Responsive border radius
  double _getBorderRadius(ResponsiveDimensions dimensions) {
    if (dimensions.isTablet) {
      return 24.r;
    }
    return dimensions.screenWidth < 350 ? 16.r : 20.r;
  }

  Widget _buildLoadingState(ThemeData theme, ResponsiveDimensions dimensions) {
    final indicatorSize =
        dimensions.isTablet
            ? 28.0
            : (dimensions.screenWidth < 350 ? 20.0 : 24.0);
    final fontSize =
        dimensions.isTablet
            ? 14.sp
            : (dimensions.screenWidth < 350 ? 11.sp : 12.sp);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: indicatorSize,
            height: indicatorSize,
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
              strokeWidth: dimensions.isTablet ? 3.0 : 2.5,
            ),
          ),
          SizedBox(height: dimensions.isTablet ? 16.h : 12.h),
          Text(
            'Loading...',
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(ThemeData theme, ResponsiveDimensions dimensions) {
    final isDarkMode = theme.brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : theme.colorScheme.onPrimary;
    final fontSizes = getResponsiveFontSizes(dimensions);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(theme, textColor, dimensions, fontSizes),
        SizedBox(height: dimensions.isTablet ? 12.h : 8.h), // Reduced spacing
        Expanded(
          flex: 2,
          child: _buildValueSection(theme, textColor, fontSizes),
        ),
        SizedBox(height: dimensions.isTablet ? 8.h : 4.h), // Reduced spacing
        dimensions.screenHeight < 650
            ? SizedBox.shrink()
            : _buildDescription(theme, textColor, fontSizes),
        SizedBox(height: dimensions.isTablet ? 12.h : 8.h), // Reduced spacing
        _buildButton(theme, isDarkMode, textColor, dimensions, fontSizes),
      ],
    );
  }

  Widget _buildHeader(
    ThemeData theme,
    Color textColor,
    ResponsiveDimensions dimensions,
    ResponsiveFontSizes fontSizes,
  ) {
    return Row(
      children: [
        Icon(
          widget.iconData,
          size: dimensions.isTablet ? 28.sp : 24.sp,
          color: textColor,
        ),
        SizedBox(width: dimensions.isTablet ? 12.w : 8.w),
        Expanded(
          child: Text(
            widget.title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: fontSizes.title,
            ),
            maxLines: dimensions.isTablet ? 2 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.imageAsset != null) ...[
          SizedBox(width: 8.w),
          Image.asset(
            widget.imageAsset!,
            width: dimensions.isTablet ? 60.w : 50.w,
            height: dimensions.isTablet ? 60.w : 50.w,
            fit: BoxFit.contain,
          ),
        ],
      ],
    );
  }

  Widget _buildValueSection(
    ThemeData theme,
    Color textColor,
    ResponsiveFontSizes fontSizes,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Flexible(
          flex: 3,
          child: Text(
            widget.mainValue,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSizes.value,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 4.w),
        Flexible(
          flex: 1,
          child: Text(
            widget.valueSuffix,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: textColor.withValues(alpha: 0.8),
              fontSize: fontSizes.suffix,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(
    ThemeData theme,
    Color textColor,
    ResponsiveFontSizes fontSizes,
  ) {
    return Flexible(
      child: Text(
        widget.description,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: textColor.withValues(alpha: 0.9),
          fontSize: fontSizes.description,
          height: 1.3,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildButton(
    ThemeData theme,
    bool isDarkMode,
    Color textColor,
    ResponsiveDimensions dimensions,
    ResponsiveFontSizes fontSizes,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onButtonPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode ? theme.colorScheme.secondary : textColor,
          foregroundColor:
              isDarkMode
                  ? Colors.white
                  : widget.cardStyle.gradient?.colors.last ??
                      theme.colorScheme.primary,
          padding: EdgeInsets.symmetric(
            vertical: dimensions.isTablet ? 14.h : 10.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              dimensions.isTablet ? 12.r : 10.r,
            ),
          ),
          elevation: 0,
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSizes.button,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
