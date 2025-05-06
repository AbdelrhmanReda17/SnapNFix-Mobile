import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';

part 'channels_state.freezed.dart';

@freezed
class ChannelsState with _$ChannelsState {
  const factory ChannelsState({
    required String selectedChannel,
    required bool isSubscribed,
    required List<String> channels,
    required Map<String, List<IssueUpdate>> updates,
    @Default([]) List<IssueStatus> selectedStatuses,
  }) = _ChannelsState;

  factory ChannelsState.initial() => const ChannelsState(
    selectedChannel: 'Nasr City',
    isSubscribed: false,
    channels: ['Nasr City', 'Downtown', 'Maadi', 'Zamalek', 'Heliopolis'],
    updates: {
      'Nasr City': [
        IssueUpdate(id: '325', status: IssueStatus.fixed, time: '10:32 AM'),
        IssueUpdate(id: '132', status: IssueStatus.inProgress, time: '08:18 AM'),
        IssueUpdate(id: '129', status: IssueStatus.pending, time: 'Yesterday'),
      ],
      'Downtown': [
        IssueUpdate(id: '218', status: IssueStatus.inProgress, time: '11:45 AM'),
        IssueUpdate(id: '201', status: IssueStatus.fixed, time: 'Yesterday'),
      ],
      'Maadi': [
        IssueUpdate(id: '156', status: IssueStatus.pending, time: '09:20 AM'),
        IssueUpdate(id: '145', status: IssueStatus.fixed, time: 'Yesterday'),
      ],
      'Zamalek': [
        IssueUpdate(id: '102', status: IssueStatus.inProgress, time: 'Today'),
        IssueUpdate(id: '99', status: IssueStatus.fixed, time: 'Yesterday'),
      ],
      'Heliopolis': [
        IssueUpdate(id: '87', status: IssueStatus.pending, time: 'Today'),
        IssueUpdate(id: '76', status: IssueStatus.fixed, time: 'Yesterday'),
        IssueUpdate(id: '78', status: IssueStatus.inProgress, time: '11:45 AM'),
        IssueUpdate(id: '79', status: IssueStatus.fixed, time: 'Yesterday'),
      ],
    },
  );
}

class IssueUpdate {
  final String id;
  final IssueStatus status;
  final String time;

  const IssueUpdate({
    required this.id,
    required this.status,
    required this.time,
  });
}