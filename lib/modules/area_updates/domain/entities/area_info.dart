import 'package:equatable/equatable.dart';


class AreaInfo extends Equatable {
  final int cityId;
  final String cityName;
  final String state;
  final int activeIssuesCount;

  const AreaInfo({
    required this.cityId,
    required this.cityName,
    required this.state,
    required this.activeIssuesCount,
  });

  @override
  List<Object?> get props => [
    cityId,
    cityName,
    state,
    activeIssuesCount,
  ];
}
