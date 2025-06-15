import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/base_components/index.dart';
import '../../../../core/infrastructure/index.dart';

/// Mixin that provides authentication-related UI state management
/// and navigation functionality for authentication flows.
mixin ListenerMixin {
  /// Shows a loading dialog with circular progress indicator
  void showLoadingDialog(BuildContext context) {
    // Check if a dialog is already showing by checking if we can pop
    if (_isDialogShowing(context)) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) => const _LoadingDialog(),
    );
  }

  /// Handles successful authentication operations
  void handleSuccess(
    BuildContext context, {
    bool showSuccessMessage = false,
    String? successTitle,
    String? successMessage,
    String? navigationRoute,
    Object? navigationExtra,
  }) {
    dismissLoadingAndExecute(context, () {
      if (showSuccessMessage && successMessage != null) {
        _showSuccessDialog(
          context,
          title: successTitle,
          message: successMessage,
          onConfirm:
              navigationRoute != null
                  ? () => _navigateToRoute(
                    context,
                    navigationRoute,
                    navigationExtra,
                  )
                  : null,
        );
      } else if (navigationRoute != null) {
        _navigateToRoute(context, navigationRoute, navigationExtra);
      }
    });
  }

  /// Handles authentication errors by showing error dialog
  void handleError(
    BuildContext context,
    ApiError error, {
    String? title,
    String? fallbackRoute,
  }) {
    dismissLoadingAndExecute(context, () {
      _showErrorDialog(
        context,
        title: title,
        error: error,
        onConfirm:
            fallbackRoute != null
                ? () => _navigateToRoute(context, fallbackRoute, null)
                : null,
      );
    });
  }

  /// Navigates to the specified route
  void navigateToRoute(BuildContext context, String route, {Object? extra}) {
    _navigateToRoute(context, route, extra);
  }

  void dismissLoadingAndExecute(BuildContext context, VoidCallback callback) {
    if (!context.mounted) return;

    // Try to dismiss any showing dialog
    if (_isDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        callback();
      }
    });
  }

  /// Check if a dialog is currently showing
  bool _isDialogShowing(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).canPop();
  }

  /// Shows success dialog with customizable content
  void _showSuccessDialog(
    BuildContext context, {
    String? title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    final localizations = AppLocalizations.of(context)!;

    baseDialog(
      context: context,
      title: title ?? localizations.successDialogTitle,
      message: message,
      alertType: AlertType.success,
      confirmText: localizations.gotItConfirmText,
      onConfirm: onConfirm,
      showCancelButton: false,
    );
  }

  /// Shows error dialog with API error information
  void _showErrorDialog(
    BuildContext context, {
    String? title,
    required ApiError error,
    VoidCallback? onConfirm,
  }) {
    final localizations = AppLocalizations.of(context)!;

    baseDialog(
      context: context,
      title: title ?? localizations.errorDialogTitle,
      message: error.message,
      alertType: AlertType.error,
      confirmText: localizations.gotItConfirmText,
      onConfirm: onConfirm,
      showCancelButton: false,
    );
  }

  /// Navigates to route with proper timing
  void _navigateToRoute(BuildContext context, String route, Object? extra) {
    if (!context.mounted) return;

    // Small delay to ensure any dialogs are fully processed
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!context.mounted) return;

      try {
        if (extra != null) {
          context.go(route, extra: extra);
        } else {
          context.go(route);
        }
      } catch (e) {
        debugPrint('Navigation error: $e');
      }
    });
  }
}

/// Private widget for loading dialog
class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
