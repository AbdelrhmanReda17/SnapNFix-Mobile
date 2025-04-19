import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapnfix/core/helpers/shared_pref_keys.dart';
import 'package:snapnfix/core/services/shared_preferences_service.dart';

class OfflineReportsRepository {
  final SharedPreferencesService _sharedPreferencesService;

  final ValueNotifier<int> pendingReportsCountNotifier = ValueNotifier<int>(0);

  OfflineReportsRepository(this._sharedPreferencesService) {
    _initPendingReportsCount();
  }

  Future<void> _initPendingReportsCount() async {
    final count = getPendingReportsCount();
    pendingReportsCountNotifier.value = count;
  }

  int getPendingReportsCount() {
    final pendingReportsCount = _sharedPreferencesService.getInt(
      SharedPrefKeys.pendingReports,
      defaultValue: 0,
    );
    debugPrint('📊 Current pending reports count: $pendingReportsCount');
    return pendingReportsCount;
  }

  void incrementPendingReportsCount() {
    final currentCount = getPendingReportsCount();
    final newCount = currentCount + 1;

    _sharedPreferencesService.setInt(SharedPrefKeys.pendingReports, newCount);

    pendingReportsCountNotifier.value = newCount;

    debugPrint('📊 Incremented pending reports count: $newCount');
  }

  void decrementPendingReportsCount() {
    final currentCount = getPendingReportsCount();
    if (currentCount > 0) {
      final newCount = currentCount - 1;

      _sharedPreferencesService.setInt(SharedPrefKeys.pendingReports, newCount);

      pendingReportsCountNotifier.value = newCount;

      debugPrint('📊 Decremented pending reports count: $newCount');
    }
  }

  void setPendingReportsCount(int count) {
    final validCount = count < 0 ? 0 : count;

    _sharedPreferencesService.setInt(SharedPrefKeys.pendingReports, validCount);

    pendingReportsCountNotifier.value = validCount;

    debugPrint('📊 Set pending reports count: $validCount');
  }

  Future<Directory> getOfflineReportsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return Directory('${directory.path}/offline_reports');
  }

  void dispose() {
    pendingReportsCountNotifier.dispose();
  }
}
