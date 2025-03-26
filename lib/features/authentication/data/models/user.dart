import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String name;
  String phoneNumber;
  String? profileImage;
  String password;
  String token;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.profileImage,
    required this.password,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      password: json['password'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'profileImage': profileImage,
    'password': password,
    'token': token,
  };
}
