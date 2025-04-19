import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import '../../logic/cubit/add_report_cubit.dart';

class AdditionalDetails extends StatelessWidget {
  const AdditionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<AddReportCubit>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization?.additionalDetails ?? 'Additional Details (Optional)',
          style: textTheme.bodyLarge!.copyWith(color: colorScheme.primary),
        ),
        SizedBox(height: 8.h),
        BaseTextField(
          hintText: localization?.describeIncident ?? 'Describe the incident...',
          maxLines: 5,
          controller: cubit.detailsController,
        ),
      ],
    );
  }
}