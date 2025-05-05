import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/extensions/navigation.dart';

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

void baseDialog({
  required BuildContext context,
  required String title,
  required String message,
  required AlertType alertType,
  required String confirmText,
  Function()? onCancel,
  required Function()? onConfirm,
  bool showCancelButton = true,
  String? cancelText,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          if (!showCancelButton && onConfirm != null) {
            onConfirm();
            return true;
          }
          return showCancelButton;
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: alertType.containerColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(alertType.icon, color: alertType.textColor),
                        SizedBox(width: 8),
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: alertType.textColor,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: alertType.textColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  message,
                  style: TextStyle(
                    color: alertType.textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: alertType.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                      ),
                      onPressed: () {
                        context.pop();
                        if (onConfirm != null) {
                          onConfirm();
                        }
                      },
                      child: Text(
                        confirmText,
                        style: TextStyle(
                          color: colorScheme.surface,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    showCancelButton
                        ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: alertType.buttonColor.withValues(
                              alpha: 0.1,
                            ),
                            foregroundColor: alertType.buttonColor.withValues(
                              alpha: 0.1,
                            ),
                            shadowColor: alertType.buttonColor.withValues(
                              alpha: 0.1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                          ),
                          onPressed: () {
                            if (onCancel != null) {
                              onCancel();
                            }
                            Navigator.pop(context);
                          },
                          child: Text(
                            cancelText ?? 'Cancel',
                            style: TextStyle(
                              color: alertType.buttonColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                        : SizedBox.shrink(),
                  ],
                ),

                // Text(
                //   'Hello World',
                //   style: TextStyle(
                //     color: alertType.textColor,
                //     fontSize: 18.sp,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    },
  ).then((value) {
    // Handle dialog dismissal (clicking outside)
    if (value == null && !showCancelButton && onConfirm != null) {
      onConfirm();
    }
  });
}
