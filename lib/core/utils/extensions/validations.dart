import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  bool _validateName(String fullName) {
    const fullNamePattern = r'^[a-zA-Z]{3,20}$';
    final RegExp fullNameRegex = RegExp(fullNamePattern);
    return fullNameRegex.hasMatch(fullName);
  }

  String? validateReportDescription(BuildContext context) {
    if (isEmpty) {
      return AppLocalizations.of(context)?.reportDescriptionRequired ??
          "Report description is required";
    }
    if (length < 10) {
      return AppLocalizations.of(context)?.reportDescriptionMinLength ??
          "Report description must be at least 10 characters long"; 
    }
    return null;
  }

  bool get isValidEmail => _validateEmail(this);
  bool get isValidPhoneNumber => _validatePhoneNumber(this);
  bool get isValidPassword => _validatePassword(this);
  bool get isValidName => _validateName(this);
  bool isValidConfirmPassword(String confirmPassword) =>
      _validateConfirmPassword(this, confirmPassword);

  bool get isValidEmailOrPhone => isValidEmail || isValidPhoneNumber;

  bool get isNotEmpty => this.isNotEmpty;

  bool get isValidReportDescription => isNotEmpty && length >= 10;
}
