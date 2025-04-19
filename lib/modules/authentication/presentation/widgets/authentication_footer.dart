import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/helpers/spacing.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionText,
          style: textStyles.bodySmall?.copyWith(
            color: colorScheme.secondary,
          ),
        ),
        horizontalSpace(2.w),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: textStyles.bodySmall?.copyWith(color: colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
