import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_issue_details_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';

part 'issue_details_state.dart';
part 'issue_details_cubit.freezed.dart';

class IssueDetailsCubit extends Cubit<IssueDetailsState> {
  final GetIssueDetailsUseCase getIssueDetailsUseCase;

  IssueDetailsCubit({required this.getIssueDetailsUseCase})
    : super(const IssueDetailsState.initial());

  Future<void> getIssueDetails(String issueId) async {
    emit(const IssueDetailsState.loading());

    final result = await getIssueDetailsUseCase(issueId);

    result.when(
      success: (issue) {
        emit(IssueDetailsState.loaded(issue));
      },
      failure: (error) {
        emit(IssueDetailsState.error(error));
      },
    );
  }
}
