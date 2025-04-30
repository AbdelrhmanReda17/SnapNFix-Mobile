class UnverifiedUserException implements Exception {
  final String phoneNumber;
  final String message;

  UnverifiedUserException({
    required this.phoneNumber,
    this.message = 'User needs to verify phone number',
  });
}