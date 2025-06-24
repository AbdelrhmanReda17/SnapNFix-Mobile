import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_subscribed_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/subscribe_to_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/unsubscribe_from_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/toggle_area_subscription_use_case.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/all_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_cubit.dart';

@module
abstract class AreaUpdatesPresentationModule {
  @injectable
  AreaSubscriptionCubit provideAreaSubscriptionCubit(
    GetSubscribedAreasUseCase getSubscribedAreasUseCase,
    SubscribeToAreaUseCase subscribeToAreaUseCase,
    UnsubscribeFromAreaUseCase unsubscribeFromAreaUseCase,
    ToggleAreaSubscriptionUseCase toggleAreaSubscriptionUseCase,
  ) => AreaSubscriptionCubit(
    getSubscribedAreasUseCase: getSubscribedAreasUseCase,
    subscribeToAreaUseCase: subscribeToAreaUseCase,
    unsubscribeFromAreaUseCase: unsubscribeFromAreaUseCase,
    toggleAreaSubscriptionUseCase: toggleAreaSubscriptionUseCase,
  );

  @injectable
  AllAreasCubit provideAllAreasCubit(
    GetAllAreasUseCase getAllAreasUseCase,
  ) => AllAreasCubit(
    getAllAreasUseCase: getAllAreasUseCase,
  );
}
