import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:snapnfix/modules/authentication/data/repositories/authentication_repository.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/login_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/logout_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/register_use_case.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/login/login_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/register/register_cubit.dart';
import 'package:snapnfix/presentation/navigation/application_router.dart';
import 'package:snapnfix/core/infrastructure/networking/api_constants.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/core/infrastructure/networking/dio_factory.dart';
import 'package:snapnfix/core/infrastructure/connectivity/connectivity_service.dart';
import 'package:snapnfix/core/infrastructure/storage/secure_storage_service.dart';
import 'package:snapnfix/core/infrastructure/storage/shared_preferences_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Register services first
  await setupServices();

  // Register application configurations immediately
  setupAppConfigurations();

  // Now register router which depends on configurations
  setupRouter();

  // Register networking components
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(dio, baseUrl: ApiConstants.apiBaseUrl),
  );

  // Register authentication dependencies
  setupAuthenticationGetIt();

  return Future.value();
}

void setupAppConfigurations() {
  // Explicitly register ApplicationConfigurations first
  getIt.registerLazySingleton<ApplicationConfigurations>(
    () => ApplicationConfigurations(),
  );

  // Initialize application configurations
  getIt<ApplicationConfigurations>();
}

void setupRouter() {
  // Register Router - depends on ApplicationConfigurations
  getIt.registerLazySingleton<ApplicationRouter>(
    () => ApplicationRouter(
      appConfigurations: getIt<ApplicationConfigurations>(),
    ),
  );

  // Register GoRouter
  getIt.registerLazySingleton<GoRouter>(
    () => getIt<ApplicationRouter>().router,
  );
}

void setupAuthenticationGetIt() {
  // Register Data Sources & Repository
  getIt.registerLazySingleton<BaseAuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSource(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<BaseAuthenticationRepository>(
    () => AuthenticationRepository(getIt<BaseAuthenticationRemoteDataSource>()),
  );

  // Register Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<BaseAuthenticationRepository>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<BaseAuthenticationRepository>()),
  );

  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<BaseAuthenticationRepository>()),
  );

  // Register Cubits
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(loginUseCase: getIt<LoginUseCase>()),
  );

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(registerUseCase: getIt<RegisterUseCase>()),
  );
}

Future<void> setupServices() async {
  // Connectivity Service
  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  // Secure Storage Service
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  // Shared Preferences Service
  final sharedPrefsService = SharedPreferencesService();
  await sharedPrefsService.init();
  getIt.registerSingleton<SharedPreferencesService>(sharedPrefsService);
}
