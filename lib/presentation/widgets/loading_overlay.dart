import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: colorScheme.primary, strokeWidth: 2),
          const SizedBox(height: 16),
          Text(
            'Loading...',
            style: textTheme.bodyLarge!.copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
