import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_subscribed_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/subscribe_to_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/unsubscribe_from_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/all_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/subscribed_areas_cubit.dart';

@module
abstract class AreaUpdatesPresentationModule {
  @injectable
  AllAreasCubit provideAllAreasCubit(
    GetAllAreasUseCase getAllAreasUseCase,
    SubscribeToAreaUseCase subscribeToAreaUseCase,
  ) => AllAreasCubit(
    getAllAreasUseCase: getAllAreasUseCase,
    subscribeToAreaUseCase: subscribeToAreaUseCase,
  );

  @injectable
  SubscribedAreasCubit provideSubscribedAreasCubit(
    GetSubscribedAreasUseCase getSubscribedAreasUseCase,
    UnsubscribeFromAreaUseCase unsubscribeFromAreaUseCase,
  ) => SubscribedAreasCubit(
    getSubscribedAreasUseCase: getSubscribedAreasUseCase,
    unsubscribeFromAreaUseCase: unsubscribeFromAreaUseCase,
  );

}
