import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_description.dart';

part 'issue_description_model.g.dart';

@JsonSerializable(explicitToJson: true)
class IssueDescriptionModel extends IssueDescription {
  const IssueDescriptionModel({
    required super.id,
    required super.username,
    super.userImage,
    required super.text,
    required super.createdAt,
  });

  factory IssueDescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$IssueDescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$IssueDescriptionModelToJson(this);
}