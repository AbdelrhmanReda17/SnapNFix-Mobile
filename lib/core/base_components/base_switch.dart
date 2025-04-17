import 'package:flutter/material.dart';

class BaseSwitch extends StatelessWidget {
  const BaseSwitch({super.key, required this.value, this.onChanged});
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Switch(
      value: value,
      onChanged: onChanged,
      padding: const EdgeInsets.all(0),
      activeColor: colorScheme.primary,
      inactiveTrackColor: colorScheme.primary.withValues(alpha: 0.3),
      inactiveThumbColor: colorScheme.primary.withValues(alpha: 0.5),
    );
  }
}
