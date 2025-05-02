import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';

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
        title: title ?? 'Success',
        message: message,
        alertType: AlertType.success,
        confirmText: 'Got it',
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
    ApiErrorModel error, {
    String title = 'Error',
  }) {
    context.pop();
    baseDialog(
      context: context,
      title: title,
      message: error.getAllErrorMessages(),
      alertType: AlertType.error,
      confirmText: 'Got it',
      onConfirm: () {},
      showCancelButton: false,
    );
  }

  void navigateTo(BuildContext context, String route) {
    context.push(route);
  }
}
