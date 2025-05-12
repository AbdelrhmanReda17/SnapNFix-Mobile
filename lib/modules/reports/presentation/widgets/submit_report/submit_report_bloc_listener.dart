import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';
import 'package:go_router/go_router.dart';

class SubmitReportBlocListener extends StatelessWidget {
  const SubmitReportBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<SubmitReportCubit, SubmitReportState>(
      listenWhen:
          (previous, current) =>
              previous.isLoading != current.isLoading ||
              previous.error != current.error ||
              previous.successMessage != current.successMessage,
      listener: (context, state) {
        if (!state.isLoading && Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
        if (state.isLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (context) => Center(
                  child: CircularProgressIndicator(color: colorScheme.primary),
                ),
          );
          return;
        }

        if (state.error != null) {
          try {
            context.pop();
          } catch (e) {
            debugPrint('Error popping context: $e');
          }
          baseDialog(
            context: context,
            title: 'Error while submitting report',
            message: state.error!,
            alertType: AlertType.error,
            confirmText: 'Got it',
            onConfirm: () {},
            showCancelButton: false,
          );
        }

        if (state.successMessage != null) {
          try {
            context.pop(); // Navigate back to previous screen
          } catch (e) {
            // Safely catch errors if can't pop
            debugPrint('Error popping context: $e');
          }
          baseDialog(
            context: context,
            title: 'Success',
            message: state.successMessage!,
            alertType: AlertType.success,
            confirmText: 'Got it',
            onConfirm: () {},
            showCancelButton: false,
          );
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
