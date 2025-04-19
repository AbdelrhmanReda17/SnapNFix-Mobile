import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Store string value
  Future<void> write({required String key, required String value}) async {
    debugPrint('🔒 SecureStorage: Writing to key "$key"');
    await _storage.write(key: key, value: value);
  }

  // Read string value
  Future<String?> read({required String key}) async {
    debugPrint('🔒 SecureStorage: Reading from key "$key"');
    return await _storage.read(key: key);
  }

  // Delete a specific key
  Future<void> delete({required String key}) async {
    debugPrint('🔒 SecureStorage: Deleting key "$key"');
    await _storage.delete(key: key);
  }

  // Get all stored key-value pairs
  Future<Map<String, String>> readAll() async {
    debugPrint('🔒 SecureStorage: Reading all values');
    return await _storage.readAll();
  }

  // Delete all stored data
  Future<void> deleteAll() async {
    debugPrint('🔒 SecureStorage: Deleting all data');
    await _storage.deleteAll();
  }

  // Store JSON object
  Future<void> writeJson({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    debugPrint('🔒 SecureStorage: Writing JSON to key "$key"');
    final jsonString = jsonEncode(value);
    await _storage.write(key: key, value: jsonString);
  }

  // Read JSON object
  Future<Map<String, dynamic>?> readJson({required String key}) async {
    debugPrint('🔒 SecureStorage: Reading JSON from key "$key"');
    final value = await _storage.read(key: key);
    if (value == null) return null;

    try {
      return jsonDecode(value) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('🔒 SecureStorage: Error decoding JSON: $e');
      return null;
    }
  }

  // Store list of JSON objects
  Future<void> writeJsonList({
    required String key,
    required List<Map<String, dynamic>> value,
  }) async {
    debugPrint('🔒 SecureStorage: Writing JSON list to key "$key"');
    final jsonString = jsonEncode(value);
    await _storage.write(key: key, value: jsonString);
  }

  // Read list of JSON objects
  Future<List<Map<String, dynamic>>> readJsonList({required String key}) async {
    debugPrint('🔒 SecureStorage: Reading JSON list from key "$key"');
    final value = await _storage.read(key: key);
    if (value == null) return [];

    try {
      final List<dynamic> list = jsonDecode(value);
      return list.map((item) => Map<String, dynamic>.from(item)).toList();
    } catch (e) {
      debugPrint('🔒 SecureStorage: Error decoding JSON list: $e');
      return [];
    }
  }
}
