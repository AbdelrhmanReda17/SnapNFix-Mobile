import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import '../../domain/repositories/base_authentication_repository.dart';

class AuthenticationRepository implements BaseAuthenticationRepository {
  final BaseAuthenticationRemoteDataSource remoteDataSource;
  AuthenticationRepository(this.remoteDataSource);

  @override
  Future<ApiResult<Session>> login({
    required String phoneOrEmail,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(phoneOrEmail, password);
      return result.when(
        success: (session) async {
          await getIt<ApplicationConfigurations>().setUserSession(session);
          return ApiResult.success(session as Session);
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<void> logout() async {
    try {
      await getIt<ApplicationConfigurations>().logout();
    } catch (e) {
      throw Exception('Failed to logout: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<Session>> register({
    required String fistName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final result = await remoteDataSource.register(
        fistName,
        lastName,
        phoneNumber,
        password,
        confirmPassword,
      );

      return result.when(
        success: (session) async {
          await getIt<ApplicationConfigurations>().setUserSession(session);
          return ApiResult.success(session);
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
  
  @override
  Future<ApiResult<Session>> verifyOtp({ required String code}) async {
    try {
      final result = await remoteDataSource.verifyOtp(code);
      
      return result.when(
        success: (session) async {
          await getIt<ApplicationConfigurations>().setUserSession(session);
          
          return ApiResult.success(session);
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> resendOtp() async {
    try {
      final result = await remoteDataSource.resendOtp();
      
      return result.when(
        success: (_) {
          return ApiResult.success(null);
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

}
