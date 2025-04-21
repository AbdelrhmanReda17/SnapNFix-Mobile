extension Validations on String {
  bool _validateEmail(String email) {
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp emailRegex = RegExp(emailPattern);
    return emailRegex.hasMatch(email);
  }

  bool _validatePhoneNumber(String phoneNumber) {
    const phonePattern = r'^(01[0-2,5]{1}[0-9]{8})$';
    final RegExp phoneRegex = RegExp(phonePattern);
    return phoneRegex.hasMatch(phoneNumber);
  }

  bool _validatePassword(String password) {
    const passwordPattern =
        r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*,.?\-_+=])[\w!@#\$%^&*,.?\-_+=]{8,}$';
    final RegExp passwordRegex = RegExp(passwordPattern);
    return passwordRegex.hasMatch(password);
  }

  bool _validateConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  bool _validateFirstAndLastName(String name) {
    const namePattern = r'^[a-zA-Z]{3,}$';
    final RegExp nameRegex = RegExp(namePattern);
    return nameRegex.hasMatch(name);
  }

  bool get isValidEmail => _validateEmail(this);
  bool get isValidPhoneNumber => _validatePhoneNumber(this);
  bool get isValidPassword => _validatePassword(this);
  bool get isValidFirstName => _validateFirstAndLastName(this);
  bool get isValidLastName => _validateFirstAndLastName(this);
  bool isValidConfirmPassword(String confirmPassword) =>
      _validateConfirmPassword(this, confirmPassword);

  bool get isValidEmailOrPhone => isValidEmail || isValidPhoneNumber;

  bool get isNotEmpty => this.isNotEmpty;
}
