import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';

part 'area_info_model.g.dart';

@JsonSerializable()
class AreaInfoModel extends AreaInfo {
  const AreaInfoModel({
    required super.id,
    required super.name,
    required super.state,
    required super.activeIssuesCount,
  });

  factory AreaInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AreaInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaInfoModelToJson(this);
}
