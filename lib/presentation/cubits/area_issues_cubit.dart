import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_area_issues_use_case.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';
import 'area_issues_state.dart';

class AreaIssuesCubit extends Cubit<AreaIssuesState> {
  final GetAreaIssuesUseCase _getAreaIssuesUseCase;

  AreaIssuesCubit({
    required String areaName,
    required GetAreaIssuesUseCase getAreaIssuesUseCase,
  }) : _getAreaIssuesUseCase = getAreaIssuesUseCase,
       super(const AreaIssuesState.initial()) {
    loadAreaIssues(areaName);
  }

  Future<void> loadAreaIssues(String areaName) async {
    emit(const AreaIssuesState.loading());

    try {
      final result = await _getAreaIssuesUseCase(areaName);

      result.when(
        success: (issues) {
          emit(AreaIssuesState.loaded(issues: issues, areaName: areaName));
        },
        failure: (error) {
          emit(AreaIssuesState.error(error.message));
        },
      );
    } catch (e) {
      emit(AreaIssuesState.error('Failed to load issues: ${e.toString()}'));
    }
  }

  void toggleSubscription() {
    state.maybeWhen(
      loaded: (issues, areaName, isSubscribed, selectedStatuses) {
        emit(
          AreaIssuesState.loaded(
            issues: issues,
            areaName: areaName,
            isSubscribed: !isSubscribed,
            selectedStatuses: selectedStatuses,
          ),
        );
      },
      orElse: () {},
    );
  }

  void toggleStatusFilter(IssueStatus status) {
    state.maybeWhen(
      loaded: (issues, areaName, isSubscribed, selectedStatuses) {
        final currentStatuses = List<IssueStatus>.from(selectedStatuses);

        if (currentStatuses.contains(status)) {
          currentStatuses.remove(status);
        } else {
          currentStatuses.add(status);
        }

        emit(
          AreaIssuesState.loaded(
            issues: issues,
            areaName: areaName,
            isSubscribed: isSubscribed,
            selectedStatuses: currentStatuses,
          ),
        );
      },
      orElse: () {},
    );
  }

  void clearFilters() {
    state.maybeWhen(
      loaded: (issues, areaName, isSubscribed, selectedStatuses) {
        emit(
          AreaIssuesState.loaded(
            issues: issues,
            areaName: areaName,
            isSubscribed: isSubscribed,
            selectedStatuses: [],
          ),
        );
      },
      orElse: () {},
    );
  }

  void navigateToIssueDetails(BuildContext context, String issueId) {
    context.push(
      Routes.issueDetails.replaceAll(':issueId', issueId),
      extra: issueId,
    );
  }

  List<Issue> getFilteredIssues() {
    return state.maybeWhen(
      loaded: (issues, areaName, isSubscribed, selectedStatuses) {
        if (selectedStatuses.isEmpty) {
          return issues;
        }

        return issues
            .where((issue) => selectedStatuses.contains(issue.status))
            .toList();
      },
      orElse: () => [],
    );
  }
}
