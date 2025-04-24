import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class WatchNearbyIssuesUseCase {
  final BaseIssueRepository _repository;

  WatchNearbyIssuesUseCase(this._repository);

  Stream<ApiResult<List<Issue>>> call(
    double latitude,
    double longitude, {
    double radius = 1.0,
  }) {
    log(
      'WatchNearbyIssuesUseCase called with latitude: $latitude, longitude: $longitude, radius: $radius',
    );
    return _repository.watchNearbyIssues(latitude, longitude, radius);
  }
}
