import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/text_styles.dart';

class AuthenticationFooter extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onTap;

  const AuthenticationFooter({
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
