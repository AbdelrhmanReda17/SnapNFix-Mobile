import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/base_components/base_button.dart';

class IssueMarkerDialogAction extends StatelessWidget {
  final VoidCallback? onTap;

  const IssueMarkerDialogAction({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: BaseButton(
        onPressed: onTap,
        text: 'Fast Report',
        backgroundColor: colorScheme.primary,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}