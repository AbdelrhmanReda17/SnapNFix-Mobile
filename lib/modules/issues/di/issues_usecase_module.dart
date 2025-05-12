import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';
import 'package:snapnfix/modules/issues/domain/usecases/watch_nearby_issues_use_case.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_issue_details_use_case.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_user_issues_use_case.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_area_issues_use_case.dart';

@module
abstract class IssuesUsecaseModule {
  @lazySingleton
  WatchNearbyIssuesUseCase provideWatchNearbyIssuesUseCase(
    BaseIssueRepository repository,
  ) => WatchNearbyIssuesUseCase(repository);

  @lazySingleton
  GetIssueDetailsUseCase provideGetIssueDetailsUseCase(
    BaseIssueRepository repository,
  ) => GetIssueDetailsUseCase(repository);

  @lazySingleton
  GetUserIssuesUseCase provideGetUserIssuesUseCase(
    BaseIssueRepository repository,
  ) => GetUserIssuesUseCase(repository);

  @lazySingleton
  GetAreaIssuesUseCase provideGetAreaIssuesUseCase(
    BaseIssueRepository repository,
  ) => GetAreaIssuesUseCase(repository);
}
