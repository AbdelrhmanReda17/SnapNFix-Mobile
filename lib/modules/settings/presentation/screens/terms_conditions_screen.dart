import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              'Acceptance of Terms',
              'By accessing and using SnapNFix, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, please do not use the application.',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'User Responsibilities',
              '• You must provide accurate and truthful information when reporting issues\n'
              '• You are responsible for maintaining the confidentiality of your account\n'
              '• You agree not to misuse or abuse the reporting system\n'
              '• You must respect the privacy and rights of others when using the app',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Content Guidelines',
              '• All submitted content must be appropriate and relevant\n'
              '• Photos should clearly show the reported issue\n'
              '• Avoid including identifiable individuals in photos without consent\n'
              '• Do not submit false or misleading reports',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Privacy and Data',
              'We collect and process data as described in our Privacy Policy. By using SnapNFix, you consent to our data practices.',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Modifications',
              'We reserve the right to modify these terms at any time. Continued use of the application after changes constitutes acceptance of the modified terms.',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Termination',
              'We reserve the right to terminate or suspend access to our service immediately, without prior notice, for conduct that we believe violates these Terms or is harmful to other users or us.',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Contact',
              'If you have any questions about these Terms, please contact us at legal@snapnfix.com',
              textStyles,
              colorScheme,
            ),
            SizedBox(height: 24.h),
            Text(
              'Last updated: April 28, 2025',
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
          SizedBox(height: 8.h),
          Text(
            content,
            style: textStyles.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}