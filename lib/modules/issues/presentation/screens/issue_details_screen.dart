import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/index.dart';
import 'package:snapnfix/modules/issues/index.dart';
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
            "Issue Details",
            style: TextStyle(color: colorScheme.primary, fontSize: 20.sp),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary,
            size: 20.sp,
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const IssueDetailsBlocListener(),
                BlocBuilder<IssueDetailsCubit, IssueDetailsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loaded:
                          (issue) => _buildIssueContent(
                            issue,
                            localization,
                            colorScheme,
                          ),
                      loading: () => const LoadingOverlay(),
                      error: (_) => const LoadingOverlay(),
                      orElse: () => const LoadingOverlay(),
                    );
                  },
                ),
              ],
            ),
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
          // Expanded(child: IssueDescriptionsList(descriptions: "ARasdasdasd")),
        ],
      ),
    );
  }
}
