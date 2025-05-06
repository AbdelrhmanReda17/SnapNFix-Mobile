import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/presentation/cubits/channels_state.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ChannelsCubit extends Cubit<ChannelsState> {
  ChannelsCubit() : super(ChannelsState.initial());

  void selectChannel(String channel) {
    emit(state.copyWith(selectedChannel: channel));
  }

  void toggleSubscription() {
    emit(state.copyWith(isSubscribed: !state.isSubscribed));
  }

  void toggleStatusFilter(IssueStatus status) {
    final currentStatuses = List<IssueStatus>.from(state.selectedStatuses);
    if (currentStatuses.contains(status)) {
      currentStatuses.remove(status);
    } else {
      currentStatuses.add(status);
    }
    emit(state.copyWith(selectedStatuses: currentStatuses));
  }

  void clearFilters() {
    emit(state.copyWith(selectedStatuses: []));
  }

  void navigateToIssueDetails(BuildContext context, String issueId) {
    context.push(
      Routes.issueDetails,
      extra: issueId,
    );
  }
  Future<void> refreshUpdates() async {
    // TODOfetching from your backend
    // For now, we'll just simulate a network delay
    await Future.delayed(const Duration(seconds: 1));
    // Re-emit the current state to trigger a rebuild
    emit(state.copyWith());
  }

  List<IssueUpdate> getFilteredUpdates() {
    final updates = state.updates[state.selectedChannel] ?? [];
    if (state.selectedStatuses.isEmpty) return updates;
    return updates.where((update) =>
      state.selectedStatuses.contains(update.status)
    ).toList();
  }
}