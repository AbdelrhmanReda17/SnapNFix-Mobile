import 'package:flutter/material.dart';
import 'package:snapnfix/modules/reports/data/model/media_model.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_card.dart';

class UserReportsScreen extends StatelessWidget {
  const UserReportsScreen({super.key});

  // Temporary static data until API is ready
  List<ReportModel> get _mockReports => [
    ReportModel(
      id: '1',
      issueId: 'ISS-001', // Add issue ID
      details:
          'There is a broken streetlight that needs immediate attention. It has been flickering for the past week and poses a safety hazard during nighttime.',
      latitude: 30.1123150,
      longitude: 31.3438507,
      severity: ReportSeverity.high,
      status: ReportStatus.pending, // Add status
      timestamp: DateTime.now().toIso8601String(),
      reportMedia: const MediaModel(
        image: 'https://picsum.photos/800/600',
        category: 'Infrastructure',
      ),
    ),
    ReportModel(
      id: '2',
      issueId: 'ISS-002', // Add issue ID
      details:
          'Several potholes have formed on the road surface, making it difficult for vehicles to pass safely.',
      latitude: 29.9601561,
      longitude: 31.2569138,
      severity: ReportSeverity.medium,
      status: ReportStatus.valid, // Add status
      timestamp:
          DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      reportMedia: const MediaModel(
        image: 'https://picsum.photos/800/601',
        category: 'Road',
      ),
    ),
    ReportModel(
      id: '3',
      issueId: 'ISS-003', // Add issue ID
      details:
          'The public bench in the park is damaged and needs repair. One of the wooden planks is broken.',
      latitude: 30.1131830,
      longitude: 31.3995423,
      severity: ReportSeverity.low,
      status: ReportStatus.invalid, // Add status
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
  return Scaffold(
    backgroundColor: theme.colorScheme.background,
    appBar: AppBar(
      title: Text(
        'My Reports',
        style: theme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
    ),
    body: _mockReports.isEmpty
        ? Center(
            child: Text(
              'No reports yet',
              style: theme.textTheme.bodyLarge,
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _mockReports.length,
            itemBuilder: (context, index) {
              final report = _mockReports[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ReportCard(report: report),
              );
            },
          ),
  );
}
}