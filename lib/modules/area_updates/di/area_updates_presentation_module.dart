import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_area_details.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_subscribed_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/subscribe_to_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/toggle_area_subscription_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/unsubscribe_from_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/all_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_details/area_details_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_notifier.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/subscribed_areas_cubit.dart';

@module
abstract class AreaUpdatesPresentationModule {
  @singleton
  AreaSubscriptionNotifier provideAreaSubscriptionNotifier() =>
      AreaSubscriptionNotifier();


  @injectable
  AreaDetailsCubit provideAreaDetailsCubit(
    GetAreaDetailsUseCase  getAllAreasUseCase,
    ToggleAreaSubscriptionUseCase getSubscribedAreasUseCase,
    AreaSubscriptionNotifier areaSubscriptionNotifier,
  ) => AreaDetailsCubit(
    getAreaDetailsUseCase: getAllAreasUseCase,
    toggleAreaSubscriptionUseCase: getSubscribedAreasUseCase,
    subscriptionNotifier: areaSubscriptionNotifier,
  );

  @injectable
  AllAreasCubit provideAllAreasCubit(
    GetAllAreasUseCase getAllAreasUseCase,
    SubscribeToAreaUseCase subscribeToAreaUseCase,
    AreaSubscriptionNotifier areaSubscriptionNotifier,
  ) => AllAreasCubit(
    getAllAreasUseCase: getAllAreasUseCase,
    subscribeToAreaUseCase: subscribeToAreaUseCase,
    notifier: areaSubscriptionNotifier,
  );

  @injectable
  SubscribedAreasCubit provideSubscribedAreasCubit(
    GetSubscribedAreasUseCase getSubscribedAreasUseCase,
    UnsubscribeFromAreaUseCase unsubscribeFromAreaUseCase,
    AreaSubscriptionNotifier areaSubscriptionNotifier,
  ) => SubscribedAreasCubit(
    getSubscribedAreasUseCase: getSubscribedAreasUseCase,
    notifier: areaSubscriptionNotifier,

    unsubscribeFromAreaUseCase: unsubscribeFromAreaUseCase,
  );
}
