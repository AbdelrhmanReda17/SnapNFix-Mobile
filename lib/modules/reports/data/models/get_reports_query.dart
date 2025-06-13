import 'package:json_annotation/json_annotation.dart';

part 'get_reports_query.g.dart';

@JsonSerializable()
class GetReportsQuery {
  const GetReportsQuery({
    this.sort,
    this.status,
    this.category,
    this.page = 1,
    this.limit = 10,
  });
  final String? sort;
  final String? status;
  final String? category;
  final int page;
  final int limit;

  factory GetReportsQuery.fromJson(Map<String, dynamic> json) =>
      _$GetReportsQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetReportsQueryToJson(this);
}
