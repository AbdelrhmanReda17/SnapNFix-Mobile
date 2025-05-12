import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

enum ToastType { info, success, error, warning }

class BaseToast {
  static void show({
    required BuildContext context,
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 1),
    double? width,
    double? bottomMargin,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final messageWidth = width ?? screenWidth * 0.5;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.only(
          bottom: bottomMargin ?? 16.h,
          left: (screenWidth - messageWidth) / 2,
          right: (screenWidth - messageWidth) / 2,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        duration: duration,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getIconForToastType(type),
            horizontalSpace(8),
            Text(
              maxLines: 1,
              textWidthBasis: TextWidthBasis.longestLine,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              textAlign: TextAlign.start,
              ' ${message.length > 23 ? "${message.substring(0, 20)}..." : message}',
              style: TextStyle(fontSize: 13.sp, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: _getColorForToastType(type),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }

  static Color _getColorForToastType(ToastType type) {
    switch (type) {
      case ToastType.info:
        return Colors.blue;
      case ToastType.success:
        return Colors.green;
      case ToastType.error:
        return Colors.red;
      case ToastType.warning:
        return Colors.orange;
    }
  }

  static Widget _getIconForToastType(ToastType type) {
    IconData iconData;
    switch (type) {
      case ToastType.info:
        iconData = Icons.info_outline;
        break;
      case ToastType.success:
        iconData = Icons.check_circle_outline;
        break;
      case ToastType.error:
        iconData = Icons.error_outline;
        break;
      case ToastType.warning:
        iconData = Icons.warning_amber_outlined;
        break;
    }

    return Icon(iconData, color: Colors.white, size: 18.sp);
  }
}
