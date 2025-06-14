import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/index.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_description_input.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_severity_selector.dart';

class FastReportForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController commentController;
  final ReportSeverity selectedSeverity;
  final ValueChanged<ReportSeverity> onSeverityChanged;

  const FastReportForm({
    super.key,
    required this.formKey,
    required this.commentController,
    required this.selectedSeverity,
    required this.onSeverityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReportDescriptionInput(
              controller: commentController,
              isRequired: true,
              validator: (value) => value?.validateReportDescription(context),
            ),
            verticalSpace(8.h),
            ReportSeveritySelector(
              selectedSeverity: selectedSeverity,
              onSeverityChanged: onSeverityChanged,
              isMandatory: true,
            ),
          ],
        ),
      ),
    );
  }
}
