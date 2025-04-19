import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:snapnfix/core/application_constants.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/helpers/shared_pref_keys.dart';
import 'package:snapnfix/core/services/secure_storage_service.dart';
import 'package:snapnfix/core/services/shared_preferences_service.dart';

class ApplicationConfigurations with ChangeNotifier {
  // Private services
  final _secureStorage = getIt<SecureStorageService>();
  final _sharedPrefs = getIt<SharedPreferencesService>();

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
    _hasViewedOnboarding = _sharedPrefs.getBool(
      SharedPrefKeys.hasViewedOnboarding,
    );
  }

  Future<void> setOnboardingComplete() async {
    _hasViewedOnboarding = true;
    await _sharedPrefs.setBool(SharedPrefKeys.hasViewedOnboarding, true);
    notifyListeners();
  }

  // Authentication methods
  Future<void> _loadUserToken() async {
    final token = await _secureStorage.read(key: SharedPrefKeys.userToken);
    _userToken = token ?? "";
  }

  Future<void> setUserToken(String token) async {
    _userToken = token;
    await _secureStorage.write(key: SharedPrefKeys.userToken, value: token);
    notifyListeners();
  }

  Future<void> logout() async {
    _userToken = "";
    await _secureStorage.write(key: SharedPrefKeys.userToken, value: "");
    notifyListeners();
  }

  // Language methods
  Future<void> _loadLanguage() async {
    final storedLanguage = await _secureStorage.read(
      key: SharedPrefKeys.language,
    );
    _language = storedLanguage ?? "en";

    if (_language.isEmpty ||
        _language == "null" ||
        ApplicationConstants.availableLanguages[_language] == null) {
      _language = "en";
    }
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (ApplicationConstants.availableLanguages[newLanguage] != null) {
      _language = newLanguage;
      await _secureStorage.write(
        key: SharedPrefKeys.language,
        value: newLanguage,
      );
      notifyListeners();
    }
  }

  // Dark mode methods
  Future<void> _loadDarkMode() async {
    _isDarkMode = _sharedPrefs.getBool(SharedPrefKeys.isDarkMode);
  }

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    await _sharedPrefs.setBool(SharedPrefKeys.isDarkMode, value);
    notifyListeners();
  }
}
