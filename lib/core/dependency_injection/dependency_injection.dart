import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:snapnfix/core/application_router.dart';
import 'package:snapnfix/core/networking/api_constants.dart';
import 'package:snapnfix/core/networking/api_service.dart';
import 'package:snapnfix/core/networking/dio_factory.dart';
import 'package:snapnfix/core/services/connectivity_service.dart';
import 'package:snapnfix/core/services/secure_storage_service.dart';
import 'package:snapnfix/core/services/shared_preferences_service.dart';
import 'package:snapnfix/features/authentication/data/repository/login_repository.dart';
import 'package:snapnfix/features/authentication/data/repository/sign_up_repository.dart';
import 'package:snapnfix/features/authentication/logic/cubit/login_cubit.dart';
import 'package:snapnfix/features/authentication/logic/cubit/sign_up_cubit.dart';
import 'package:snapnfix/features/reports/data/repository/add_report_repository.dart';
import 'package:snapnfix/features/reports/data/repository/offline_reports_repository.dart';
import 'package:snapnfix/features/reports/logic/cubit/add_report_cubit.dart';
import 'package:snapnfix/features/settings/data/repository/change_password_repository.dart';
import 'package:snapnfix/features/settings/data/repository/edit_profile_repository.dart';
import 'package:snapnfix/features/settings/logic/cubit/change_password_cubit.dart';
import 'package:snapnfix/features/settings/logic/cubit/edit_profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();

  // Register Services
  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  // Register SharedPreferences with async initialization
  final sharedPrefsService = SharedPreferencesService();
  await sharedPrefsService.init();
  getIt.registerSingleton<SharedPreferencesService>(sharedPrefsService);

  // Register Configurations and Router
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

  // Register Repositories and Cubits
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

  getIt.registerLazySingleton<AddReportRepository>(
    () => AddReportRepository(
      getIt<ApiService>(),
      getIt<ConnectivityService>(),
      getIt<OfflineReportsRepository>(),
    ),
  );

  getIt.registerLazySingleton<OfflineReportsRepository>(
    () => OfflineReportsRepository(getIt<SharedPreferencesService>()),
  );

  getIt.registerFactory<AddReportCubit>(
    () => AddReportCubit(
      getIt<AddReportRepository>(),
    ),
  );

  return Future.value();
}
