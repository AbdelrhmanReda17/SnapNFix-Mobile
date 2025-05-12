import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context)!;
    final statusBarStyle = ApplicationSystemUIOverlay.getSettingsStyle(
      colorScheme.primary,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        systemOverlayStyle: statusBarStyle,
        title: Text(
          localization.termsAndConditions,
          style: TextStyle(color: colorScheme.surface, fontSize: 18.sp),
        ),
        iconTheme: IconThemeData(color: colorScheme.surface, size: 20.sp),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              localization.acceptanceOfTerms,
              localization.acceptanceOfTermsText,
              textStyles,
              colorScheme,
            ),
            _buildSection(
              localization.userResponsibilities,
              localization.userResponsibilitiesText,
              textStyles,
              colorScheme,
            ),
            _buildSection(
              localization.contentGuidelines,
              localization.contentGuidelinesText,
              textStyles,
              colorScheme,
            ),
            verticalSpace(24),
            Text(
              localization
                  .lastUpdated('{date}')
                  .replaceAll('{date}', 'April 28, 2025'),
              style: textStyles.bodySmall?.copyWith(
                color: colorScheme.secondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    String content,
    TextTheme textStyles,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textStyles.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(8),
          Text(content, style: textStyles.bodyMedium?.copyWith(height: 1.5)),
        ],
      ),
    );
  }
}
