import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_area_issues_use_case.dart';
import 'package:snapnfix/presentation/cubits/area_issues_cubit.dart';
import 'package:snapnfix/presentation/widgets/area_issues/area_issues_header.dart';
import 'package:snapnfix/presentation/widgets/area_issues/area_issues_list.dart';

class AreaIssuesChatScreen extends StatelessWidget {
  final String area;

  AreaIssuesChatScreen({String? area, Map<String, dynamic>? extra, super.key})
    : area = area ?? extra?['area'] as String;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;

    final healthScore = _getAreaHealthScore(area);
    final openIssues = _getAreaOpenIssuesCount(area);
    final fixedThisMonth = _getAreaFixedThisMonth(area);
    final avgResolutionTime = _getAreaAvgResolutionTime(area);
    final trend = _getAreaTrend(area);

    return BlocProvider(
      create:
          (context) => AreaIssuesCubit(
            areaName: area,
            getAreaIssuesUseCase: getIt<GetAreaIssuesUseCase>(),
          ),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.home_work, color: colorScheme.primary, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                '$area Issues',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // Area health card
            _buildAreaHealthCard(
              context,
              localization,
              healthScore,
              openIssues,
              fixedThisMonth,
              avgResolutionTime,
              trend,
            ),

            // Area header with subscription and filter buttons
            const AreaIssuesHeader(),

            // Issue list with pull-to-refresh
            const Expanded(child: AreaIssuesList()),
          ],
        ),
      ),
    );
  }

  // Build health card widget
  Widget _buildAreaHealthCard(
    BuildContext context,
    AppLocalizations localization,
    double healthScore,
    int openIssues,
    int fixedThisMonth,
    double avgResolutionTime,
    String trend,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final healthColor = _getHealthColor(healthScore);

    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          // Health header with score
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Health indicator circle
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: healthColor.withValues(alpha: 0.1),
                    border: Border.all(color: healthColor, width: 2.w),
                  ),
                  child: Center(
                    child: Text(
                      '${(healthScore * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: healthColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localization.areaHealthStatus,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _getHealthDescription(healthScore, localization),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: healthColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Trend indicator
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getTrendColor(trend).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getTrendIcon(trend),
                        size: 14.sp,
                        color: _getTrendColor(trend),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _getLocalizedTrend(trend, localization),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: _getTrendColor(trend),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: colorScheme.outline.withValues(alpha: 0.1),
          ),

          // Metrics row
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetricItem(
                  context,
                  Icons.error_outline,
                  openIssues.toString(),
                  localization.openIssues,
                  Colors.orange,
                ),
                _buildMetricItem(
                  context,
                  Icons.check_circle_outline,
                  fixedThisMonth.toString(),
                  localization.fixedMonth,
                  Colors.green,
                ),
                _buildMetricItem(
                  context,
                  Icons.timer_outlined,
                  '${avgResolutionTime.toStringAsFixed(1)}h',
                  localization.avgFixTime,
                  Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // Helper methods to calculate health metrics
  // In a real app, these would fetch data from a service

  double _getAreaHealthScore(String area) {
    // Mock data based on area name
    final Map<String, double> mockScores = {
      'Downtown': 0.85,
      'Nasr City': 0.42,
      'Heliopolis': 0.76,
      'Maadi': 0.69,
      'Zamalek': 0.91,
    };

    return mockScores[area] ??
        0.5 +
            ((area.hashCode % 50) /
                100); // Generates a consistent value between 0.5-1.0
  }

  int _getAreaOpenIssuesCount(String area) {
    final Map<String, int> mockCounts = {
      'Downtown': 8,
      'Nasr City': 15,
      'Heliopolis': 5,
      'Maadi': 7,
      'Zamalek': 3,
    };

    return mockCounts[area] ?? (area.hashCode % 15 + 3);
  }

  int _getAreaFixedThisMonth(String area) {
    final Map<String, int> mockCounts = {
      'Downtown': 12,
      'Nasr City': 8,
      'Heliopolis': 14,
      'Maadi': 9,
      'Zamalek': 11,
    };

    return mockCounts[area] ?? (area.hashCode % 10 + 5);
  }

  double _getAreaAvgResolutionTime(String area) {
    final Map<String, double> mockTimes = {
      'Downtown': 9.5,
      'Nasr City': 15.8,
      'Heliopolis': 7.2,
      'Maadi': 10.4,
      'Zamalek': 5.6,
    };

    return mockTimes[area] ??
        (5.0 + (area.hashCode % 100) / 10); // Between 5-15 hours
  }

  String _getAreaTrend(String area) {
    final Map<String, String> mockTrends = {
      'Downtown': 'Improving',
      'Nasr City': 'Declining',
      'Heliopolis': 'Stable',
      'Maadi': 'Improving',
      'Zamalek': 'Improving',
    };

    final trends = ['Improving', 'Stable', 'Declining'];
    return mockTrends[area] ?? trends[area.hashCode % 3];
  }

  Color _getHealthColor(double health) {
    if (health > 0.7) {
      return Colors.green;
    } else if (health > 0.4) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _getHealthDescription(double health, AppLocalizations localization) {
    if (health > 0.8) {
      return localization.excellentCondition;
    } else if (health > 0.7) {
      return localization.goodCondition;
    } else if (health > 0.5) {
      return localization.fairCondition;
    } else if (health > 0.3) {
      return localization.poorCondition;
    } else {
      return localization.criticalCondition;
    }
  }

  String _getLocalizedTrend(String trend, AppLocalizations localization) {
    switch (trend) {
      case 'Improving':
        return localization.improving;
      case 'Stable':
        return localization.stable;
      case 'Declining':
        return localization.declining;
      default:
        return trend;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case 'Improving':
        return Colors.green;
      case 'Stable':
        return Colors.blue;
      case 'Declining':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case 'Improving':
        return Icons.trending_up;
      case 'Stable':
        return Icons.trending_flat;
      case 'Declining':
        return Icons.trending_down;
      default:
        return Icons.help_outline;
    }
  }
}
