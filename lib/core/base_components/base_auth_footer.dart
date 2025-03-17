import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/spacing.dart';
import '../theming/text_styles.dart';

class BaseAuthFooter extends StatelessWidget {
  final String questionText;
  final String actionText;

  final VoidCallback onTap;

  const BaseAuthFooter({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionText,
          style: TextStyles.font12Normal(TextColor.tertiaryColor),
        ),
        horizontalSpace(2.w),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyles.font12Medium(TextColor.primaryColor),
          ),
        ),
      ],
    );
  }
}
