import 'package:equatable/equatable.dart';

enum Gender {
  male("Male"),
  female("Female"),
  notSpecified("Not Specified");

  final String displayName;

  const Gender(this.displayName);
}

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? email;
  final String? profileImage;
  final DateTime? dateOfBirth;
  final Gender? gender;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.email,
    this.profileImage,
    this.dateOfBirth,
    this.gender,
  });

  String get fullName => '$firstName $lastName';

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
