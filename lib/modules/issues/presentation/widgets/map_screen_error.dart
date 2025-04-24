import 'package:flutter/material.dart';
import 'package:snapnfix/core/base_components/base_button.dart';

enum MapErrorType { general, permission }

class MapScreenError extends StatelessWidget {
  final MapErrorType type;
  final VoidCallback onActionPressed;
  final String? title;
  final String? actionText;

  const MapScreenError({
    super.key,
    required this.type,
    required this.onActionPressed,
    this.title,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getIcon(),
            size: 64,
            color:
                type == MapErrorType.general
                    ? colorScheme.error
                    : colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              title ?? _getDefaultTitle(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: type == MapErrorType.general ? colorScheme.error : null,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: BaseButton(
              onPressed: onActionPressed,
              text: actionText ?? _getDefaultActionText(),
              backgroundColor: colorScheme.primary,
              textStyle: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (type) {
      case MapErrorType.general:
        return Icons.error_outline;
      case MapErrorType.permission:
        return Icons.location_off;
    }
  }

  String _getDefaultTitle() {
    switch (type) {
      case MapErrorType.general:
        return 'Something went wrong';
      case MapErrorType.permission:
        return 'Location access required';
    }
  }

  String _getDefaultActionText() {
    switch (type) {
      case MapErrorType.general:
        return 'Retry';
      case MapErrorType.permission:
        return 'Open Settings';
    }
  }
}
