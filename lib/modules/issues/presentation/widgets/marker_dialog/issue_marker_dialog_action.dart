import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/base_components/base_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IssueMarkerDialogAction extends StatelessWidget {
  final VoidCallback? onTap;

  const IssueMarkerDialogAction({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: BaseButton(
        onPressed: onTap,
        text: localization.fastReport,
        backgroundColor: colorScheme.primary,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}