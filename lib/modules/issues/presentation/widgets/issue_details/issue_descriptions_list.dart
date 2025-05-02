import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_description.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:snapnfix/modules/issues/presentation/widgets/issue_details/issue_description_item.dart';

class IssueDescriptionsList extends StatelessWidget {
  final List<IssueDescription> descriptions;

  const IssueDescriptionsList({super.key, required this.descriptions});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return descriptions.isEmpty
        ? Center(
          child: Text(
            localization.noDescriptions,
            style: TextStyle(fontSize: 16.sp, color: colorScheme.onSurface),
          ),
        )
        : ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: descriptions.length,
          itemBuilder: (context, index) {
            final description = descriptions[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 14.h),
              child: IssueDescriptionItem(description: description),
            );
          },
        );
  }
}
