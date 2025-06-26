import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/index.dart';

part 'get_area_issues_query.g.dart';

@JsonSerializable()
class GetAreaIssuesQuery {
  const GetAreaIssuesQuery({this.status, this.page = 1, this.limit = 10});
  final IssueStatus? status;
  final int page;
  final int limit;
  factory GetAreaIssuesQuery.fromJson(Map<String, dynamic> json) =>
      _$GetAreaIssuesQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetAreaIssuesQueryToJson(this);
}
