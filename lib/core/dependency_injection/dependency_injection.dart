import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/infrastructure/device_info/device_info_service.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:snapnfix/modules/authentication/data/repositories/authentication_repository.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/forgot_password_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/login_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/logout_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/register_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/resend_otp_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/reset_password_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/verify_otp_use_case.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/forget_password/forgot_password_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/login/login_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/register/register_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_local_data_source.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_remote_data_source.dart';
import 'package:snapnfix/modules/issues/data/repositories/issue_repository.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_issue_details_use_case.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_nearby_issues_use_case.dart';
import 'package:snapnfix/modules/issues/domain/usecases/get_user_issues_use_case.dart';
import 'package:snapnfix/modules/issues/domain/usecases/watch_nearby_issues_use_case.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_cubit.dart';
import 'package:snapnfix/modules/reports/data/datasource/report_local_data_source.dart';
import 'package:snapnfix/modules/reports/data/datasource/report_remote_data_source.dart';
import 'package:snapnfix/modules/reports/data/repositories/report_repository.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_pending_reports_count_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/submit_report_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/sync_prending_reports_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/watch_pending_reports_count_use_case.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';
import 'package:snapnfix/modules/settings/data/datasources/settings_remote_data_source.dart';
import 'package:snapnfix/modules/settings/data/repositories/settings_repository_impl.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';
import 'package:snapnfix/modules/settings/domain/usecases/change_password_use_case.dart';
import 'package:snapnfix/modules/settings/domain/usecases/edit_profile_use_case.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/change_password_cubit.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';
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
  setupReportsModule();
  setupAuthenticationModule();
  setupIssuesModule();
  setupSettingsModule();

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

void setupAuthenticationModule() {
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
    () => LoginCubit(
      loginUseCase: getIt<LoginUseCase>(),
      forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
    ),
  );

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(registerUseCase: getIt<RegisterUseCase>()),
  );

  getIt.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(getIt<BaseAuthenticationRepository>()),
  );

  getIt.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(getIt<BaseAuthenticationRepository>()),
  );

  getIt.registerLazySingleton<VerifyOtpUseCase>(
    () => VerifyOtpUseCase(getIt<BaseAuthenticationRepository>()),
  );

  getIt.registerLazySingleton<ResendOtpUseCase>(
    () => ResendOtpUseCase(getIt<BaseAuthenticationRepository>()),
  );

  getIt.registerFactory<OtpCubit>(
    () => OtpCubit(
      verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
      resendOtpUseCase: getIt<ResendOtpUseCase>(),
    ),
  );

  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(
      forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
    ),
  );

  getIt.registerFactory<ResetPasswordCubit>(
    () =>
        ResetPasswordCubit(resetPasswordUseCase: getIt<ResetPasswordUseCase>()),
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

  // Location Service
  getIt.registerLazySingleton<LocationService>(() => LocationService());

  // Device info Service
  getIt.registerLazySingleton<DeviceInfoService>(() => DeviceInfoService());
}

void setupReportsModule() {
  // DataSources
  getIt.registerLazySingleton<BaseReportRemoteDataSource>(
    () => ReportRemoteDataSource(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<BaseReportLocalDataSource>(
    () => ReportLocalDataSource(getIt<SharedPreferencesService>()),
  );

  // Repository
  getIt.registerLazySingleton<BaseReportRepository>(
    () => ReportRepository(
      getIt<BaseReportLocalDataSource>(),
      getIt<BaseReportRemoteDataSource>(),
      getIt<ConnectivityService>(),
    ),
  );

  // UseCases
  getIt.registerLazySingleton<SubmitReportUseCase>(
    () => SubmitReportUseCase(getIt<BaseReportRepository>()),
  );

  getIt.registerLazySingleton<SyncPendingReportsUseCase>(
    () => SyncPendingReportsUseCase(getIt<BaseReportRepository>()),
  );

  getIt.registerLazySingleton<GetPendingReportsCountUseCase>(
    () => GetPendingReportsCountUseCase(getIt<BaseReportRepository>()),
  );

  getIt.registerLazySingleton<WatchPendingReportsCountUseCase>(
    () => WatchPendingReportsCountUseCase(getIt<BaseReportRepository>()),
  );

  // Cubits
  getIt.registerFactory<SubmitReportCubit>(
    () => SubmitReportCubit(getIt<SubmitReportUseCase>()),
  );
}

void setupSettingsModule() {
  // DataSources
  getIt.registerLazySingleton<BaseSettingsRemoteDataSource>(
    () => SettingsRemoteDataSource(getIt<ApiService>()),
  );

  // Repositories - Use the base abstract repository
  getIt.registerLazySingleton<BaseSettingsRepository>(
    () => SettingsRepositoryImpl(getIt<BaseSettingsRemoteDataSource>()),
  );

  // UseCases
  getIt.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(getIt<BaseSettingsRepository>()),
  );

  getIt.registerLazySingleton<EditProfileUseCase>(
    () => EditProfileUseCase(getIt<BaseSettingsRepository>()),
  );

  // Cubits
  getIt.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(
      changePasswordUseCase: getIt<ChangePasswordUseCase>(),
    ),
  );

  getIt.registerFactory<EditProfileCubit>(
    () => EditProfileCubit(editProfileUseCase: getIt<EditProfileUseCase>()),
  );
}

void setupIssuesModule() {
  // DataSources
  getIt.registerLazySingleton<BaseIssueRemoteDataSource>(
    () => IssueRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<BaseIssueLocalDataSource>(
    () => IssueLocalDataSource(getIt<SharedPreferencesService>()),
  );

  // Repository
  getIt.registerLazySingleton<BaseIssueRepository>(
    () => IssueRepository(
      remoteDataSource: getIt<BaseIssueRemoteDataSource>(),
      localDataSource: getIt<BaseIssueLocalDataSource>(),
      locationService: getIt<LocationService>(),
    ),
  );

  // UseCases
  getIt.registerLazySingleton<GetIssueDetailsUseCase>(
    () => GetIssueDetailsUseCase(getIt<BaseIssueRepository>()),
  );

  getIt.registerLazySingleton<GetNearbyIssuesUseCase>(
    () => GetNearbyIssuesUseCase(getIt<BaseIssueRepository>()),
  );

  getIt.registerLazySingleton<GetUserIssuesUseCase>(
    () => GetUserIssuesUseCase(getIt<BaseIssueRepository>()),
  );

  getIt.registerLazySingleton<WatchNearbyIssuesUseCase>(
    () => WatchNearbyIssuesUseCase(getIt<BaseIssueRepository>()),
  );

  // Cubits
  getIt.registerFactory<IssuesMapCubit>(
    () => IssuesMapCubit(
      getIt<LocationService>(),
      getIt<WatchNearbyIssuesUseCase>(),
    ),
  );
}
