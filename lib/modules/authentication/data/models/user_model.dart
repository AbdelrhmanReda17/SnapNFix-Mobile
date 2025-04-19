import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    super.phoneNumber,
    super.email,
    super.profileImage,
    super.dateOfBirth,
    super.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Alternative manual implementation if you don't want to use JsonSerializable
  factory UserModel.fromJsonManual(Map<String, dynamic> json) {
    return UserModel(
      id: json['userId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
      dateOfBirth:
          json['dateOfBirth'] != null
              ? DateTime.parse(json['dateOfBirth'] as String)
              : null,
      gender:
          json['gender'] != null
              ? Gender.values.firstWhere(
                (e) => e.toString() == 'Gender.${json['gender']}',
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
