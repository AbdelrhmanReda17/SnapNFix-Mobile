import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';




@singleton
class SharedPreferencesService {
  late final SharedPreferences _prefs;

  // Initialize the service
  Future<void> init() async {
    debugPrint('💾 SharedPreferences: Initializing service');
    _prefs = await SharedPreferences.getInstance();
  }

  // Store string value
  Future<bool> setString(String key, String value) async {
    debugPrint('💾 SharedPreferences: Setting string for key "$key"');
    return await _prefs.setString(key, value);
  }

  // Read string value
  String getString(String key, {String defaultValue = ''}) {
    debugPrint('💾 SharedPreferences: Getting string for key "$key"');
    return _prefs.getString(key) ?? defaultValue;
  }

  // Store boolean value
  Future<bool> setBool(String key, bool value) async {
    debugPrint('💾 SharedPreferences: Setting bool for key "$key"');
    return await _prefs.setBool(key, value);
  }

  // Read boolean value
  bool getBool(String key, {bool defaultValue = false}) {
    debugPrint('💾 SharedPreferences: Getting bool for key "$key"');
    return _prefs.getBool(key) ?? defaultValue;
  }

  // Store integer value
  Future<bool> setInt(String key, int value) async {
    debugPrint('💾 SharedPreferences: Setting int for key "$key"');
    return await _prefs.setInt(key, value);
  }

  // Read integer value
  int getInt(String key, {int defaultValue = 0}) {
    debugPrint('💾 SharedPreferences: Getting int for key "$key"');
    return _prefs.getInt(key) ?? defaultValue;
  }

  // Store double value
  Future<bool> setDouble(String key, double value) async {
    debugPrint('💾 SharedPreferences: Setting double for key "$key"');
    return await _prefs.setDouble(key, value);
  }

  // Read double value
  double getDouble(String key, {double defaultValue = 0.0}) {
    debugPrint('💾 SharedPreferences: Getting double for key "$key"');
    return _prefs.getDouble(key) ?? defaultValue;
  }

  // Store string list
  Future<bool> setStringList(String key, List<String> value) async {
    debugPrint('💾 SharedPreferences: Setting string list for key "$key"');
    return await _prefs.setStringList(key, value);
  }

  // Read string list
  List<String> getStringList(
    String key, {
    List<String> defaultValue = const [],
  }) {
    debugPrint('💾 SharedPreferences: Getting string list for key "$key"');
    return _prefs.getStringList(key) ?? defaultValue;
  }

  // Check if key exists
  bool containsKey(String key) {
    debugPrint('💾 SharedPreferences: Checking if contains key "$key"');
    return _prefs.containsKey(key);
  }

  // Remove a specific key
  Future<bool> remove(String key) async {
    debugPrint('💾 SharedPreferences: Removing key "$key"');
    return await _prefs.remove(key);
  }

  // Clear all data
  Future<bool> clear() async {
    debugPrint('💾 SharedPreferences: Clearing all data');
    return await _prefs.clear();
  }
}
