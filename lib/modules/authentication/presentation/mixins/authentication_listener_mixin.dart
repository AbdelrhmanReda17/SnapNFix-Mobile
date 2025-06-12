import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/base_components/index.dart';
import '../../../../core/infrastructure/index.dart';

mixin AuthenticationListenerMixin {
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
    );
  }

  void handleSuccess(
    BuildContext context, {
    String? title,
    String? message,
    String? route,
    Object? extra,
    bool dismissDialog = true,
  }) {
    if (dismissDialog) {
      context.pop();
    }

    if (message != null) {
      baseDialog(
        context: context,
        title: title ?? AppLocalizations.of(context)!.successDialogTitle,
        message: message,
        alertType: AlertType.success,
        confirmText: AppLocalizations.of(context)!.gotItConfirmText,
        onConfirm: () {
          if (route != null) {
            if (extra != null) {
              context.go(route, extra: extra);
            } else {
              context.go(route);
            }
          }
        },
        showCancelButton: false,
      );
    } else if (route != null) {
      if (extra != null) {
        context.go(route, extra: extra);
      } else {
        context.go(route);
      }
    }
  }

  void handleError(
    BuildContext context,
    ApiError error, {
    String? title,
    String? route,
  }) {
    context.pop();
    baseDialog(
      context: context,
      title: title ?? AppLocalizations.of(context)!.errorDialogTitle,
      message: error.message,
      alertType: AlertType.error,
      confirmText: AppLocalizations.of(context)!.gotItConfirmText,
      onConfirm: () {
        if (route != null) {
          context.go(route);
        }
      },
      showCancelButton: false,
    );
  }

  void navigateTo(BuildContext context, String route) {
    context.push(route);
  }
}
