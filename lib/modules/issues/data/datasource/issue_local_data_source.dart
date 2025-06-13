import 'dart:convert';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/core/infrastructure/storage/shared_preferences_service.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import '../models/issue_model.dart';

abstract class BaseIssueLocalDataSource {
  Future<List<IssueMarker>> getNearbyIssues({
    required LatLngBounds bounds,
    required int maxResults,
  });

  Future<IssueModel?> getIssueById(String id);

  Future<bool> isIssueFresh(String id);

  Future<void> cacheIssue(IssueModel issue);

  Future<void> cacheIssues(List<IssueModel> issues);

  Future<List<IssueModel>> searchIssues(String query);

  Future<void> clearCache();
}

class IssueLocalDataSource implements BaseIssueLocalDataSource {
  IssueLocalDataSource(this._prefs);

  static const Duration _cacheValidDuration = Duration(hours: 1);
  static const String _issuesKey = 'cached_issues';
  static const String _issueTimestampsKey = 'cached_issue_timestamps';

  final SharedPreferencesService _prefs;

  @override
  Future<void> cacheIssue(IssueModel issue) async {
    try {
      // Cache the issue data
      final cachedData = _prefs.getString(_issuesKey);
      final Map<String, dynamic> cachedIssuesMap;

      if (cachedData != '') {
        cachedIssuesMap = json.decode(cachedData);
        final issues =
            (cachedIssuesMap['issues'] as List).cast<Map<String, dynamic>>();

        // Update existing issue or add new one
        final index = issues.indexWhere((i) => i['id'] == issue.id);
        if (index != -1) {
          issues[index] = issue.toJson();
        } else {
          issues.add(issue.toJson());
        }

        cachedIssuesMap['issues'] = issues;
      } else {
        cachedIssuesMap = {
          'issues': [issue.toJson()],
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      await _prefs.setString(_issuesKey, json.encode(cachedIssuesMap));

      // Store individual issue timestamp
      final timestamps = _getTimestampsMap();
      timestamps[issue.id] = DateTime.now().toIso8601String();
      await _prefs.setString(_issueTimestampsKey, json.encode(timestamps));
    } catch (e) {
      // Handle cache error
      print('Cache error: $e');
    }
  }

  @override
  Future<bool> isIssueFresh(String id) async {
    try {
      final timestamps = _getTimestampsMap();
      final timestamp = timestamps[id];

      if (timestamp == null) return false;

      final cachedTime = DateTime.parse(timestamp);
      return DateTime.now().difference(cachedTime) <= _cacheValidDuration;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> _getTimestampsMap() {
    final timestampsString = _prefs.getString(_issueTimestampsKey);
    if (timestampsString == '') {
      return {};
    }
    return json.decode(timestampsString) as Map<String, dynamic>;
  }

  @override
  Future<void> cacheIssues(List<IssueModel> issues) async {
    try {
      final cachedData = {
        'issues': issues.map((issue) => issue.toJson()).toList(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      await _prefs.setString(_issuesKey, json.encode(cachedData));

      // Update individual timestamps
      final timestamps = _getTimestampsMap();
      final now = DateTime.now().toIso8601String();

      for (final issue in issues) {
        timestamps[issue.id] = now;
      }

      await _prefs.setString(_issueTimestampsKey, json.encode(timestamps));
    } catch (e) {
      print('Cache error: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    await _prefs.remove(_issuesKey);
    await _prefs.remove(_issueTimestampsKey);
  }

  @override
  Future<IssueModel?> getIssueById(String id) async {
    try {
      final cachedData = _prefs.getString(_issuesKey);
      if (cachedData == '') return null;

      final cachedIssuesMap = json.decode(cachedData) as Map<String, dynamic>;
      final issues = (cachedIssuesMap['issues'] as List).map(
        (issueJson) => IssueModel.fromJson(issueJson),
      );

      return issues.firstWhere(
        (issue) => issue.id == id,
        orElse: () => throw Exception('Issue not found'),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<IssueMarker>> getNearbyIssues({
    required LatLngBounds bounds,
    required int maxResults,
  }) async {
    try {
      final cachedData = _prefs.getString(_issuesKey);
      if (cachedData == '') return [];

      final cachedIssuesMap = json.decode(cachedData) as Map<String, dynamic>;
      final lastUpdated = DateTime.parse(cachedIssuesMap['timestamp']);

      // Check if cache is still valid
      if (DateTime.now().difference(lastUpdated) > _cacheValidDuration) {
        await clearCache();
        return [];
      }

      final issues =
          (cachedIssuesMap['issues'] as List)
              .map((issueJson) => IssueModel.fromJson(issueJson))
              .where((issue) {
                // Check if the issue is within the bounds
                return issue.latitude >= bounds.southwest.latitude &&
                    issue.latitude <= bounds.northeast.latitude &&
                    issue.longitude >= bounds.southwest.longitude &&
                    issue.longitude <= bounds.northeast.longitude;
              })
              .take(maxResults)
              .map(
                (issue) => IssueMarker(
                  issueId: issue.id,
                  latitude: issue.latitude,
                  longitude: issue.longitude,
                ),
              )
              .toList();

      return issues;
    } catch (e) {
      await clearCache();
      return [];
    }
  }

  @override
  Future<List<IssueModel>> searchIssues(String query) async {
    try {
      final cachedData = _prefs.getString(_issuesKey);
      if (cachedData == '') return [];

      final cachedIssuesMap = json.decode(cachedData) as Map<String, dynamic>;
      final issues =
          (cachedIssuesMap['issues'] as List)
              .map((issueJson) => IssueModel.fromJson(issueJson))
              .where((issue) {
                final searchable = [
                  issue.category.displayName,
                  issue.latitude.toString(),
                  issue.longitude.toString(),
                ].join(' ');
                return searchable.contains(query.toLowerCase());
              })
              .toList();

      return issues;
    } catch (e) {
      return [];
    }
  }
}
