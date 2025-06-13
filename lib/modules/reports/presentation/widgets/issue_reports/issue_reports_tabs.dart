import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/index.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/issue_fast_reports_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/issue_snap_reports_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/issue_reports/issue_fast_reports_list.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/issue_reports/issue_snap_reports_list.dart';

class IssueReportsTabs extends StatefulWidget {
  final String issueId;

  const IssueReportsTabs({super.key, required this.issueId});

  @override
  State<IssueReportsTabs> createState() => _IssueReportsTabsState();
}

class _IssueReportsTabsState extends State<IssueReportsTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider<IssueFastReportsCubit>(
          create:
              (context) =>
                  getIt<IssueFastReportsCubit>()
                    ..loadReports(issueId: widget.issueId),
        ),
        BlocProvider<IssueSnapReportsCubit>(
          create:
              (context) =>
                  getIt<IssueSnapReportsCubit>()
                    ..loadReports(issueId: widget.issueId),
        ),
      ],
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: colorScheme.primary,
              ),
              labelColor: colorScheme.onPrimary,
              unselectedLabelColor: colorScheme.onSurface.withOpacity(0.6),
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.comment, size: 18.sp),
                      SizedBox(width: 8.w),
                      Text('Fast Reports'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_camera, size: 18.sp),
                      SizedBox(width: 8.w),
                      Text('Snap Reports'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                IssueFastReportsList(issueId: widget.issueId),
                IssueSnapReportsList(issueId: widget.issueId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
