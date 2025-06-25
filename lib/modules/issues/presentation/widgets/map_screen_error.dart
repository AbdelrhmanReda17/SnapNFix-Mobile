import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

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
    final localization = AppLocalizations.of(context)!;

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
          verticalSpace(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              title ?? _getDefaultTitle(localization),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: type == MapErrorType.general ? colorScheme.error : null,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpace(24),
          SizedBox(
            width: 0.5.sw,
            child: BaseButton(
              onPressed: onActionPressed,
              text: actionText ?? _getDefaultActionText(localization),
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

  String _getDefaultTitle(AppLocalizations localization) {
    switch (type) {
      case MapErrorType.general:
        return localization.mapErrorGeneralTitle;
      case MapErrorType.permission:
        return localization.mapErrorPermissionTitle;
    }
  }

  String _getDefaultActionText(AppLocalizations localization) {

    switch (type) {
      case MapErrorType.general:
        return localization.mapErrorGeneralActionText;
      case MapErrorType.permission:
        return localization.errorPermissionActionText;
    }
  }
}
