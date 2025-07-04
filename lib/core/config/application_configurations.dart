import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../index.dart';

@singleton
class ApplicationConfigurations with ChangeNotifier {
  final SharedPreferencesService _sharedPrefs;
  final SecureStorageService _secureStorage;

  bool _hasViewedOnboarding = false;
  SessionModel? _currentSession;
  String _language = "en";
  bool _isDarkMode = false;

  ApplicationConfigurations(this._sharedPrefs, this._secureStorage);

  bool get hasViewedOnboarding => _hasViewedOnboarding;
  SessionModel? get currentSession => _currentSession;
  String get language => _language;
  bool get isDarkMode => _isDarkMode;
  bool get isAuthenticated => _currentSession != null;

  Future<void> init() async {
    debugPrint("Initializing application configurations...");
    await _loadOnboardingStatus();
    await _loadUserSession();
    await _loadLanguagePreference();
    await _loadThemePreference();
  }

  Future<void> updateSessionTokens(TokensModel tokens) {
    if (_currentSession != null) {
      _currentSession = _currentSession!.copyWith(tokens: tokens);
      debugPrint("Updated Session: $_currentSession");
      notifyListeners();
      return setUserSession(_currentSession!);
    }
    return Future.value();
  }

  Future<void> updateSessionUser(UserModel user) {
    if (_currentSession != null) {
      _currentSession = _currentSession!.copyWith(user: user);
      debugPrint("Updated Session User: ${_currentSession!.user}");
      
      notifyListeners();
      return setUserSession(_currentSession!);
    }
    return Future.value();
  }

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

  Future<void> _loadUserSession() async {
    final sessionString = await _secureStorage.read(
      key: SharedPrefKeys.authenticationSession,
    );
    if (sessionString != null && sessionString.isNotEmpty) {
      try {
        final sessionMap = json.decode(sessionString);
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

  Future<void> _loadLanguagePreference() async {
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

  Future<void> _loadThemePreference() async {
    _isDarkMode = _sharedPrefs.getBool(SharedPrefKeys.isDarkMode);
  }

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    await _sharedPrefs.setBool(SharedPrefKeys.isDarkMode, value);
    notifyListeners();
  }
}
