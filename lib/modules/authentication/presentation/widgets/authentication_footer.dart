import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/helpers/spacing.dart';

class AuthenticationFooter extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback? onTap;
  final bool isEnabled;
  final String? timerText;

  const AuthenticationFooter({
    super.key,
    required this.questionText,
    required this.actionText,
    this.onTap,
    this.isEnabled = true,
    this.timerText,
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
          onTap: isEnabled ? onTap : null,
          child: Text(
            timerText ?? actionText,
            style: textStyles.bodySmall?.copyWith(
              color: isEnabled 
                ? colorScheme.primary 
                : colorScheme.primary.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
