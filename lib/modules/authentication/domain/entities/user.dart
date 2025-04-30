import 'package:equatable/equatable.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';

class User extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String phoneNumber;
  final String? email;
  final String? profileImage;
  final DateTime? dateOfBirth;
  final UserGender? gender;

  const User({
    required this.id,
    this.firstName,
    this.lastName,
    required this.phoneNumber,
    this.email,
    this.profileImage,
    this.dateOfBirth,
    this.gender,
  });

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    phoneNumber,
    email,
    profileImage,
    dateOfBirth,
    gender,
  ];
}
