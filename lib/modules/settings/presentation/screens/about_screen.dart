import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/l10n/assets.gen.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          localization.about,
          style: TextStyle(color: colorScheme.surface, fontSize: 18.sp),
        ),
        iconTheme: IconThemeData(color: colorScheme.surface, size: 20.sp),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24.h),
            Assets.images.snapNFix.image(width: 120.w, height: 120.h),
            SizedBox(height: 24.h),
            Text(
              'SnapNFix',
              style: textStyles.headlineMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Version ${snapshot.data!.version}',
                    style: textStyles.bodyMedium,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(height: 32.h),
            Text(
              localization.aboutDescription,
              style: textStyles.bodyLarge?.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            _buildSection(
              localization.ourMission,
              localization.missionText,
              textStyles,
              colorScheme,
            ),
            _buildSection(
              localization.keyFeatures,
              localization.keyFeaturesText,
              textStyles,
              colorScheme,
            ),
            SizedBox(height: 24.h),
            Text(
              '© 2025 SnapNFix. ${localization.allRightsReserved}',
              style: textStyles.bodySmall?.copyWith(
                color: colorScheme.secondary,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: textStyles.titleMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(content, style: textStyles.bodyMedium?.copyWith(height: 1.5)),
        SizedBox(height: 24.h),
      ],
    );
  }
}
