import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_alert_component/alert_type.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/core/utils/helpers/responsive_dimensions.dart';

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
    final containerColor = alertType.getContainerColor(context);
    final textColor = alertType.getTextColor(context);

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
              // If there's no cancel button and dialog is dismissed, treat as confirm
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
                    color: containerColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, dimensions, textColor),
                      verticalSpace(dimensions.isTablet ? 16 : 12),
                      _buildMessageContent(
                        dimensions,
                        dialogMaxHeight,
                        textColor,
                      ),
                      verticalSpace(dimensions.isTablet ? 20 : 16),
                      _buildActionButtons(
                        context,
                        colorScheme,
                        dimensions,
                        textColor,
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
    Color textColor,
  ) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                alertType.icon,
                color: textColor,
                size: dimensions.isTablet ? 24.sp : 20.sp,
              ),
              horizontalSpace(dimensions.isTablet ? 12 : 8),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: dimensions.isTablet ? 18.sp : 16.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.close,
            color: textColor,
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
    Color textColor,
  ) {
    final maxMessageHeight = maxDialogHeight * 0.6;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxMessageHeight),
      child: SingleChildScrollView(
        child: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: dimensions.isTablet ? 16.sp : 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    ColorScheme colorScheme,
    ResponsiveDimensions dimensions,
    Color buttonColor,
  ) {
    // Responsive button layout
    if (dimensions.isSmallScreen &&
        (confirmText.length > 8 || (cancelText?.length ?? 0) > 8)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildConfirmButton(context, colorScheme, dimensions, buttonColor),
          if (showCancelButton) ...[
            verticalSpace(8),
            _buildCancelButton(context, dimensions, buttonColor),
          ],
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showCancelButton) ...[
          _buildCancelButton(context, dimensions, buttonColor),
          horizontalSpace(dimensions.isTablet ? 12 : 8),
        ],
        _buildConfirmButton(context, colorScheme, dimensions, buttonColor),
      ],
    );
  }

  Widget _buildConfirmButton(
    BuildContext context,
    ColorScheme colorScheme,
    ResponsiveDimensions dimensions,
    Color buttonColor,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
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
      ),
    );
  }

  Widget _buildCancelButton(
    BuildContext context,
    ResponsiveDimensions dimensions,
    Color buttonColor,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: buttonColor),
        ),
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
          color: buttonColor,
          fontSize: dimensions.isTablet ? 16.sp : 14.sp,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
