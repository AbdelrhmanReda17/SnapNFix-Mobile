import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/mixins/listener_mixin.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';

class SubmitReportBlocListener extends StatelessWidget with ListenerMixin {
  const SubmitReportBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return BlocListener<SubmitReportCubit, SubmitReportState>(
      listenWhen:
          (previous, current) =>
              previous.isLoading != current.isLoading ||
              previous.error != current.error ||
              previous.successMessage != current.successMessage,
      listener: (context, state) {
        if (state.isLoading) {
          showLoadingDialog(context);
        }

        if (state.error != null) {
          dismissLoadingAndExecute(context, () {
            baseDialog(
              context: context,
              title: localization.submittingReportError,
              message: state.error!,
              alertType: AlertType.error,
              confirmText: localization.gotItConfirmText,
              onConfirm: () {},
              showCancelButton: false,
            );
          });
        }

        if (state.successMessage != null) {
          dismissLoadingAndExecute(context, () {
            baseDialog(
              context: context,
              title: localization.successDialogTitle,
              message: state.successMessage!,
              alertType: AlertType.success,
              confirmText: localization.gotItConfirmText,
              onConfirm: () {},
              showCancelButton: false,
            );
          });
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
