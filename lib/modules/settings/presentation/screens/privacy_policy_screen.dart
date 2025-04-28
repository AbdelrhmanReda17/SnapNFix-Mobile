import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          localization.privacyPolicy,
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
              'Information We Collect',
              'We collect the following types of information:\n\n'
              '• Personal Information (email, name, phone number)\n'
              '• Location Data (when submitting reports)\n'
              '• Device Information\n'
              '• Photos and Media (submitted with reports)\n'
              '• Usage Information',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'How We Use Your Information',
              '• To process and manage issue reports\n'
              '• To improve our services\n'
              '• To communicate with you about reports and updates\n'
              '• To ensure platform safety and security\n'
              '• To comply with legal obligations',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Data Storage and Security',
              'We implement appropriate security measures to protect your data. Your information is stored on secure servers and we use industry-standard encryption for data transmission.',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Location Services',
              'We only collect location data when you submit a report. This helps us accurately identify and address reported issues. You can disable location services, but this may limit some app functionality.',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Photo Usage',
              'Photos submitted with reports are used solely for issue documentation and resolution. We do not share these photos with third parties except as required for issue resolution.',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Data Sharing',
              'We may share your data with:\n\n'
              '• Authorized maintenance personnel\n'
              '• Service providers who assist in issue resolution\n'
              '• Law enforcement when required by law',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Your Rights',
              'You have the right to:\n\n'
              '• Access your personal data\n'
              '• Request data correction\n'
              '• Request data deletion\n'
              '• Opt-out of communications',
              textStyles,
              colorScheme,
            ),
            _buildSection(
              'Contact Us',
              'For privacy-related inquiries, contact us at:\nprivacy@snapnfix.com',
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