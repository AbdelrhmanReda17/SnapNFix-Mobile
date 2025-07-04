import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';

part 'get_reports_query.g.dart';

@JsonSerializable()
class GetReportsQuery {
  const GetReportsQuery({
    this.sort,
    this.status,
    this.category,
    this.pageNumber = 1,
    this.pageSize = 10,
  });
  final String? sort;
  final String? status;
  final IssueCategory? category;
  final int pageNumber;
  final int pageSize;

  factory GetReportsQuery.fromJson(Map<String, dynamic> json) =>
      _$GetReportsQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetReportsQueryToJson(this);
}
