import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_subscribed_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/subscribe_to_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/unsubscribe_from_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/paginated_areas_cubit.dart';

@module
abstract class AreaUpdatesPresentationModule {
 
  @injectable
  PaginatedAreasCubit providePaginatedAreasCubit(
    GetAllAreasUseCase getAllAreasUseCase,
    GetSubscribedAreasUseCase getSubscribedAreasUseCase,
    SubscribeToAreaUseCase subscribeToAreaUseCase,
    UnsubscribeFromAreaUseCase unsubscribeFromAreaUseCase,
  ) => PaginatedAreasCubit(
    getAllAreasUseCase: getAllAreasUseCase,
    getSubscribedAreasUseCase: getSubscribedAreasUseCase,
    subscribeToAreaUseCase: subscribeToAreaUseCase,
    unsubscribeFromAreaUseCase: unsubscribeFromAreaUseCase,
  );
}
