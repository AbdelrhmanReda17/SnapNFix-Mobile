import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_alert_component/alert_type.dart';
import 'package:snapnfix/core/utils/helpers/localization_helper.dart';

import '../../base_components/index.dart';
import '../../infrastructure/index.dart';

mixin ListenerMixin {
  void showLoadingDialog(BuildContext context) {
    if (_isDialogShowing(context)) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) => const _LoadingDialog(),
    );
  }

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

  void navigateToRoute(BuildContext context, String route, {Object? extra}) {
    _navigateToRoute(context, route, extra);
  }

  void dismissLoadingAndExecute(BuildContext context, VoidCallback callback) {
    if (!context.mounted) return;

    if (_isDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        callback();
      }
    });
  }

  bool _isDialogShowing(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).canPop();
  }

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

  void _showErrorDialog(
    BuildContext context, {
    String? title,
    required ApiError error,
    VoidCallback? onConfirm,
  }) {
    final localizations = AppLocalizations.of(context)!;
    baseDialog(
      context: context,
      title: localizations.errorDialogTitle,
      message: LocalizationHelper.getLocalizedMessage(
        context,
        error.fullMessage,
      ),
      alertType: AlertType.error,
      confirmText: localizations.gotItConfirmText,
      onConfirm: onConfirm,
      showCancelButton: false,
    );
  }

  void _navigateToRoute(BuildContext context, String route, Object? extra) {
    if (!context.mounted) return;

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
