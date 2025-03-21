import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/theming/colors.dart';

class BaseCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  const BaseCheckbox({super.key, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.h,
      width: 24.w,
      child: Checkbox(
        activeColor: ColorsManager.primaryColor,
        hoverColor: ColorsManager.quaternaryColor,
        checkColor: ColorsManager.quaternaryColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return ColorsManager.primaryColor;
          }
          return ColorsManager.quaternaryColor;
        }),
        side: BorderSide(color: ColorsManager.quaternaryColor, width: 2),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
