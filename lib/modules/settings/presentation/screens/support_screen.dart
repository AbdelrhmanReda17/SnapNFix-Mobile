import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

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
          localization.support,
          style: TextStyle(color: colorScheme.surface, fontSize: 18.sp),
        ),
        iconTheme: IconThemeData(color: colorScheme.surface, size: 20.sp),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Contact Us', textStyles, colorScheme),
            SizedBox(height: 16.h),
            _buildContactItem(
              icon: Icons.email_outlined,
              title: 'Email',
              subtitle: 'support@snapnfix.com',
              onTap: () => _launchEmail('support@snapnfix.com'),
              textStyles: textStyles,
              colorScheme: colorScheme,
            ),
            _buildContactItem(
              icon: Icons.phone_outlined,
              title: 'Phone',
              subtitle: '+1 (555) 123-4567',
              onTap: () => _launchPhone('+15551234567'),
              textStyles: textStyles,
              colorScheme: colorScheme,
            ),
            SizedBox(height: 24.h),
            _buildSectionTitle('FAQs', textStyles, colorScheme),
            SizedBox(height: 16.h),
            _buildFaqItem(
              'How do I report an issue?',
              'To report an issue, tap the + button in the bottom navigation bar, take a photo of the problem, add details, and submit.',
              textStyles,
              colorScheme,
            ),
            _buildFaqItem(
              'How long does it take to resolve an issue?',
              'Resolution times vary depending on the type and severity of the issue. You can track the status of your report in the "My Reports" section.',
              textStyles,
              colorScheme,
            ),
            _buildFaqItem(
              'Can I edit my report after submission?',
              'No, but you can add comments to provide additional information or updates to your report.',
              textStyles,
              colorScheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextTheme textStyles, ColorScheme colorScheme) {
    return Text(
      title,
      style: textStyles.titleLarge?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required TextTheme textStyles,
    required ColorScheme colorScheme,
  }) {
    return Card(
      elevation: 0,
      color: colorScheme.surface,
      child: ListTile(
        leading: Icon(icon, color: colorScheme.primary),
        title: Text(title, style: textStyles.titleMedium),
        subtitle: Text(subtitle, style: textStyles.bodyMedium),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFaqItem(
    String question,
    String answer,
    TextTheme textStyles,
    ColorScheme colorScheme,
  ) {
    return Card(
      elevation: 0,
      color: colorScheme.surface,
      child: ExpansionTile(
        title: Text(
          question,
          style: textStyles.titleMedium?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              answer,
              style: textStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }
}