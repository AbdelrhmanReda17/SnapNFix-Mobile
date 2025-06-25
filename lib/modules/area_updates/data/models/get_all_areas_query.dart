import 'package:json_annotation/json_annotation.dart';

part 'get_all_areas_query.g.dart';

@JsonSerializable()
class GetAllAreasQuery {
  const GetAllAreasQuery({this.searchTerm, this.page = 1, this.limit = 10});
  final String? searchTerm;
  final int page;
  final int limit;

  factory GetAllAreasQuery.fromJson(Map<String, dynamic> json) =>
      _$GetAllAreasQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllAreasQueryToJson(this);
}
