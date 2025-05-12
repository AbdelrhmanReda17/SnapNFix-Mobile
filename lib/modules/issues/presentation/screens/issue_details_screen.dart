import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/core/utils/extensions/navigation.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issue_details_cubit.dart';
import 'package:snapnfix/modules/issues/presentation/screens/issue_details_bloc_listener.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_details/images_slider/issue_images_slider.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_details/issue_descriptions_list.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_details/issue_details.dart';
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
            localization.issueDetails(issueId),
            style: TextStyle(color: colorScheme.primary, fontSize: 20.sp),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary,
            size: 20.sp,
          ),
          elevation: 0,
        ),

        body: SafeArea(
          child: BlocBuilder<IssueDetailsCubit, IssueDetailsState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (issue) => _buildIssueContent(issue),
                loading: () => const LoadingOverlay(),
                error: (error) {
                  setupErrorState(context, error);
                  return const SizedBox.shrink();
                },
                orElse: () => const LoadingOverlay(),
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
        loaded:
            (issue) => {
              if (issue.id != issueId) {cubit.getIssueDetails(issueId)},
            },
        orElse: () => {cubit.getIssueDetails(issueId)},
      );
    });
  }

  Widget _buildIssueContent(Issue issue) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IssueDetailsBlocListener(),
          IssueImageSlider(images: issue.images),
          IssueDetails(issue: issue),
          Expanded(
            child: IssueDescriptionsList(descriptions: issue.descriptions),
          ),
        ],
      ),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    context.pop();
    baseDialog(
      context: context,
      title: 'Fetching Error',
      message: apiErrorModel.getAllErrorMessages(),
      alertType: AlertType.error,
      confirmText: 'Got it',
      onConfirm: () {},
      showCancelButton: false,
    );
  }
}
