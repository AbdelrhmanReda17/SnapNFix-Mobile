import 'package:equatable/equatable.dart';


class AreaInfo extends Equatable {
  final String name;
  final String displayName;
  final String governorate;
  final int issuesCount;
  final DateTime lastUpdated;

  const AreaInfo({
    required this.name,
    required this.displayName,
    required this.governorate,
    required this.issuesCount,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [
    name,
    displayName,
    governorate,
    issuesCount,
    lastUpdated,
  ];
}
