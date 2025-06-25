import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    super.id,
    super.firstName,
    super.lastName,
    super.phoneNumber,
    super.email,
    super.profileImage,
    super.birthDate,
    super.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle birthDate manually before passing to generated fromJson
    if (json.containsKey('birthDate') && json['birthDate'] != null && json['birthDate'].toString().isNotEmpty) {
      try {
        final birthDateStr = json['birthDate'].toString();
        json['dateOfBirth'] = DateTime.parse(birthDateStr);
      } catch (e) {
        print('Error parsing birthDate: $e');
      }
    }
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.unverified({
    required String id,
  }) => UserModel();

  UserModel copyWithVerification() => UserModel(
    id: id,
    firstName: firstName,
    lastName: lastName,
    phoneNumber: phoneNumber,
    email: email,
    profileImage: profileImage,
    birthDate: birthDate,
    gender: gender,
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
    birthDate: birthDate,
    gender: gender,
  );
}
