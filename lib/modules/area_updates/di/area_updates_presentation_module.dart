import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/all_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_cubit.dart';

@module
abstract class AreaUpdatesPresentationModule {
  @injectable
  AreaSubscriptionCubit provideAreaSubscriptionCubit(
    BaseAreaUpdatesRepository repository,
  ) => AreaSubscriptionCubit(repository);

  @injectable
  AllAreasCubit provideAllAreasCubit(
    BaseAreaUpdatesRepository repository,
  ) => AllAreasCubit(repository);
}
