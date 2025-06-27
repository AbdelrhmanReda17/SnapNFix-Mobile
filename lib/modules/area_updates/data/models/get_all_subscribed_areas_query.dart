import 'package:json_annotation/json_annotation.dart';

part 'get_all_subscribed_areas_query.g.dart';

@JsonSerializable()
class GetAllSubscribedAreasQuery {
  const GetAllSubscribedAreasQuery({this.searchTerm, this.pageNumber = 1, this.pageSize = 10});
  final String? searchTerm;
  final int pageNumber;
  final int pageSize;

  factory GetAllSubscribedAreasQuery.fromJson(Map<String, dynamic> json) =>
      _$GetAllSubscribedAreasQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllSubscribedAreasQueryToJson(this);  
}
