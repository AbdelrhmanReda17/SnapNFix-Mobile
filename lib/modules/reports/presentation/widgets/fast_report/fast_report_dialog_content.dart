import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_fast_report_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/fast_report/fast_report_dialog_header.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/fast_report/fast_report_form.dart';

class FastReportDialogContent extends StatefulWidget {
  final String issueId;
  final VoidCallback onSuccess;

  const FastReportDialogContent({
    super.key,
    required this.issueId,
    required this.onSuccess,
  });

  @override
  State<FastReportDialogContent> createState() =>
      _FastReportDialogContentState();
}

class _FastReportDialogContentState extends State<FastReportDialogContent> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  ReportSeverity _selectedSeverity = ReportSeverity.low;
  bool _isDescriptionValid = false;

  @override
  void initState() {
    super.initState();
    _commentController.addListener(_validateDescription);
  }

  @override
  void dispose() {
    _commentController.removeListener(_validateDescription);
    _commentController.dispose();
    super.dispose();
  }

  void _validateDescription() {
    final text = _commentController.text.trim();
    final isValid = text.isNotEmpty && text.length >= 10;
    if (isValid != _isDescriptionValid) {
      setState(() => _isDescriptionValid = isValid);
    }
  }

  void _updateSeverity(ReportSeverity severity) {
    setState(() => _selectedSeverity = severity);
  }

  void _submitReport() {
    if (!_formKey.currentState!.validate()) return;

    context.read<SubmitFastReportCubit>().submitFastReport(
      issueId: widget.issueId,
      comment: _commentController.text.trim(),
      severity: _selectedSeverity,
    );
  }

  void _showResultDialog({
    required String title,
    required String message,
    required AlertType type,
  }) {
    baseDialog(
      context: context,
      title: title,
      message: message,
      alertType: type,
      confirmText: AppLocalizations.of(context)!.gotItConfirmText,
      onConfirm: () {},
      showCancelButton: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return BlocConsumer<SubmitFastReportCubit, SubmitFastReportState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (_) {
            Navigator.of(context).pop(true);
            widget.onSuccess();
            _showResultDialog(
              title: localization.successDialogTitle,
              message: "Report submitted successfully!",
              type: AlertType.success,
            );
          },
          error: (error) {
            _showResultDialog(
              title: localization.errorDialogTitle,
              message: error.message,
              type: AlertType.error,
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        final isButtonEnabled = _isDescriptionValid && !isLoading;

        return Stack(
          children: [
            _buildDialogContent(context, isLoading, isButtonEnabled),
            if (isLoading) _buildLoadingOverlay(colorScheme),
          ],
        );
      },
    );
  }

  Widget _buildDialogContent(
    BuildContext context,
    bool isLoading,
    bool isButtonEnabled,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FastReportDialogHeader(),
          Expanded(
            child: FastReportForm(
              formKey: _formKey,
              commentController: _commentController,
              selectedSeverity: _selectedSeverity,
              onSeverityChanged: _updateSeverity,
            ),
          ),
          verticalSpace(12),
          BaseButton(
            onPressed: isButtonEnabled ? _submitReport : null,
            text: "Submit",
            backgroundColor: colorScheme.primary,
            textStyle: textStyles.bodyLarge!.copyWith(
              color: colorScheme.surface,
              fontWeight: FontWeight.bold,
            ),
            isEnabled: isButtonEnabled,
            borderColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay(ColorScheme colorScheme) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: Center(
        child: CircularProgressIndicator(color: colorScheme.primary),
      ),
    );
  }
}
