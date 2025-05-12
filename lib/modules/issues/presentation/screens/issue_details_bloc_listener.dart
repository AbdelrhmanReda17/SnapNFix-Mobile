import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issue_details_cubit.dart';
import 'package:snapnfix/presentation/widgets/loading_overlay.dart';

class IssueDetailsBlocListener extends StatelessWidget {
  const IssueDetailsBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<IssueDetailsCubit, IssueDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () => LoadingOverlay(),
          error: (error) => _showError(context, error),
          orElse: () {},
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showError(BuildContext context, ApiErrorModel error) {
    final localization = AppLocalizations.of(context)!;
    context.pop();

    baseDialog(
      context: context,
      title: localization.errorFetchingIssue,
      message: error.getAllErrorMessages(),
      alertType: AlertType.error,
      confirmText: localization.ok,
      onConfirm: () {},
      showCancelButton: false,
    );
  }
}
