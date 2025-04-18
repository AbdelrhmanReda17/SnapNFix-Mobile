import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:snapnfix/core/application_router.dart';
import 'package:snapnfix/core/networking/api_constants.dart';
import 'package:snapnfix/core/networking/api_service.dart';
import 'package:snapnfix/core/networking/dio_factory.dart';
import 'package:snapnfix/features/authentication/data/repository/login_repository.dart';
import 'package:snapnfix/features/authentication/data/repository/sign_up_repository.dart';
import 'package:snapnfix/features/authentication/logic/cubit/login_cubit.dart';
import 'package:snapnfix/features/authentication/logic/cubit/sign_up_cubit.dart';
import 'package:snapnfix/features/settings/data/repos/change_password_repository.dart';
import 'package:snapnfix/features/settings/data/repos/edit_profile_repository.dart';
import 'package:snapnfix/features/settings/logic/cubit/change_password_cubit.dart';
import 'package:snapnfix/features/settings/logic/cubit/edit_profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() {
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<ApplicationConfigurations>(
    () => ApplicationConfigurations(),
  );
  getIt.registerLazySingleton<ApplicationRouter>(
    () => ApplicationRouter(
      appConfigurations: getIt<ApplicationConfigurations>(),
    ),
  );
  getIt.registerLazySingleton<GoRouter>(
    () => getIt<ApplicationRouter>().router,
  );

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

  getIt.registerLazySingleton<ChangePasswordRepository>(
    () => ChangePasswordRepository(getIt<ApiService>()),
  );
  getIt.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(getIt()),
  );

  getIt.registerLazySingleton<EditProfileRepository>(
    () => EditProfileRepository(getIt<ApiService>()),
  );

  getIt.registerFactory<EditProfileCubit>(
    () => EditProfileCubit(getIt<EditProfileRepository>()),
  );

  return Future.value();
}
