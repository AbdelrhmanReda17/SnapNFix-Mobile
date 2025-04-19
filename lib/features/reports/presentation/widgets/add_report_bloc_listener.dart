import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/features/reports/logic/cubit/add_report_cubit.dart';

class AddReportBlocListener extends StatelessWidget {
  const AddReportBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<AddReportCubit, AddReportState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (addReportResponse) {
            context.pop();
            baseDialog(
              context: context,
              title: 'Success',
              message: addReportResponse,
              alertType: AlertType.success,
              confirmText: 'Got it',
              onConfirm: () => {},
              showCancelButton: false,
            );
          },
          error: (error) {
            setupErrorState(context, error);
          },
          loading: () {
            showDialog(
              context: context,
              builder:
                  (context) => Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  ),
            );
          },
        );
      },
      child: SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    baseDialog(
      context: context,
      title: 'Error',
      message: error,
      alertType: AlertType.error,
      confirmText: 'Got it',
      onConfirm: () {},
      showCancelButton: false,
    );
  }
}
