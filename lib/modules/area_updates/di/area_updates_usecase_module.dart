import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_area_details.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_area_health_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_area_specific_issues_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_subscribed_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/subscribe_to_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/toggle_area_subscription_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/unsubscribe_from_area_use_case.dart';

@module
abstract class AreaUpdatesUseCaseModule {
  @injectable
  GetSubscribedAreasUseCase provideGetSubscribedAreasUseCase(
    BaseAreaUpdatesRepository repository,
  ) => GetSubscribedAreasUseCase(repository);

  @injectable
  GetAllAreasUseCase provideGetAllAreasUseCase(
    BaseAreaUpdatesRepository repository,
  ) => GetAllAreasUseCase(repository);

  @injectable
  SubscribeToAreaUseCase provideSubscribeToAreaUseCase(
    BaseAreaUpdatesRepository repository,
  ) => SubscribeToAreaUseCase(repository);
  @injectable
  UnsubscribeFromAreaUseCase provideUnsubscribeFromAreaUseCase(
    BaseAreaUpdatesRepository repository,
  ) => UnsubscribeFromAreaUseCase(repository);

  @injectable
  ToggleAreaSubscriptionUseCase provideToggleAreaSubscriptionUseCase(
    BaseAreaUpdatesRepository repository,
  ) => ToggleAreaSubscriptionUseCase(repository);

  @injectable
  GetAreaDetailsUseCase provideGetAreaDetailsUseCase(
    BaseAreaUpdatesRepository repository,
  ) => GetAreaDetailsUseCase(repository);

  @injectable
  GetAreaHealthUseCase provideGetAreaHealthUseCase(
    BaseAreaUpdatesRepository repository,
  ) => GetAreaHealthUseCase(repository);

  @injectable
  GetAreaSpecificIssuesUseCase provideGetAreaSpecificIssuesUseCase(
    BaseAreaUpdatesRepository repository,
  ) => GetAreaSpecificIssuesUseCase(repository);
}
