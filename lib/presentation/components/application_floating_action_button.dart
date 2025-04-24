import 'package:flutter/material.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return FloatingActionButton(
      heroTag: 'floatingActionButton',
      tooltip: isActive ? 'Close' : 'Add',
      isExtended: true,
      elevation: 2,
      onPressed: () => onItemSelected(isActive ? 0 : 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      backgroundColor: colorScheme.primary,
      child: Icon(isActive ? Icons.close : Icons.add, color: Colors.white),
    );
  }
}
