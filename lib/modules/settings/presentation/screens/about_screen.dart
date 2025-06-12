import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/l10n/assets.gen.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';

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
            verticalSpace(24),
            Assets.images.snapNFix.image(width: 120.w, height: 120.h),
            verticalSpace(24),
            Text(
              localization.snapNFix,
              style: textStyles.headlineMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(8),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    localization.appVersion(snapshot.data!.version),
                    style: textStyles.bodyMedium,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            verticalSpace(32),
            Text(
              localization.aboutDescription,
              style: textStyles.bodyLarge?.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            verticalSpace(32),
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
            verticalSpace(24),
            Text(
              '${localization.copyRights}. ${localization.allRightsReserved}',
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
        verticalSpace(8),
        Text(content, style: textStyles.bodyMedium?.copyWith(height: 1.5)),
        verticalSpace(24),
      ],
    );
  }
}
