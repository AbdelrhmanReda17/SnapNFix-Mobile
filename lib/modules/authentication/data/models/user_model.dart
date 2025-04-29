import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    super.firstName,
    super.lastName,
    required super.phoneNumber,
    super.email,
    super.profileImage,
    super.dateOfBirth,
    super.gender,
    super.isVerified = false,
    super.isProfileComplete = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.unverified({
    required String id,
    required String phoneNumber,
  }) => UserModel(
    id: id,
    phoneNumber: phoneNumber,
    isVerified: false,
    isProfileComplete: false,
  );

  UserModel copyWithVerification() => UserModel(
    id: id,
    firstName: firstName,
    lastName: lastName,
    phoneNumber: phoneNumber,
    email: email,
    profileImage: profileImage,
    dateOfBirth: dateOfBirth,
    gender: gender,
    isVerified: true,
    isProfileComplete: isProfileComplete,
  );

  UserModel copyWithProfile({
    required String firstName,
    required String lastName,
    UserGender? gender,
    DateTime? dateOfBirth,
  }) => UserModel(
    id: id,
    firstName: firstName,
    lastName: lastName,
    phoneNumber: phoneNumber,
    email: email,
    profileImage: profileImage,
    dateOfBirth: dateOfBirth,
    gender: gender,
    isVerified: isVerified,
    isProfileComplete: true,
  );
}
