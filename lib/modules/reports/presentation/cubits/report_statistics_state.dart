import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/reports/data/models/report_statistics_model.dart';

part 'report_statistics_state.freezed.dart';
part 'report_statistics_state.g.dart';

@freezed
class ReportStatisticsState with _$ReportStatisticsState {
  const factory ReportStatisticsState({
    ReportStatisticsModel? statistics,
    @Default(true) bool isLoading,
    String? error,
    DateTime? lastUpdated,
  }) = _ReportStatisticsState;

  factory ReportStatisticsState.fromJson(Map<String, dynamic> json) =>
      _$ReportStatisticsStateFromJson(json);
}
