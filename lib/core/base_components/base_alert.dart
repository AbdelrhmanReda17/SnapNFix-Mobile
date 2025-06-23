import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/core/utils/helpers/responsive_dimensions.dart';

enum AlertType {
  success(
    containerColor: Color(0x33027243),
    textColor: Color(0xFF027243),
    buttonColor: Color(0xFF027243),
    icon: Icons.check_circle_outline,
  ),
  error(
    containerColor: Color(0x33AC2634),
    textColor: Color(0xFFAC2634),
    buttonColor: Color(0xFFAC2634),
    icon: Icons.error_outline,
  ),
  info(
    containerColor: Color(0xFFF0F6FF),
    textColor: Color(0xFF0F61AC),
    buttonColor: Color(0xFF0F61AC),
    icon: Icons.info_outline,
  ),
  warning(
    containerColor: Color(0x33B84A1F),
    textColor: Color(0xFFB84A1F),
    buttonColor: Color(0xFFB84A1F),
    icon: Icons.warning,
  );

  final Color containerColor;
  final Color textColor;
  final Color buttonColor;
  final IconData icon;

  const AlertType({
    required this.containerColor,
    required this.textColor,
    required this.buttonColor,
    required this.icon,
  });
}

Future<bool?> baseDialog({
  required BuildContext context,
  required String title,
  required String message,
  required AlertType alertType,
  required String confirmText,
  Function()? onCancel,
  Function()? onConfirm,
  bool showCancelButton = true,
  String? cancelText,
  bool barrierDismissible = true,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: true,
    builder: (context) {
      return _BaseAlertDialog(
        title: title,
        message: message,
        alertType: alertType,
        confirmText: confirmText,
        cancelText: cancelText,
        showCancelButton: showCancelButton,
        onConfirm: onConfirm,
        onCancel: onCancel,
      );
    },
  );
}

class _BaseAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final AlertType alertType;
  final String confirmText;
  final String? cancelText;
  final bool showCancelButton;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const _BaseAlertDialog({
    required this.title,
    required this.message,
    required this.alertType,
    required this.confirmText,
    this.cancelText,
    required this.showCancelButton,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return LayoutBuilder(
      builder: (context, constraints) {
        final dimensions = getResponsiveDimensions(context);

        // Responsive dialog constraints
        final dialogMaxWidth =
            dimensions.isTablet
                ? dimensions.screenWidth * 0.6
                : dimensions.screenWidth * 0.85;

        final dialogMinWidth = dimensions.isTablet ? 400.0 : 280.0;
        final dialogMaxHeight = dimensions.screenHeight * 0.8;

        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop && !showCancelButton && onConfirm != null) {
              Future.microtask(() => onConfirm!());
            }
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: dialogMaxWidth,
                minWidth: dialogMinWidth,
                maxHeight: dialogMaxHeight,
              ),
              child: IntrinsicHeight(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: dimensions.isTablet ? 24.w : 16.w,
                    vertical: dimensions.isTablet ? 24.h : 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: alertType.containerColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                        isRTL
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, dimensions, isRTL),
                      verticalSpace(dimensions.isTablet ? 16 : 12),
                      _buildMessageContent(dimensions, dialogMaxHeight, isRTL),
                      verticalSpace(dimensions.isTablet ? 20 : 16),
                      _buildActionButtons(
                        context,
                        colorScheme,
                        dimensions,
                        isRTL,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ResponsiveDimensions dimensions,
    bool isRTL,
  ) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Icon(
                alertType.icon,
                color: alertType.textColor,
                size: dimensions.isTablet ? 24.sp : 20.sp,
              ),
              horizontalSpace(dimensions.isTablet ? 12 : 8),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: alertType.textColor,
                    fontSize: dimensions.isTablet ? 18.sp : 16.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.close,
            color: alertType.textColor,
            size: dimensions.isTablet ? 24.sp : 20.sp,
          ),
          onPressed: () => _handleDialogDismiss(context, false),
          constraints: BoxConstraints(
            minWidth: dimensions.isTablet ? 40.w : 32.w,
            minHeight: dimensions.isTablet ? 40.h : 32.h,
          ),
          padding: EdgeInsets.all(dimensions.isTablet ? 8.w : 4.w),
        ),
      ],
    );
  }

  Widget _buildMessageContent(
    ResponsiveDimensions dimensions,
    double maxDialogHeight,
    bool isRTL,
  ) {
    final maxMessageHeight = maxDialogHeight * 0.6;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxMessageHeight),
      child: SingleChildScrollView(
        child: Text(
          message,
          style: TextStyle(
            color: alertType.textColor,
            fontSize: dimensions.isTablet ? 16.sp : 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
          textAlign: isRTL ? TextAlign.right : TextAlign.left,
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    ColorScheme colorScheme,
    ResponsiveDimensions dimensions,
    bool isRTL,
  ) {
    // Responsive button layout
    if (dimensions.isSmallScreen &&
        (confirmText.length > 8 || (cancelText?.length ?? 0) > 8)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildConfirmButton(context, colorScheme, dimensions, isRTL),
          if (showCancelButton) ...[
            verticalSpace(8),
            _buildCancelButton(context, dimensions, isRTL),
          ],
        ],
      );
    }

    // For RTL, we want to reverse the button order
    final buttons = [
      _buildConfirmButton(context, colorScheme, dimensions, isRTL),
      if (showCancelButton) ...[
        horizontalSpace(dimensions.isTablet ? 12 : 8),
        _buildCancelButton(context, dimensions, isRTL),
      ],
    ];

    return Row(
      mainAxisAlignment:
          isRTL ? MainAxisAlignment.start : MainAxisAlignment.end,
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: isRTL ? buttons.reversed.toList() : buttons,
    );
  }

  Widget _buildConfirmButton(
    BuildContext context,
    ColorScheme colorScheme,
    ResponsiveDimensions dimensions,
    bool isRTL,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: alertType.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(
          horizontal: dimensions.isTablet ? 24.w : 16.w,
          vertical: dimensions.isTablet ? 12.h : 8.h,
        ),
      ),
      onPressed: () => _handleDialogDismiss(context, true),
      child: Text(
        confirmText,
        style: TextStyle(
          color: colorScheme.surface,
          fontSize: dimensions.isTablet ? 16.sp : 14.sp,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      ),
    );
  }

  Widget _buildCancelButton(
    BuildContext context,
    ResponsiveDimensions dimensions,
    bool isRTL,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: alertType.buttonColor.withValues(alpha: 0.1),
        foregroundColor: alertType.buttonColor.withValues(alpha: 0.1),
        shadowColor: alertType.buttonColor.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(
          horizontal: dimensions.isTablet ? 24.w : 16.w,
          vertical: dimensions.isTablet ? 12.h : 8.h,
        ),
      ),
      onPressed: () {
        if (onCancel != null) {
          onCancel!();
        }
        Navigator.of(context).pop(false);
      },
      child: Text(
        cancelText ?? 'Cancel',
        style: TextStyle(
          color: alertType.buttonColor,
          fontSize: dimensions.isTablet ? 16.sp : 14.sp,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      ),
    );
  }

  void _handleDialogDismiss(BuildContext context, bool isConfirmed) {
    Navigator.of(context).pop(isConfirmed);

    // Execute callback after dialog is dismissed
    if (isConfirmed && onConfirm != null) {
      Future.microtask(() => onConfirm!());
    }
  }
}
