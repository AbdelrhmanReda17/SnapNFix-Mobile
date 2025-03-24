import 'package:flutter/material.dart';
import 'package:snapnfix/core/theming/colors.dart';

class ApplicationFloatingActionButton extends StatelessWidget {
  const ApplicationFloatingActionButton({
    super.key,
    required this.isActive,
    required this.onItemSelected,
  });

  final bool isActive;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 2,
      onPressed: () => onItemSelected(isActive ? 0 : 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: ColorsManager.primaryColor,
      child: Icon(isActive ? Icons.close : Icons.add, color: Colors.white),
    );
  }
}
