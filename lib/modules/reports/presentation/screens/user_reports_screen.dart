import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/reports/data/model/media_model.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_card.dart';

class UserReportsScreen extends StatelessWidget {
  const UserReportsScreen({super.key});

  List<ReportModel> get _mockReports => [
    ReportModel(
      id: '1',
      issueId: 'ISS-001', 
      details:
          'There is a broken streetlight that needs immediate attention. It has been flickering for the past week and poses a safety hazard during nighttime.',
      latitude: 30.1123150,
      longitude: 31.3438507,
      severity: ReportSeverity.high,
      status: ReportStatus.pending,
      timestamp: DateTime.now().toIso8601String(),
      reportMedia: const MediaModel(
        image: 'https://picsum.photos/800/600',
        category: 'Infrastructure',
      ),
    ),
    ReportModel(
      id: '2',
      issueId: 'ISS-002',
      details:
          'Several potholes have formed on the road surface, making it difficult for vehicles to pass safely.',
      latitude: 29.9601561,
      longitude: 31.2569138,
      severity: ReportSeverity.medium,
      status: ReportStatus.valid,
      timestamp:
          DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      reportMedia: const MediaModel(
        image: 'https://picsum.photos/800/601',
        category: 'Road',
      ),
    ),
    ReportModel(
      id: '3',
      issueId: 'ISS-003',
      details:
          'The public bench in the park is damaged and needs repair. One of the wooden planks is broken.',
      latitude: 30.1131830,
      longitude: 31.3995423,
      severity: ReportSeverity.low,
      status: ReportStatus.invalid,
      timestamp:
          DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      reportMedia: const MediaModel(
        image: 'https://picsum.photos/800/602',
        category: 'Furniture',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: colorScheme.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Container(
          color: colorScheme.onPrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppBar(
                backgroundColor: colorScheme.background,
                titleSpacing: 0,
                centerTitle: true,
                elevation: 0,
                title: Text(
                  localization.myReports,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _mockReports.isEmpty
          ? Center(
              child: Text(
                localization.noReports,
                style: theme.textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: _mockReports.length,
              itemBuilder: (context, index) {
                final report = _mockReports[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.r),
                  child: ReportCard(report: report),
                );
              },
            ),
    );
  }
}