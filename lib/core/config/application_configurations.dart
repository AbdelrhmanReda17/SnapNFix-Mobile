import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:snapnfix/core/config/application_constants.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/utils/helpers/shared_pref_keys.dart';
import 'package:snapnfix/core/infrastructure/storage/secure_storage_service.dart';
import 'package:snapnfix/core/infrastructure/storage/shared_preferences_service.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';

class ApplicationConfigurations with ChangeNotifier {
  // Private services
  final _secureStorage = getIt<SecureStorageService>();
  final _sharedPrefs = getIt<SharedPreferencesService>();

  // Private state variables
  bool _hasViewedOnboarding = false;
  SessionModel? _currentSession;
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
  SessionModel? get currentSession => _currentSession;
  String get language => _language;
  bool get isDarkMode => _isDarkMode;
  bool get isAuthenticated => _currentSession != null;

  // Initialize all settings
  Future<void> init() async {
    await _loadOnboardingStatus();
    await _loadUserSession();
    await _loadLanguage();
    await _loadDarkMode();
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
  Future<void> _loadUserSession() async {
    final sessionString = await _secureStorage.read(
      key: SharedPrefKeys.authenticationSession,
    );
    debugPrint("Session String: $sessionString");
    if (sessionString != null && sessionString.isNotEmpty) {
      try {
        final sessionMap = json.decode(sessionString);
        debugPrint("Session Map: $sessionMap");
        _currentSession = SessionModel.fromJson(sessionMap);
        debugPrint("Current Session: $_currentSession");
      } catch (e) {
        _currentSession = null;
      }
    } else {
      _currentSession = null;
    }
  }

  Future<void> setUserSession(SessionModel session) async {
    _currentSession = session;
    await _secureStorage.write(
      key: SharedPrefKeys.authenticationSession,
      value: json.encode(session.toJson()),
    );
    notifyListeners();
  }

  Future<void> logout() async {
    _currentSession = null;
    await _secureStorage.delete(key: SharedPrefKeys.authenticationSession);
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
