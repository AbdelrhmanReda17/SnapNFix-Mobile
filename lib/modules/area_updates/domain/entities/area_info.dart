import 'package:equatable/equatable.dart';

class AreaInfo extends Equatable {
  final String id;
  final String name;
  final String state;
  final int activeIssuesCount;

  const AreaInfo({
    required this.id,
    required this.name,
    required this.state,
    required this.activeIssuesCount,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    state,
    activeIssuesCount,
  ];
}
