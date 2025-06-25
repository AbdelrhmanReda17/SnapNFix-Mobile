import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/modules/issues/index.dart';
import 'package:snapnfix/core/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue_details_state.dart';
part 'issue_details_cubit.freezed.dart';

class IssueDetailsCubit extends Cubit<IssueDetailsState> {
  final GetIssueDetailsUseCase getIssueDetailsUseCase;

  IssueDetailsCubit({required this.getIssueDetailsUseCase})
    : super(const IssueDetailsState.initial());
  Future<void> getIssueDetails(String issueId) async {
    if (isClosed) return;
    emit(const IssueDetailsState.loading());

    final result = await getIssueDetailsUseCase(issueId);

    if (isClosed) return;
    result.when(
      success: (issue) {
        if (isClosed) return;
        emit(IssueDetailsState.loaded(issue));
      },
      failure: (error) {
        if (isClosed) return;
        emit(IssueDetailsState.error(error));
      },
    );
  }
}
