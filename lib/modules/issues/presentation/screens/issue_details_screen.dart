import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/index.dart';
import 'package:snapnfix/modules/issues/index.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/issue_reports/issue_reports_tabs.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/reports_error_view_widget.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';
import 'package:snapnfix/presentation/widgets/loading_overlay.dart';

class IssueDetailsScreen extends StatelessWidget {
  final String issueId;
  const IssueDetailsScreen({super.key, required this.issueId});

  @override
  Widget build(BuildContext context) {
    _loadIssue(context);

    final localization = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final appConfigs = getIt<ApplicationConfigurations>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ApplicationSystemUIOverlay.getDefaultStyle(appConfigs.isDarkMode),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          title: Text(
            localization.issueDetailsTitle,
            style: TextStyle(color: colorScheme.tertiary, fontSize: 20.sp),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.tertiary,
            size: 20.sp,
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: BlocBuilder<IssueDetailsCubit, IssueDetailsState>(
            builder: (context, state) {
              return state.when(
                initial:
                    () => const SizedBox.expand(
                      child: Center(child: LoadingOverlay()),
                    ),
                loading:
                    () => const SizedBox.expand(
                      child: Center(child: LoadingOverlay()),
                    ),
                loaded:
                    (issue) => SingleChildScrollView(
                      child: _buildIssueContent(
                        issue,
                        localization,
                        colorScheme,
                      ),
                    ),
                error: (error) => ReportsErrorView(errorMessage: error.message),
              );
            },
          ),
        ),
      ),
    );
  }

  void _loadIssue(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<IssueDetailsCubit>();
      final currentState = cubit.state;

      currentState.maybeWhen(
        loading: () => {},
        loaded: (issue) {
          if (issue.id != issueId) {
            cubit.getIssueDetails(issueId);
          }
        },
        orElse: () => cubit.getIssueDetails(issueId),
      );
    });
  }

  Widget _buildIssueContent(
    Issue issue,
    AppLocalizations localization,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IssueImageSlider(images: issue.images),
          IssueDetails(issue: issue),
          SizedBox(height: 400.h, child: IssueReportsTabs(issueId: issue.id)),
        ],
      ),
    );
  }
}
