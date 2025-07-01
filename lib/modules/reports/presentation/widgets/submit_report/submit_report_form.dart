import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/utils/report_timeout_manager.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_description_input.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_severity_selector.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_report/submit_photo_picker.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_report/submit_report_note.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitReportForm extends StatelessWidget {
  final ReportTimeoutManager timeoutManager;
  final VoidCallback onSubmit;

  const SubmitReportForm({
    super.key,
    required this.timeoutManager,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      children: [
        BaseButton(
          onPressed: () {
            context.read<SubmitReportCubit>().setTempImage();
            timeoutManager.resetTimer();
          },
          text: localization?.useMockImage ?? 'Mock Image',
          textStyle: textStyles.bodyLarge!.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: colorScheme.primary,
          borderColor: Colors.transparent,
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: timeoutManager.resetTimer,
          child: SubmitPhotoPicker(),
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: timeoutManager.resetTimer,
          child: BlocBuilder<SubmitReportCubit, SubmitReportState>(
            builder: (context, state) {
              return ReportSeveritySelector(
                selectedSeverity: state.severity,
                onSeverityChanged:
                    context.read<SubmitReportCubit>().setSeverity,
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: timeoutManager.resetTimer,
          child: ReportDescriptionInput(
            isRequired: false,
            onChanged: context.read<SubmitReportCubit>().setAdditionalDetails,
          ),
        ),
        SizedBox(height: 10.h),
        SubmitReportNote(),
        SizedBox(height: 10.h),
        BlocBuilder<SubmitReportCubit, SubmitReportState>(
          builder: (context, state) {
            return BaseButton(
              isEnabled: state.image != null,
              onPressed: onSubmit,
              text: localization?.submitReport ?? 'Submit Report',
              textStyle:
                  state.image != null
                      ? textStyles.bodyLarge!.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      )
                      : textStyles.bodyLarge!.copyWith(
                        color: colorScheme.tertiary.withValues(alpha: 0.3),
                        fontWeight: FontWeight.bold,
                      ),
              backgroundColor: colorScheme.primary,
              borderColor: Colors.transparent,
            );
          },
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
