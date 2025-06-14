// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../index.dart' as _i986;
import '../../modules/authentication/data/datasources/authentication_remote_data_source.dart'
    as _i771;
import '../../modules/authentication/di/authentication_data_module.dart'
    as _i65;
import '../../modules/authentication/di/authentication_presentation_module.dart'
    as _i632;
import '../../modules/authentication/di/authentication_repository_module.dart'
    as _i361;
import '../../modules/authentication/di/authentication_usecase_module.dart'
    as _i796;
import '../../modules/authentication/domain/providers/social_authentication_provider.dart'
    as _i183;
import '../../modules/authentication/domain/repositories/base_authentication_repository.dart'
    as _i668;
import '../../modules/authentication/domain/services/base_social_authentication_service.dart'
    as _i600;
import '../../modules/authentication/domain/usecases/login_use_case.dart'
    as _i243;
import '../../modules/authentication/domain/usecases/logout_use_case.dart'
    as _i219;
import '../../modules/authentication/domain/usecases/register_use_case.dart'
    as _i154;
import '../../modules/authentication/domain/usecases/request_otp_use_case.dart'
    as _i460;
import '../../modules/authentication/domain/usecases/resend_otp_use_case.dart'
    as _i998;
import '../../modules/authentication/domain/usecases/reset_password_use_case.dart'
    as _i956;
import '../../modules/authentication/domain/usecases/social_sign_in_use_case.dart'
    as _i958;
import '../../modules/authentication/domain/usecases/verify_otp_use_case.dart'
    as _i21;
import '../../modules/authentication/presentation/cubits/complete_profile/complete_profile_cubit.dart'
    as _i12;
import '../../modules/authentication/presentation/cubits/forget_password/forgot_password_cubit.dart'
    as _i13;
import '../../modules/authentication/presentation/cubits/login/login_cubit.dart'
    as _i862;
import '../../modules/authentication/presentation/cubits/otp/otp_cubit.dart'
    as _i328;
import '../../modules/authentication/presentation/cubits/register/register_cubit.dart'
    as _i484;
import '../../modules/authentication/presentation/cubits/reset_password/reset_password_cubit.dart'
    as _i1033;
import '../../modules/issues/data/datasource/issue_local_data_source.dart'
    as _i912;
import '../../modules/issues/data/datasource/issue_remote_data_source.dart'
    as _i193;
import '../../modules/issues/di/issues_data_module.dart' as _i962;
import '../../modules/issues/di/issues_presentation_module.dart' as _i519;
import '../../modules/issues/di/issues_repository_module.dart' as _i629;
import '../../modules/issues/di/issues_usecase_module.dart' as _i528;
import '../../modules/issues/domain/repositories/base_issue_repository.dart'
    as _i185;
import '../../modules/issues/domain/usecases/get_area_issues_use_case.dart'
    as _i735;
import '../../modules/issues/domain/usecases/get_issue_details_use_case.dart'
    as _i39;
import '../../modules/issues/domain/usecases/get_nearby_issues_use_case.dart'
    as _i222;
import '../../modules/issues/domain/usecases/get_user_issues_use_case.dart'
    as _i417;
import '../../modules/issues/presentation/cubits/issue_details_cubit.dart'
    as _i366;
import '../../modules/issues/presentation/cubits/issues_map_cubit.dart'
    as _i240;
import '../../modules/reports/data/datasources/report_local_data_source.dart'
    as _i810;
import '../../modules/reports/data/datasources/report_remote_data_source.dart'
    as _i71;
import '../../modules/reports/di/reports_data_module.dart' as _i922;
import '../../modules/reports/di/reports_presentation_module.dart' as _i699;
import '../../modules/reports/di/reports_repository_module.dart' as _i717;
import '../../modules/reports/di/reports_usecase_module.dart' as _i873;
import '../../modules/reports/domain/repositories/base_report_repository.dart'
    as _i515;
import '../../modules/reports/domain/usecases/get_issue_fast_reports_use_case.dart'
    as _i1007;
import '../../modules/reports/domain/usecases/get_issue_snap_reports_use_case.dart'
    as _i610;
import '../../modules/reports/domain/usecases/get_pending_reports_count_use_case.dart'
    as _i742;
import '../../modules/reports/domain/usecases/get_report_statistics_use_case.dart'
    as _i36;
import '../../modules/reports/domain/usecases/get_user_reports_use_case.dart'
    as _i412;
import '../../modules/reports/domain/usecases/submit_fast_report_use_case.dart'
    as _i773;
import '../../modules/reports/domain/usecases/submit_report_use_case.dart'
    as _i628;
import '../../modules/reports/domain/usecases/sync_prending_reports_use_case.dart'
    as _i956;
import '../../modules/reports/domain/usecases/watch_pending_reports_count_use_case.dart'
    as _i500;
import '../../modules/reports/presentation/cubits/issue_fast_reports_cubit.dart'
    as _i948;
import '../../modules/reports/presentation/cubits/issue_snap_reports_cubit.dart'
    as _i987;
import '../../modules/reports/presentation/cubits/report_statistics_cubit.dart'
    as _i303;
import '../../modules/reports/presentation/cubits/submit_fast_report_cubit.dart'
    as _i312;
import '../../modules/reports/presentation/cubits/submit_report_cubit.dart'
    as _i758;
import '../../modules/reports/presentation/cubits/user_reports_cubit.dart'
    as _i977;
import '../../modules/settings/data/datasources/settings_remote_data_source.dart'
    as _i14;
import '../../modules/settings/di/settings_data_module.dart' as _i993;
import '../../modules/settings/di/settings_presentation_module.dart' as _i247;
import '../../modules/settings/di/settings_repository_module.dart' as _i606;
import '../../modules/settings/di/settings_usecase_module.dart' as _i422;
import '../../modules/settings/domain/repositories/base_settings_repository.dart'
    as _i150;
import '../../modules/settings/domain/usecases/edit_profile_use_case.dart'
    as _i182;
import '../../modules/settings/presentation/cubits/edit_profile_cubit.dart'
    as _i382;
import '../../presentation/navigation/navigation_service.dart' as _i579;
import '../config/application_configurations.dart' as _i420;
import '../infrastructure/connectivity/connectivity_service.dart' as _i1041;
import '../infrastructure/device_info/device_info_service.dart' as _i871;
import '../infrastructure/device_info/di/device_info_module.dart' as _i984;
import '../infrastructure/location/di/location_module.dart' as _i699;
import '../infrastructure/location/location_permission_handler.dart' as _i658;
import '../infrastructure/location/location_service.dart' as _i636;
import '../infrastructure/messaging/di/fcm_module.dart' as _i727;
import '../infrastructure/messaging/fcm_service.dart' as _i458;
import '../infrastructure/networking/api_service.dart' as _i666;
import '../infrastructure/networking/di/manager_module.dart' as _i441;
import '../infrastructure/networking/di/network_module.dart' as _i358;
import '../infrastructure/networking/interceptors/token_refresh_interceptor.dart'
    as _i846;
import '../infrastructure/networking/managers/base_token_manager.dart' as _i990;
import '../infrastructure/storage/secure_storage_service.dart' as _i783;
import '../infrastructure/storage/shared_preferences_service.dart' as _i835;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final fCMModule = _$FCMModule();
    final networkModule = _$NetworkModule();
    final reportsDataModule = _$ReportsDataModule();
    final authenticationDataModule = _$AuthenticationDataModule();
    final locationModule = _$LocationModule();
    final deviceInfoModule = _$DeviceInfoModule();
    final issuesDataModule = _$IssuesDataModule();
    final managerModule = _$ManagerModule();
    final settingsDataModule = _$SettingsDataModule();
    final issuesRepositoryModule = _$IssuesRepositoryModule();
    final reportsRepositoryModule = _$ReportsRepositoryModule();
    final settingsRepositoryModule = _$SettingsRepositoryModule();
    final issuesUsecaseModule = _$IssuesUsecaseModule();
    final issuesPresentationModule = _$IssuesPresentationModule();
    final authenticationRepositoryModule = _$AuthenticationRepositoryModule();
    final reportsUsecaseModule = _$ReportsUsecaseModule();
    final reportsPresentationModule = _$ReportsPresentationModule();
    final settingsUsecaseModule = _$SettingsUsecaseModule();
    final settingsPresentationModule = _$SettingsPresentationModule();
    final authenticationUseCaseModule = _$AuthenticationUseCaseModule();
    final authenticationPresentationModule =
        _$AuthenticationPresentationModule();
    gh.singleton<_i1041.ConnectivityService>(
        () => _i1041.ConnectivityService());
    gh.singleton<_i636.LocationService>(() => _i636.LocationService());
    gh.singleton<_i458.FCMService>(() => fCMModule.provideFCMService());
    gh.singleton<_i361.Dio>(() => networkModule.provideDio());
    gh.singleton<_i783.SecureStorageService>(
        () => _i783.SecureStorageService());
    gh.singleton<_i835.SharedPreferencesService>(
        () => _i835.SharedPreferencesService());
    gh.lazySingleton<_i810.BaseReportLocalDataSource>(
        () => reportsDataModule.provideReportLocalDataSource());
    gh.lazySingleton<_i579.NavigationService>(() => _i579.NavigationService());
    gh.singleton<_i183.BaseSocialAuthenticationProvider>(
      () => authenticationDataModule.provideFacebookAuthProvider(),
      instanceName: 'facebookProvider',
    );
    gh.singleton<_i183.BaseSocialAuthenticationProvider>(
      () => authenticationDataModule.provideGoogleAuthProvider(),
      instanceName: 'googleProvider',
    );
    gh.lazySingleton<_i658.LocationPermissionHandler>(() => locationModule
        .provideLocationPermissionHandler(gh<_i636.LocationService>()));
    gh.singleton<_i420.ApplicationConfigurations>(
        () => _i420.ApplicationConfigurations(
              gh<_i986.SharedPreferencesService>(),
              gh<_i986.SecureStorageService>(),
            ));
    await gh.singletonAsync<_i871.DeviceInfoService>(
      () => deviceInfoModule.provideDeviceInfoService(gh<_i458.FCMService>()),
      preResolve: true,
    );
    gh.lazySingleton<_i912.BaseIssueLocalDataSource>(() => issuesDataModule
        .provideIssueLocalDataSource(gh<_i835.SharedPreferencesService>()));
    gh.singleton<_i990.BaseTokenManager>(() => managerModule
        .provideTokenManager(gh<_i420.ApplicationConfigurations>()));
    gh.singleton<_i846.TokenRefreshInterceptor>(() => networkModule
        .provideTokenRefreshInterceptor(gh<_i990.BaseTokenManager>()));
    gh.singleton<_i600.BaseSocialAuthenticationService>(
        () => authenticationDataModule.provideSocialAuthService(
              gh<_i183.BaseSocialAuthenticationProvider>(
                  instanceName: 'googleProvider'),
              gh<_i183.BaseSocialAuthenticationProvider>(
                  instanceName: 'facebookProvider'),
            ));
    gh.singleton<_i666.ApiService>(() => networkModule.provideApiService(
          gh<_i361.Dio>(),
          gh<_i846.TokenRefreshInterceptor>(),
        ));
    gh.lazySingleton<_i193.BaseIssueRemoteDataSource>(() =>
        issuesDataModule.provideIssueRemoteDataSource(gh<_i666.ApiService>()));
    gh.lazySingleton<_i71.BaseReportRemoteDataSource>(() => reportsDataModule
        .provideReportRemoteDataSource(gh<_i666.ApiService>()));
    gh.lazySingleton<_i14.BaseSettingsRemoteDataSource>(() => settingsDataModule
        .provideSettingsRemoteDataSource(gh<_i666.ApiService>()));
    gh.lazySingleton<_i185.BaseIssueRepository>(
        () => issuesRepositoryModule.provideIssueRepository(
              gh<_i193.BaseIssueRemoteDataSource>(),
              gh<_i912.BaseIssueLocalDataSource>(),
              gh<_i636.LocationService>(),
            ));
    gh.singleton<_i771.BaseAuthenticationRemoteDataSource>(
        () => authenticationDataModule.provideAuthRemoteDataSource(
              gh<_i666.ApiService>(),
              gh<_i871.DeviceInfoService>(),
            ));
    gh.lazySingleton<_i515.BaseReportRepository>(
        () => reportsRepositoryModule.provideReportRepository(
              gh<_i810.BaseReportLocalDataSource>(),
              gh<_i71.BaseReportRemoteDataSource>(),
              gh<_i1041.ConnectivityService>(),
            ));
    gh.factory<_i36.GetReportStatisticsUseCase>(() =>
        _i36.GetReportStatisticsUseCase(gh<_i515.BaseReportRepository>()));
    gh.lazySingleton<_i150.BaseSettingsRepository>(
        () => settingsRepositoryModule.provideSettingsRepository(
              gh<_i14.BaseSettingsRemoteDataSource>(),
              gh<_i420.ApplicationConfigurations>(),
            ));
    gh.lazySingleton<_i222.GetNearbyIssuesUseCase>(() => issuesUsecaseModule
        .provideGetNearbyIssuesUseCase(gh<_i185.BaseIssueRepository>()));
    gh.lazySingleton<_i39.GetIssueDetailsUseCase>(() => issuesUsecaseModule
        .provideGetIssueDetailsUseCase(gh<_i185.BaseIssueRepository>()));
    gh.lazySingleton<_i417.GetUserIssuesUseCase>(() => issuesUsecaseModule
        .provideGetUserIssuesUseCase(gh<_i185.BaseIssueRepository>()));
    gh.lazySingleton<_i735.GetAreaIssuesUseCase>(() => issuesUsecaseModule
        .provideGetAreaIssuesUseCase(gh<_i185.BaseIssueRepository>()));
    gh.factory<_i240.IssuesMapCubit>(() => issuesPresentationModule
        .provideIssuesMapCubit(gh<_i222.GetNearbyIssuesUseCase>()));
    gh.singleton<_i668.BaseAuthenticationRepository>(
        () => authenticationRepositoryModule.provideAuthRepository(
              gh<_i771.BaseAuthenticationRemoteDataSource>(),
              gh<_i600.BaseSocialAuthenticationService>(),
              gh<_i420.ApplicationConfigurations>(),
            ));
    gh.lazySingleton<_i628.SubmitReportUseCase>(() => reportsUsecaseModule
        .provideSubmitReportUseCase(gh<_i515.BaseReportRepository>()));
    gh.lazySingleton<_i773.SubmitFastReportUseCase>(() => reportsUsecaseModule
        .provideSubmitFastReportUseCase(gh<_i515.BaseReportRepository>()));
    gh.lazySingleton<_i956.SyncPendingReportsUseCase>(() => reportsUsecaseModule
        .provideSyncPendingReportsUseCase(gh<_i515.BaseReportRepository>()));
    gh.lazySingleton<_i500.WatchPendingReportsCountUseCase>(() =>
        reportsUsecaseModule.provideWatchPendingReportsCountUseCase(
            gh<_i515.BaseReportRepository>()));
    gh.lazySingleton<_i742.GetPendingReportsCountUseCase>(() =>
        reportsUsecaseModule.provideGetPendingReportsCountUseCase(
            gh<_i515.BaseReportRepository>()));
    gh.lazySingleton<_i412.GetUserReportsUseCase>(() => reportsUsecaseModule
        .provideGetUserReportsUseCase(gh<_i515.BaseReportRepository>()));
    gh.lazySingleton<_i1007.GetIssueFastReportsUseCase>(() =>
        reportsUsecaseModule.provideGetIssueFastReportsUseCase(
            gh<_i515.BaseReportRepository>()));
    gh.lazySingleton<_i610.GetIssueSnapReportsUseCase>(() =>
        reportsUsecaseModule.provideGetIssueSnapReportsUseCase(
            gh<_i515.BaseReportRepository>()));
    gh.factory<_i948.IssueFastReportsCubit>(() => reportsPresentationModule
        .provideUserReportsCubit(gh<_i1007.GetIssueFastReportsUseCase>()));
    gh.lazySingleton<_i182.EditProfileUseCase>(() => settingsUsecaseModule
        .provideEditProfileUseCase(gh<_i150.BaseSettingsRepository>()));
    gh.factory<_i303.ReportStatisticsCubit>(() =>
        _i303.ReportStatisticsCubit(gh<_i36.GetReportStatisticsUseCase>()));
    gh.factory<_i366.IssueDetailsCubit>(() => issuesPresentationModule
        .provideIssueDetailsCubit(gh<_i39.GetIssueDetailsUseCase>()));
    gh.factory<_i987.IssueSnapReportsCubit>(() => reportsPresentationModule
        .provideIssueSnapReportsCubit(gh<_i610.GetIssueSnapReportsUseCase>()));
    gh.factory<_i758.SubmitReportCubit>(() => reportsPresentationModule
        .provideSubmitReportCubit(gh<_i628.SubmitReportUseCase>()));
    gh.factory<_i312.SubmitFastReportCubit>(() => reportsPresentationModule
        .provideSubmitFastReportCubit(gh<_i773.SubmitFastReportUseCase>()));
    gh.factory<_i382.EditProfileCubit>(() => settingsPresentationModule
        .provideEditProfileCubit(gh<_i182.EditProfileUseCase>()));
    gh.factory<_i243.LoginUseCase>(() => authenticationUseCaseModule
        .provideLoginUseCase(gh<_i668.BaseAuthenticationRepository>()));
    gh.factory<_i460.RequestOTPUseCase>(() => authenticationUseCaseModule
        .provideRequestOTPUseCase(gh<_i668.BaseAuthenticationRepository>()));
    gh.factory<_i21.VerifyOtpUseCase>(() => authenticationUseCaseModule
        .provideVerifyOtpUseCase(gh<_i668.BaseAuthenticationRepository>()));
    gh.factory<_i998.ResendOtpUseCase>(() => authenticationUseCaseModule
        .provideResendOtpUseCase(gh<_i668.BaseAuthenticationRepository>()));
    gh.factory<_i956.ResetPasswordUseCase>(() => authenticationUseCaseModule
        .provideResetPasswordUseCase(gh<_i668.BaseAuthenticationRepository>()));
    gh.factory<_i154.CompleteProfileUseCase>(() =>
        authenticationUseCaseModule.provideCompleteProfileUseCase(
            gh<_i668.BaseAuthenticationRepository>()));
    gh.factory<_i958.SocialSignInUseCase>(() => authenticationUseCaseModule
        .provideSocialSignInUseCase(gh<_i668.BaseAuthenticationRepository>()));
    gh.factory<_i219.LogoutUseCase>(() => authenticationUseCaseModule
        .provideLogoutUseCase(gh<_i668.BaseAuthenticationRepository>()));
    gh.factory<_i977.UserReportsCubit>(() => reportsPresentationModule
        .provideReportReviewCubit(gh<_i412.GetUserReportsUseCase>()));
    gh.factory<_i862.LoginCubit>(
        () => authenticationPresentationModule.provideLoginCubit(
              gh<_i243.LoginUseCase>(),
              gh<_i958.SocialSignInUseCase>(),
            ));
    gh.factory<_i1033.ResetPasswordCubit>(() => authenticationPresentationModule
        .provideResendOtpCubit(gh<_i956.ResetPasswordUseCase>()));
    gh.factory<_i12.CompleteProfileCubit>(() => authenticationPresentationModule
        .provideCompleteProfileCubit(gh<_i154.CompleteProfileUseCase>()));
    gh.factory<_i13.ForgotPasswordCubit>(() => authenticationPresentationModule
        .provideForgotPasswordCubit(gh<_i460.RequestOTPUseCase>()));
    gh.factory<_i328.OtpCubit>(
        () => authenticationPresentationModule.provideOtpCubit(
              gh<_i21.VerifyOtpUseCase>(),
              gh<_i998.ResendOtpUseCase>(),
            ));
    gh.factory<_i484.RegisterCubit>(() => authenticationPresentationModule
        .provideRegisterCubit(gh<_i460.RequestOTPUseCase>()));
    return this;
  }
}

class _$FCMModule extends _i727.FCMModule {}

class _$NetworkModule extends _i358.NetworkModule {}

class _$ReportsDataModule extends _i922.ReportsDataModule {}

class _$AuthenticationDataModule extends _i65.AuthenticationDataModule {}

class _$LocationModule extends _i699.LocationModule {}

class _$DeviceInfoModule extends _i984.DeviceInfoModule {}

class _$IssuesDataModule extends _i962.IssuesDataModule {}

class _$ManagerModule extends _i441.ManagerModule {}

class _$SettingsDataModule extends _i993.SettingsDataModule {}

class _$IssuesRepositoryModule extends _i629.IssuesRepositoryModule {}

class _$ReportsRepositoryModule extends _i717.ReportsRepositoryModule {}

class _$SettingsRepositoryModule extends _i606.SettingsRepositoryModule {}

class _$IssuesUsecaseModule extends _i528.IssuesUsecaseModule {}

class _$IssuesPresentationModule extends _i519.IssuesPresentationModule {}

class _$AuthenticationRepositoryModule
    extends _i361.AuthenticationRepositoryModule {}

class _$ReportsUsecaseModule extends _i873.ReportsUsecaseModule {}

class _$ReportsPresentationModule extends _i699.ReportsPresentationModule {}

class _$SettingsUsecaseModule extends _i422.SettingsUsecaseModule {}

class _$SettingsPresentationModule extends _i247.SettingsPresentationModule {}

class _$AuthenticationUseCaseModule extends _i796.AuthenticationUseCaseModule {}

class _$AuthenticationPresentationModule
    extends _i632.AuthenticationPresentationModule {}
