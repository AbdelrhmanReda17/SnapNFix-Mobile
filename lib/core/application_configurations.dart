import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:snapnfix/core/application_constants.dart';
import 'package:snapnfix/core/helpers/shared_pref_helper.dart';
import 'package:snapnfix/core/helpers/shared_pref_keys.dart';

class ApplicationConfigurations with ChangeNotifier {
  // Private state variables
  bool _hasViewedOnboarding = false;
  String _userToken = "";
  String _language = "en";
  bool _isDarkMode = false;

  // Singleton pattern
  static final ApplicationConfigurations _instance =
      ApplicationConfigurations._internal();

  // Static getter for the singleton instance
  static ApplicationConfigurations get instance => _instance;

  // Factory constructor
  factory ApplicationConfigurations() => _instance;

  // Private constructor
  ApplicationConfigurations._internal();

  // Getters
  bool get hasViewedOnboarding => _hasViewedOnboarding;
  String get userToken => _userToken;
  String get language => _language;
  bool get isDarkMode => _isDarkMode;
  bool get isAuthenticated => _userToken.isNotEmpty && _userToken != "null";

  // Initialize all settings
  Future<void> init() async {
    await _loadOnboardingStatus();
    await _loadUserToken();
    await _loadLanguage();
    await _loadDarkMode();
    log(
      "ApplicationConfigurations initialized: Dark Mode: $_isDarkMode, Language: $_language",
    );
  }

  // Onboarding methods
  Future<void> _loadOnboardingStatus() async {
    _hasViewedOnboarding =
        await SharedPrefHelper.getBool(SharedPrefKeys.hasViewedOnboarding) ??
        false;
  }

  Future<void> setOnboardingComplete() async {
    _hasViewedOnboarding = true;
    await SharedPrefHelper.setData(SharedPrefKeys.hasViewedOnboarding, true);
    notifyListeners();
  }

  // Authentication methods
  Future<void> _loadUserToken() async {
    _userToken =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken) ?? "";
  }

  Future<void> setUserToken(String token) async {
    _userToken = token;
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    notifyListeners();
  }

  Future<void> logout() async {
    _userToken = "";
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, "");
    notifyListeners();
  }

  // Language methods
  Future<void> _loadLanguage() async {
    _language =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.language) ??
        "en";
    if (_language.isEmpty ||
        _language == "null" ||
        ApplicationConstants.availableLanguages[_language] == null) {
      _language = "en";
    }
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (ApplicationConstants.availableLanguages[newLanguage] != null) {
      _language = newLanguage;
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.language,
        newLanguage,
      );
      notifyListeners();
    }
  }

  // Dark mode methods
  Future<void> _loadDarkMode() async {
    _isDarkMode =
        await SharedPrefHelper.getBool(SharedPrefKeys.isDarkMode) ?? false;
  }

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    await SharedPrefHelper.setData(SharedPrefKeys.isDarkMode, value);
    notifyListeners();
  }
}
