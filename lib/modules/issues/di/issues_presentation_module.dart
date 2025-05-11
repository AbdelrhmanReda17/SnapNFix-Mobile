import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/issues/domain/usecases/watch_nearby_issues_use_case.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_issue_details_use_case.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_cubit.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issue_details_cubit.dart';

@module
abstract class IssuesPresentationModule {
  @factoryMethod
  IssuesMapCubit provideIssuesMapCubit(
    WatchNearbyIssuesUseCase watchNearbyIssuesUseCase,
  ) => IssuesMapCubit(watchNearbyIssuesUseCase);

  @factoryMethod
  IssueDetailsCubit provideIssueDetailsCubit(
    GetIssueDetailsUseCase getIssueDetailsUseCase,
  ) => IssueDetailsCubit(getIssueDetailsUseCase: getIssueDetailsUseCase);
}
