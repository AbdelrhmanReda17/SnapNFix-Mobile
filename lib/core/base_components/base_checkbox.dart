import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  const BaseCheckbox({super.key, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 24.h,
      width: 24.w,
      child: Checkbox(
        activeColor: colorScheme.primary.withValues(alpha: 0.3),
        hoverColor: colorScheme.tertiary.withValues(alpha: 0.3),
        checkColor: colorScheme.tertiary.withValues(alpha: 0.3),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.tertiary.withValues(alpha: 0.3);
        }),
        side: BorderSide(color: colorScheme.tertiary.withValues(alpha: 0.3)),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
