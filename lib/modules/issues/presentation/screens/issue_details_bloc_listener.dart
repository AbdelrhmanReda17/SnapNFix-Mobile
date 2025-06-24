import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_alert_component/alert_type.dart';
import 'package:snapnfix/presentation/widgets/loading_overlay.dart';
import 'package:snapnfix/core/index.dart';
import 'package:snapnfix/modules/issues/index.dart';

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

  void _showError(BuildContext context, ApiError error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final localization = AppLocalizations.of(context)!;
      if (!context.mounted) return;
      context.pop();
      baseDialog(
        context: context,
        title: localization.errorFetchingIssue,
        message: error.message,
        alertType: AlertType.error,
        confirmText: localization.ok,
        onConfirm: () {},
        showCancelButton: false,
      );
    });
  }
}
