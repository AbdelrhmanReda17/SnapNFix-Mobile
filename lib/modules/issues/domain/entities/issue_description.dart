import 'package:equatable/equatable.dart';

class IssueDescription extends Equatable {
  final String id;
  final String text;
  final DateTime createdAt;
  final String username;
  final String? userImage;

  const IssueDescription({
    required this.id,
    required this.text,
    required this.username,
    required this.createdAt,
    this.userImage,
  });

  @override
  List<Object?> get props => [id, text, username, createdAt, userImage];
}
