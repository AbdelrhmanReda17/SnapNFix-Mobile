import 'package:flutter/material.dart';
import 'package:snapnfix/core/theming/colors.dart';

class BaseSwitch extends StatelessWidget {
  const BaseSwitch({super.key, required this.value, this.onChanged});
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      padding: const EdgeInsets.all(0),
      activeColor: ColorsManager.primaryColor,
      inactiveTrackColor: ColorsManager.grayColor,
      inactiveThumbColor: ColorsManager.whiteColor,
    );
  }
}
