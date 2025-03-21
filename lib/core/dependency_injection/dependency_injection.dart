import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:snapnfix/core/networking/api_constants.dart';
import 'package:snapnfix/core/networking/api_service.dart';
import 'package:snapnfix/core/networking/dio_factory.dart';
import 'package:snapnfix/features/authentication/data/repository/login_repository.dart';
import 'package:snapnfix/features/authentication/data/repository/sign_up_repository.dart';
import 'package:snapnfix/features/authentication/logic/cubit/login_cubit.dart';
import 'package:snapnfix/features/authentication/logic/cubit/sign_up_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(dio, baseUrl: ApiConstants.apiBaseUrl),
  );
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepository(getIt<ApiService>()),
  );
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerLazySingleton<SignUpRepository>(
    () => SignUpRepository(getIt<ApiService>()),
  );
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  return Future.value();
}
